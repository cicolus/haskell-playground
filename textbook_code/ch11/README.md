# Functors
## Functor Laws

```haskell
-- Law 1
fmap id = id

-- Law 2
fmap (f . g) = fmap f . fmap g
```

## A Law Breaking Instance
```haskel
data CMaybe a = CNothing | CJust Int a deriving (Show)

instance Functor CMaybe where
    fmap f CNothing = CNothing
    fmap f (CJust counter x) = CJust (counter+1) (f x)
```
Loading the code results in following:
```haskell
ghci> fmap id (CJust 0 "haha")
CJust 1 "haha"
ghci> id (CJust 0 "haha")
CJust 0 "haha"
```
## Applicative Functors

Applicative functor is amazing idea for me. Though understanding functions as 
applicative functors is a bit challenging at first. Let me try explain it a little bit:
```haskell
instance Applicative ((->) r) where
    pure x = (\_ -> x)
    r <*> g = \x -> f x (g x)
```
The definition seems quite cryptic. But we can go back to the basic idea of _what's
the idea behind applicative functors?_ and then make sense of it:

> Applicative functors are used to perform boxed 'functions' on boxed 'values'.

Let's go back to the instance declaration:
```haskell
pure x = (\_ -> x)
```
should have type signature:
```haskell
pure :: a -> (r -> a)
```
and it would do the job!

For the other one, we also subsitute the types:
```haskell
(<*>) :: (r -> a -> b) -> (r -> a) -> (r -> b)
```
All is clear. Apparently, the applicative function is simply performing a resulted function on a resulted value to create a new function!


## Applicative Functor Laws
 * `pure id <*> v = v`
 * `pure (.) <*> u <*> v <*> w = u <*> (v <*> w)`
 * `pure f <*> pure x = pure (f x)`
 * `u <*> pure y = pure ($ y) <*> u`

## `sequenceA` function

```haskell
ghci> sequenceA [(+3),(+2),(+1)] 3
[6, 5, 4]
```
Let's again look at the type:
```haskell
sequenceA :: (Applicative f) -> [f a] -> f [a]
```
We can see that here each element in the list is of type `Int -> Int`. So to write
it in an *Applicative* flavor, its type is `(->) Int Int`. From this, we see
clearly that the Applicative functor is actually `(->) Int` and type parameter `a`
is `Int`. So the resulting type should be `(->) Int [Int]`, which in a more
human-friendly way of representation is `Int -> [Int]`. Each element of the list is
bind to the original functions, and takes a shared argument fed by the next value.
