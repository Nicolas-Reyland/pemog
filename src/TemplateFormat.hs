module TemplateFormat where
import Data.List
import Data.Char
import qualified Data.Map as Map

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

snakeCase :: String -> String
snakeCase [] = ""
snakeCase [c] = [toLower c]
snakeCase (c1:c2:s)
    | isLower c1 && isUpper c2 = c1 :'_' : toLower c2 : snakeCase s
    | otherwise = toLower c1 : toLower c2 : snakeCase s

generateMethodImpl :: String -> String -> [String] -> Map.Map String String -> IO String
generateMethodImpl method_name return_type args token_map = do
    method_template <- readFile "src/templates/method_implementation.c"
    let new_token_map = Map.insert "method_name" method_name $ Map.insert "return" (returnCode return_type) token_map
        method_string = evaluateTokens method_template new_token_map
    return method_string

generateModule :: String -> [(String, String, [String])] -> IO String
generateModule module_name methods = do
    module_template <- readFile "src/templates/module_template.c"
    let token_list = [ ("m_name", snakeCase module_name)
                     , ("M_Name", module_name)]
        token_map = Map.fromList token_list
        methods_definitions = "method definitions"
    method_implementations <- mapM (\ (a,b,c) -> generateMethodImpl a b c token_map) methods
    return $ unlines method_implementations ++ methods_definitions

{-                     , ("m_methods_implementations", unlines $ map (\
                        (a,b,c) -> generateMethodImpl a b c)
                     )
                     , ("m_methods_definitions", "method defs here ...")]
    -}
