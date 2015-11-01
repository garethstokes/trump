{-# LANGUAGE OverloadedStrings, ScopedTypeVariables #-}
module Main where

import System.Environment
import System.IO
import Data.List

import qualified Trump.Web.App

showHeader :: IO ()
showHeader = do
  putStrLn $ "{ Email Manager: Codename Trump }"
  putStrLn $ "---------------------------------"
  

dispatch :: [(String, [String] -> IO ())]
dispatch = [
             ("start", \_ -> startWebApp),
             ("db", dbActions),
             ("help", \_ -> showHelp)
 
          ]
dispatchDb :: [(String, IO())]
dispatchDb = [
               ("drop", showHelp),
               ("create", showHelp),
               ("migrate", showHelp),
               ("seed", showHelp)
             ]

showHelp :: IO ()
showHelp = do
  putStrLn " - trump start: starts the web app"
  putStrLn ""
  putStrLn " - trump db drop:"
  putStrLn " - trump db create:"
  putStrLn " - trump db migrate:"
  putStrLn " - trump db seed:"

dbActions :: [String] -> IO ()
dbActions [] = showHelp
dbActions (x:xs) = do
  let (Just action) = lookup x dispatchDb
  action


{- | startWebApp: starts the main path of execution -}
startWebApp :: IO ()
startWebApp = do
  Trump.Web.App.start

main :: IO ()
main = do
  showHeader
  args <- getArgs
  case args of
    [] -> showHelp
    (x:xs) -> do
      let (Just action) = lookup x dispatch
      action xs
