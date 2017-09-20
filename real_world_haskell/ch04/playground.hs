suffixes :: [a] -> [[a]]
suffixes (x:xs) = (x:xs) : suffixes xs 
suffixes _ = []
