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

my_elem :: (Eq a) => a -> [a] -> Bool
my_elem _ [] = False
my_elem e (x:xs)
    | e == x = True
    | otherwise = my_elem e xs

quicksort :: (Ord a) => [a] -> [a]
quicksort [] = []
quicksort (x:xs) =
    let smaller_part = [a | a <- xs, a <= x]
        larger_part = [a | a <- xs, a > x]
    in quicksort smaller_part ++ [x] ++ quicksort larger_part