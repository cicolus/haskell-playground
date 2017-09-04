main = do
    contents <- getContents
    putStrLn (shortLinesOnly contents)

shortLinesOnly :: String -> String
shortLinesOnly = unlines . filter (\line -> length line < 10) . lines

-- we could also use 
-- main = interact shortLinesOnly
-- alternatively
