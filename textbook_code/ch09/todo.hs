import System.Environment
import System.Directory
import System.IO
import Data.List
import Control.Exception

dispatch :: String -> [String] -> IO ()
dispatch "add" = add
dispatch "view" = view
dispatch "remove" = remove
dispatch "bump" = bump

main = do
    (command:argList) <- getArgs
    dispatch command argList

add :: [String] -> IO ()
add [fileName, todoItem] = appendFile fileName (todoItem ++ "\n")

view :: [String] -> IO ()
view [fileName] = do
    contents <- readFile fileName
    let todoTasks = lines contents
        numberedTasks = zipWith (\n line -> show n ++ " - " ++ line)
                        [0..] todoTasks
    putStr $ unlines numberedTasks

remove :: [String] -> IO ()
remove [fileName, numberString] = do
    contents <- readFile fileName
    let todoTasks = lines contents
        numberedTasks = zipWith (\n line -> show n ++ " - " ++ line)
                                    [0..] todoTasks
    putStrLn "These are your TO-DO itmes:"
    mapM_ putStrLn numberedTasks
    let number = read numberString
        newTodoItems = unlines $ delete (todoTasks !! number) todoTasks
    bracketOnError (openTempFile "." "temp")
        (\(tempName, tempHandle) -> do
            hClose tempHandle
            removeFile tempName)
        (\(tempName, tempHandle) -> do
            hPutStr tempHandle newTodoItems
            hClose tempHandle
            removeFile "todo.txt"
            renameFile tempName "todo.txt")

bump :: [String] -> IO ()
bump [fileName, numberString] = do
    contents <- readFile fileName
    let todoTasks = lines contents
        number = read numberString
        bumpTask = todoTasks !! number
        newTodoItems = bumpTask : (delete bumpTask todoTasks)
    putStrLn "These are your TO-Do items after bump up:"
    mapM_ putStrLn $ zipWith (\n line -> show n ++ " - " ++ line)
                     [0..] newTodoItems
    bracketOnError (openTempFile "." "temp")
        (\(tempName, tempHandle) -> do
            hClose tempHandle
            removeFile tempName)
        (\(tempName, tempHandle) -> do
            hPutStr tempHandle $ unlines newTodoItems
            hClose tempHandle
            removeFile "todo.txt"
            renameFile tempName "todo.txt")

