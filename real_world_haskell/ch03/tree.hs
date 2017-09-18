data List a = Cons a (List a)
            | Nil
              deriving (Show)

data Tree a = Node a (Tree a) (Tree a)
            | Empty
              deriving (Show)

fromList :: [a] -> List a
fromList (x:xs) = Cons x (fromList xs)
fromList []     = Nil

-- exercise 1
-- write the converse of fromList for the List type: a function
-- that takes a List a and generates a [a]

fromListA :: List a -> [a]
fromListA (Cons x xs) = x:(fromListA xs)
fromListA Nil       = []

-- exercise 2
-- define a type that has only one constructor, like our Java example
-- Instead of the Empty constructor, use the Maybe type to refer to a
-- node's children.

data TreeM a = TreeM (Maybe (a, TreeM a, TreeM a)) deriving (Show)

fooTree = TreeM $ Just ("root",
                    TreeM $ Just ("left", TreeM Nothing, TreeM Nothing),
                    TreeM $ Just ("right", TreeM Nothing, TreeM Nothing))


-- exercise 9 on page 70
height :: Tree a -> Int
height Empty = 0
height (Node val left right) = 1 + max (height left) (height right)
