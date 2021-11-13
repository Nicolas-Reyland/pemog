module Main where
import System.Environment
import Control.Monad (when)
import Pemog (processFile)

fileExtension :: String -> String
fileExtension file = reverse $ takeWhile (/='.') $ reverse file

main = do
    -- read arguments
    args <- getArgs
    let (module_name, input_file, output_file) = if length args /= 3 then
            error "Usage: pemog module-name input-file output-file"
        else (args !! 0, args !! 1, args !! 2)
    -- read input file
    contents <- readFile input_file
    -- interpret input as either sketch or python code
    newContents <- processFile (fileExtension input_file) module_name contents
    when (length newContents > 0) $
        writeFile output_file newContents
