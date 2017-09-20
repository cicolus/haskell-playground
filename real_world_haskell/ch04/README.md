# Chapter 4

## `foldl` using `foldr`

The implementation of `foldl` using `foldr` took me a long time to understand, so I
thought I'd write down my thought process.

First we write down the definition of the function and review the definition for 
`foldr`:
```haskell
foldl :: (a -> b -> a) -> a -> [b] -> a
fold f z xs = foldr step id xs z
    where step x g a = g (f a x)

foldr :: (a -> b -> b) -> b -> [a] -> b
foldr step zero (x:xs) = step x (foldr step zero xs)
foldr _    zero []     = zero
```
I didn't use a different name for the new definition of `foldl` as it would be 
easier to read this way. Next, we look at how this works on a three elements list.
We apply the function step by step:
```haskell
   foldl f a0 [a1, a2, a3]
= (foldr step id [a1, a2, a3])
= (step a1 (foldr step id [a2, a3]))
= (step a1 (step a2 (foldr step id [a3]))) a0
= (step a1 (step a2 (step a3 (foldr step id [])))) a0
= (step a1 (step a2 (step a3 id))) a0
= (step a1 (step a2 (\x1 -> id (f x1 a3)))) a0
= (step a1 (\x2 -> (\x1 -> id (f x1 a3)) (f x2 a2))) a0
= (\x3 -> (\x2 -> (\x1 -> id (f x1 a3)) (f x2 a2)) (f x3 a1)) a0
= (\x2 -> (\x1 -> id (f x1 a3)) (f x2 a2)) (f a0 a1)
= (\x1 -> id (f x1 a3)) (f (f a0 a1) a2)
= id (f (f (f a0 a1) a2) a3)
= f (f (f a0 a1) a2) a3
```
To look it in another way, we can derive this implementation by mutating the
original `foldl` implementation step by step:
```haskell
foldl :: (a -> b -> a) -> a -> [b] -> a
foldl f v []     = v
foldl f v (x:xs) = foldl f (f v x) xs
```
This is the original implementation of `foldl`, now we use a function to make the
pattern matching explicit:
```haskell
foldl :: (a -> b -> a) -> a -> [b] -> a
foldl f v [] = g xs v
    where g []     v = v
          g (x:xs) v = g xs (f v x)
```
Next, we move the last parameter to the right hand side and use a awkward lambda 
expression to rewrite the function:
```haskell
foldl :: (a -> b -> a) -> a -> [b] -> a
foldl f v [] = g xs v
    where g []     = \v -> v
          g (x:xs) = \v -> g xs (f v x)
```
Now that we know the `id` function returns itself:
```haskell
foldl :: (a -> b -> a) -> a -> [b] -> a
foldl f v [] = g xs v
    where g []     = id
          g (x:xs) = \v -> g xs (f v x)
```
And we notice that this is a right fold logic.

## As-pattern
The _As-pattern_ looks to me like a pattern matching after variable definition.
The example used in the book is actually equivalent to the second definition I give
below:
```haskell
suffixes :: [a] -> [[a]]
suffixes xs@(_:xs') = xs : suffixes xs'
suffixes _ = []

suffixes' :: [a] -> [[a]]
suffixes' (x:xs) = (x:xs) : suffixes xs
suffixes' _ = []
```
The difference, in my opinion, is that we don't want the extra `x` variable, so we
pattern match it after we have a name for the whole value.
