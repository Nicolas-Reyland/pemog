module Pemog where
import Data.Char
import Data.List

processFile :: String -> String
processFile content = unlines $ map processLine $ filter (/=[]) $ lines content

removeSpaces :: String -> String
removeSpaces = filter (not . isSpace)

insideParentheses :: String -> String
insideParentheses line =
    case '(' `elemIndex` line of
        Just x -> case ')' `elemIndex` line of
            Just y -> take (y - x - 1) $ drop (x+1) line
            Nothing -> error "no closing parenthesis"
        Nothing -> error "no opening parenthesis"

argList :: String -> [String]
argList s = case ',' `elemIndex` s of
    Just i -> take i s : argList (drop (i+1) s)
    Nothing -> [s]

generateFunction :: String -> String -> [String] -> String
generateFunction return_type name args = "def " ++ name ++ "(" ++ unwords args ++ ")" ++ case return_type of
    [] -> " -> None"
    s -> " -> " ++ s

processLine :: String -> String
processLine raw_line =
    let line = removeSpaces raw_line in
    let name = takeWhile (/='(') line in
    let rest = drop (length name) line in
    let args = argList $ insideParentheses rest in
    let return_type = drop 1 $ dropWhile (/=')') rest in
    generateFunction return_type name args
