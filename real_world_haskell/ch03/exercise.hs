teesst :: Integer -> Integer
teesst n = foo $ bar n
    where foo 0 = 0
          foo 1 = 1
          foo n = n * 2
          bar 0 = 0
          bar 1 = 1
          bar n = n + 1

-- the function above compiles, which means where can have multiple
-- functions defined within it, however, this doesn't compile:
--
-- teesst :: Integer -> Integer
-- teesst n = foo $ bar n
--     where foo 0 = 0
--           foo 1 = 1
--           bar 0 = 0
--           bar 1 = 1
--           foo n = n * 2
--           bar n = n + 1
-- 
-- So we must complete one function's definition before we begin the
-- next.

-- exercises on page 69 - 70
--
-- exercise 1 and 2
myLength :: [a] -> Int
myLength (x:xs) = 1 + myLength xs
myLength [] = 0

-- exercise 3
mean :: (Num a, Fractional a) => [a] -> a
mean = (/) <$> sum <*> (fromIntegral . length) 

-- exercise 4


-- myLength_test :: [a] -> Bool
-- myLength_test xs = myLength xs == length xs
-- 
-- 
-- 
-- 
-- main = do
--     quickCheck myLength_test
