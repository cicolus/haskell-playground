class (Functor f) => Applicative f where
    pure :: a -> f a
    (<*>) :: f (a -> b) -> f a -> f b

instance Applicative Maybe where
    pure = Just
    Nothing <*> _ = Nothing
    (Just f) <*> something = fmap f something

(<$>) :: (Functor f) => (a -> b) -> f a -> f b
f <$> x = fmap f x

instance Applicative IO where
    pure = return
    a <*> b = do
        f <- a
        x <- b
        return (f x)

-- applicative functor can be used to glue actions together
myAction :: IO String
myAction = (++) <$> getLine <+> getLine

-- this is equivalent as
myAction' :: IO String
myAction' = do
    a <- getLine
    b <- getLine
    return $ a ++ b

-- functions as applicatives
instance Applicative ((->) r) where
    pure x = (\_ -> x)
    f <*> g = \x -> f x (g x)

instance Applicative ZipList where
    pure x = ZipList (repeat x)
    ZipList fs <*> ZipList xs = ZipList (zipWith (\f x -> f x) fs xs)

liftA2 :: (Applicative f) => (a -> b -> c) -> f a -> f b -> f c
lifeA2 f a b = f <$> a <*> b

sequenceA :: (Applicative f) -> [f a] -> f [a]
sequenceA = foldr (liftA2 (:)) (pure [])

-- sequenceA [Just 3, Just 2, Just 1]
-- Just [3, 2, 1]
