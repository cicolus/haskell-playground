# Chapter 01

## Question 1

```haskell
Prelude> :t 5 + 8
5 + 8 :: Num a => a
Prelude> :t 3 * 5 + 8
3 * 5 + 8 :: Num a => a
Prelude> :t 2 + 4
2 + 4 :: Num a => a
Prelude> :t (+) 2 4
(+) 2 4 :: Num a => a
Prelude> :t sqrt 16
sqrt 16 :: Floating a => a
Prelude> :t succ 6
succ 6 :: (Num a, Enum a) => a
Prelude> :t succ 7
succ 7 :: (Num a, Enum a) => a
Prelude> :t pred 9
pred 9 :: (Num a, Enum a) => a
Prelude> :t pred 8
pred 8 :: (Num a, Enum a) => a
Prelude> :t sin (pi / 2)
sin (pi / 2) :: Floating a => a
Prelude> :t truncate pi
truncate pi :: Integral b => b
Prelude> :t round 3.5
round 3.5 :: Integral b => b
Prelude> :t round 3.4
round 3.4 :: Integral b => b
Prelude> :t floor 3.7
floor 3.7 :: Integral b => b
Prelude> :t ceiling 3.3
ceiling 3.3 :: Integral b => b
```

## Question 2

```haskell
Prelude> let x = 1
Prelude> :show bindings
x :: Num p => p = _
```


