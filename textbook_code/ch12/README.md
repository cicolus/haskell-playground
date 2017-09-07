# `newtype`, `data` and `type` keywords

## `newtype` 
`newtype` has only one constructor, which is known to the compiler/interpreter.

```haskell
newtype CharList = CharList { getCharList :: [Char] } deriving (Eq, Show)

-- CharList :: [Char] -> CharList
-- getCharList :: CharList -> [Char]
```

So it's behavior is lazier. For example, if we have the following `newtype` defined:
```haskell
data CoolBool = CoolBool { getCoolBool :: Bool }

helloMe :: CoolBool -> String
helloMe (CoolBool _) = "hello"
```
Then `ghci` is going to complain when we do this:
```haskell
ghci> helloMe undefined
"*** Exception: Prelude.undefined
```
This is because `data` type constructor can have more than one constructor so the
compile needs to check for each and thus have the necessity to evaluate it. However, if we just switch to `newtype`, then
```haskell
newtype CoolBool = CoolBool { getCoolBool :: Bool }

helloMe :: CoolBool -> String
helloMe (CoolBool _) = "hello"
```
`ghci` would not complain because it knows `newtype` can only have one ocnsstructor and thus doesn't bother to check for what value's inside the wrapper class:
```haskell
ghci> helloMe undefined
"hello"
```

## difference between the three type-related keywords
* `newtype` is for a single wrapper class, which you just want the compiler/interpreter
to treat it as a different type
* `type` is type synonymous where you want compiler/interpreter to see two names
as the same thing
* `data` is for more complex and general new type designs.

# Monoid

*Monoid* is a algebraic type (a semigroup) where associativity and identity element is guaranteed. It's not group for the lack of inverse etc.

```haskell
class Monoid m where
    mempty :: m
    mappend :: m -> m -> m
    mconcat :: [m] -> m
    mconcat = foldr mappend mempty
```
To express the algebraic laws as code:
```haskell
mempty `mappend` x = x
x `mappend` mempty = x
(x `mappend` y) `mappend` z = x `mappend` (y `mappend` z)
```
