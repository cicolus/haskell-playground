type Birds = Int
type Pole = (Birds, Birds)

landLeft :: Birds -> Pole -> Maybe Pole
landLeft n (left, right) 
    | abs ((left + n) - right) < 4 = Just (left + n, right)
    | otherwise                    = Nothing


landRight :: Birds -> Pole -> Maybe Pole
landRight n (left, right) 
    | abs (left - (right + n)) < 4 = Just (left, right + n)
    | otherwise                    = Nothing

-- sample usage
foo = landRight 1 (0, 0) >>= landLeft 2

-- we can even do this
bar = return (0, 0) >>= landRight 2 >>= landLeft 2 >>= landRight 2
-- if error occured at some point, with the definition of Maybe's monad
-- implementation, the error will just be propagated further.

banana :: Pole -> Maybe Pole
banana _ = Nothing

-- the banana function would fail the walker immediately

baz = return (0, 0) >>= landLeft 1 >>= banana >>= landRight 1 -- Nothing

-- a bad example that doesn't use Monad
routine' :: Maybe Pole
routine' = case landLeft 1 (0, 0) of
    Nothing -> Nothing
    Just pole1 -> case landRight 4 pole1 of
        Nothing -> Nothing
        Just pole2 -> case landLeft 2 pole2 of
            Nothing -> Nothing
            Just pole3 -> landLeft 1 pole1

-- do notation
routine :: Maybe Pole
routine = do
    start <- return (0, 0)
    first <- landLeft 2 start
    Nothing
    second <- landRight 2 first
    landLeft 1 second

-- Maybe monda has a default context for failing
wopwop :: Maybe Char
wopwop = do
    (x:xs) <- Just ""
    return x
