-- exercise 1
safeHead :: [a] -> Maybe a
safeHead (x:xs) = Just x
safeHead []     = Nothing

safeTail :: [a] -> Maybe [a]
safeTail (x:xs) = Just xs
safeTail []     = Nothing

safeLast :: [a] -> Maybe a
safeLast [x]    = Just x
safeLast (x:xs) = safeLast xs
safeLast []     = Nothing

safeInit :: [a] -> Maybe [a]
safeInit [x]    = Just []
safeInit (x:xs) = fmap (x:) $ safeInit xs 
safeInit []     = Nothing

-- exercise 2
splitWith :: (a -> Bool) -> [a] -> [[a]]
splitWith f [] = []
splitWith f xs = 
    let (pre, suf) = break f xs
        (spaces, rest) = span f suf
    in  pre : splitWith f rest

-- exercise 3
firstWords :: String -> [String]
firstWords = map (head . words) . lines 

-- exercise 4
-- note that this implementation will only process lines with equal length
transpose :: String -> String
transpose = unlines . (foldr (zipWith (:)) (repeat [])) . lines

