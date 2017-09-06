-- problem 1
-- find the last element of a list
myLast :: [a] -> a
myLast = foldr1 (\_ acc -> acc)

-- problem 2
-- 

