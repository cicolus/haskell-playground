import System.IO

main = do
    withFile "haiku.txt" ReadMode (\handle -> do
        contents <- hGetContents handle
        putStr contents)

-- withFile ensures that even if error is raised, the handle will
-- be closed
