-- let's just first try out a function with a signature that resambles monad's

applyMaybe :: Maybe a -> (a -> Maybe b) -> Maybe b
applyMaybe Nothing f = Nothing
applyMaybe (Just x) f = f x

-- then let's look at the definition of the type class
class Monad m where
    return :: a -> m a

    (>>=) :: m a -> (a -> m b) -> m b

    (>>) :: m a -> m b -> m b
    x >> y = x >>= \_ -> y
    
    fail :: String -> m a
    fail msg = error msg

instance Monda Maybe where
    return x = Just x
    Nothing >>= f = Nothing
    Just x >>= f  = f x
    fail _ = Nothing

-- translation of nondeterministic into Monad
instance Monad [] where
    return x = [x]
    xs >>= f = concat (map f xs)
    fail _ = []

-- MonadPlus is a type class for a type that's both Monad and Monoid
class Monad m => MonadPlus m where
    mzero :: m a
    mplus :: m a -> m a -> m a

instance MonadPlus [] where
    mzero = []
    mplus = (++)

-- Defined in `Control.Monad`
guard :: (MonadPlust m) => Bool -> m ()
guard True = return ()
guard False = mzero

-- usage of guard
sevensOnly :: [Int]
sevensOnly = do
    x <- [1..50]
    guard ('7' `elem` show x)
    return x

