module Main where
import System.Environment
import Control.Monad (when)
import Pemog (processFile)

main = do
    args <- getArgs
    let (module_name,input_file,output_file) = if length args /= 3 then
            error "Usage: pemog module-name input-file output-file"
        else (args !! 0, args !! 1, args !! 2)
    contents <- readFile input_file
    let newContents = processFile contents
    when (length newContents > 0) $
        writeFile output_file newContents
