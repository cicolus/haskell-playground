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
dispatch command = doesntExist command

doesntExist :: String -> [String] -> IO ()
doesntExist command _ = putStrLn $ "The " ++ command ++ " command doesn't exist"

main = do
    bracketOnError getArgs
        (\_ -> do
            putStrLn $ "expected usage: ./todo [command] [fileName] \n"
                ++ "with optional trialing [itemNo.]")
        (\(command:argList) ->
            dispatch command argList)

add :: [String] -> IO ()
add [fileName, todoItem] = appendFile fileName (todoItem ++ "\n")
add _ = do
    putStrLn "expected usage: ./todo add [fileName] [todoItem]"

view :: [String] -> IO ()
view [fileName] = do
    contents <- readFile fileName
    let todoTasks = lines contents
        numberedTasks = zipWith (\n line -> show n ++ " - " ++ line)
                        [0..] todoTasks
    putStr $ unlines numberedTasks
view _ = do
    putStrLn "expected usage: ./todo view [fileName]"

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
remove _ = do
    putStrLn "expected usage: ./todo remove [fileName] [itemNo.]"

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
bump _ = do
    putStrLn "expected usage: ./todo bump [fileName] [itemNo.]"
