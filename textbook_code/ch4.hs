my_replicate :: Int -> a -> [a]
my_replicate a b 
    | a <= 0 = []
    | otherwise = b : my_replicate (a - 1) b

my_take :: Int -> [a] -> [a]
my_take _ [] = []
my_take n (x:xs)
    | n <= 0 = []
    | otherwise = x : my_take (n - 1) xs

my_reverse :: [a] -> [a]
my_reverse [] = []
my_reverse (x:xs) = my_reverse xs ++ [x]

my_repeat :: a -> [a]
my_repeat a = a : my_repeat a

my_zip :: [a] -> [b] -> [(a, b)]
my_zip [] _ = []
my_zip _ [] = []
my_zip (x:xs) (y:ys) = (x, y) : my_zip xs ys

my_elem :: 