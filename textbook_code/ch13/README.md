# Introduction to Monads

First we notice the type of function enforced by Monad:
```haskell
(>>=) :: (Monad m) => m a -> (a -> m b) -> m b
```

