module Pemog where
import Data.Char
import Data.List
import TemplateFormat (generateModule)
import SketchParse (parseSketchContent)
import PyRegexParse (parsePyContent)

processFile :: String -> String -> String -> IO String
processFile file_type name content = do
    putStrLn $ "File type: " ++ file_type
    (case file_type of
        "sketch" -> processSketchFile
        "py"     -> processPythonFile
        _        -> error $ "Unknown file type: " ++ file_type) name content

processSketchFile :: String -> String -> IO String
processSketchFile name content = generateModule name $ parseSketchContent content

processPythonFile :: String -> String -> IO String
processPythonFile name content = generateModule name $ parsePyContent content
