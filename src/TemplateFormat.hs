module TemplateFormat where
import Data.List
import Data.Char
import qualified Data.Map as Map

type PyMethod = (String, String, [String])

evaluateMaybe :: String -> Maybe a -> a
evaluateMaybe _ (Just x) = x
evaluateMaybe err Nothing = error err

evaluateTokens :: String -> Map.Map String String -> String
evaluateTokens s token_map
    | length s < 5 = s
    | otherwise = case s of
        ('<':'@':rest) -> let
            (token,after_token) = splitAt (evaluateMaybe ("Char '@' not in string: " ++ rest) ('@' `elemIndex` rest)) rest in evaluateMaybe ("Token not in map: " ++ token) (Map.lookup token token_map) ++ evaluateTokens (drop 2 after_token) token_map
        (c:rest) -> c : evaluateTokens rest token_map

returnCode :: String -> String
returnCode s = case s of
    [] -> "// None return"
    _  -> "// other return"

camelToSnakeCase :: String -> String
camelToSnakeCase [] = ""
camelToSnakeCase [c] = [toLower c]
camelToSnakeCase (c1:c2:s)
    | isLower c1 && isUpper c2 = c1 :'_' : toLower c2 : camelToSnakeCase s
    | otherwise = toLower c1 : toLower c2 : camelToSnakeCase s

generateMethodImpl :: PyMethod -> Map.Map String String -> IO String
generateMethodImpl (method_name, return_type, args) token_map = do
    method_impl_template <- readFile "src/templates/method_implementation.tmpl"
    return $ evaluateTokens method_impl_template $ Map.insert "method_name" method_name $ Map.insert "return" (returnCode return_type) token_map

generateMethodDef :: PyMethod -> Map.Map String String -> IO String
generateMethodDef (method_name, return_type, args) token_map = do
    method_def_template <- readFile "src/templates/method_definition.tmpl"
    return $ evaluateTokens method_def_template $ Map.insert "method_name" method_name $ Map.insert "method_arg_types" "METH_VARARGS" token_map

generateModule :: String -> [PyMethod] -> IO String
generateModule module_name methods = do
    -- basic token map
    let token_list = [ ("m_name", camelToSnakeCase module_name)
                     , ("M_Name", module_name)]
        token_map = Map.fromList token_list
    -- method implementations & definitions (in that order)
    methods_definitions <- mapM (flip generateMethodDef token_map) methods
    methods_implementations <- mapM (\ method -> generateMethodImpl method token_map) methods
    let all_implementations = unlines methods_implementations
        all_definitions = unlines methods_definitions
    -- fill module template
    module_template <- readFile "src/templates/module_template.tmpl"
    return $ evaluateTokens module_template $ Map.insert "m_methods_implementations" all_implementations $ Map.insert "m_methods_definitions" all_definitions token_map
