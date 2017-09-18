import Test.QuickCheck
import Data.List

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
palindrome :: [a] -> [a]
palindrome = (++) <$> id <*> reverse

-- exercise 5
isPalindrome :: (Eq a) => [a] -> Bool
isPalindrome xs = xs == (palindrome $ take (length xs `div` 2) xs)

-- exercise 6
sortByLength :: [[a]] -> [[a]]
sortByLength = sortBy (\xs ys -> compare (length xs) (length ys)) 

-- exercise 7 and 8
intersperce :: a -> [[a]] -> [a]
intersperce seperator [] = []
intersperce seperator xs = foldr1 (\x acc -> x ++ [seperator] ++ acc) xs

-- exercise 9 see tree.hs
-- exercise 10


-- tests --
myLength_test :: [a] -> Bool
myLength_test xs = myLength xs == (length xs)

palindrome_test :: (Eq a) => [a] -> Bool
palindrome_test = isPalindrome . palindrome 

main = do
    quickCheck (myLength_test :: [Int] -> Bool)
    quickCheck (palindrome_test :: [Int] -> Bool)
