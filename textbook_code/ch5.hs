flip' :: (a -> b -> c) -> b -> a -> c
flip' f x y = f y x
-- this function should be read like this:
-- (a -> b -> c) -> b -> a -> c
-- f                x    y    (f y x)
-- excellent example of both curried function and closure
