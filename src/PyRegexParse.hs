module PyRegexParse where
import Text.Regex.Posix
import TemplateFormat (evaluateTokens, PyMethod)

-- regexp for python function definitions
fn_def_pattern = "^ *def +[A-z_][A-z0-9_]* *\\(.*\\) *: *$"

extractFnDefs :: [String] -> [String]
extractFnDefs = filter (=~ fn_def_pattern)

methodFromPyFnDef :: String -> PyMethod
methodFromPyFnDef s = let
    rest = dropWhile (==' ') $ drop 1 $ dropWhile (/='f') s
    fn_name = takeWhile (\x -> x /= ' ' && x /= '(') rest
    num_args = length . filter (==',') $ drop (length fn_name) rest
    result = (fn_name, "?", replicate num_args "?") in result

parsePyContent :: String -> [PyMethod]
parsePyContent content = map methodFromPyFnDef $ extractFnDefs $ lines content
