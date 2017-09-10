# Introduction to Monads

## How `>>` works

First we remember the definition for `>>` is
```haskell
(>>) :: m a -> m b -> m b
x >> y = x >>= \_ -> y
```
Notice that for a particular Monad `m`, the function of `>>` depends on how it 
implements `>>=`. In the case of `Maybe`, we know that
```haskell
(>>=) :: m a -> m b -> m b
Nothing >>= f = Nothing
Just x >>= f = f x
```
So, although the passed function ignores its argument, it respects the definition
of `>>=` and evaluates to `Nothing` if the first argument is Nothing. Thus the following behavior makes sense:
```haskell
ghci> Nothing >> Just 3
Nothing
ghci> Just 3 >> Just 4
Just 4
ghci> Just 3 >> Nothing
Nothing
```
## `do` sequencing

The following block of code:
```haskell
routine :: Maybe Pole
routine = do
    start <- return (0, 0)
    first <- landLeft 2 start
    Nothing
    second <- landRight 2 first
    landLeft 1 second
```
would result in `routine` being bound with value `Nothing`. The syntax itself is
somewhat misleading because we don't see how the unexpected `Nothing` in the middle
of the code would affect the outcome--after all, it's never used afterwards!

The `do` sequencing is actually gluing together a series of action with `>>`
operator. Remember that `>>` would result in `Nothing` if the left hand side value
is Nothing. So it's actually no surprise that we would end up with `Nothing` in the
end. Sometimes, it is prefered to write `Nothing` in this way to be clearer:
```haskell
    \_ -> Nothing
```

## Monadic Laws
1. `return x >>= f` is the same as `f x`

Example:
```haskell
ghci> return "WoM" >>= (\x -> [x, x, x])
```
