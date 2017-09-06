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
