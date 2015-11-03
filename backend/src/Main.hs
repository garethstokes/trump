{-# LANGUAGE OverloadedStrings, ScopedTypeVariables #-}
module Main where

import System.Environment
import System.IO
import Data.List
import Trump.Data

import qualified Trump.Database as DB
import qualified Trump.Web.App

configuration :: TrumpConfig
configuration = 
  TrumpConfig {
    port = 1123,
    rootPath = "/Users/garethstokes/src/trump",
    environment = Development,
    databaseHost = "localhost"
  }

showHeader :: IO ()
showHeader = do
  putStrLn $ "{ Email Manager: Codename Trump }"
  putStrLn $ "---------------------------------"

lib :: (TrumpConfig -> IO ()) -> (a -> IO ())
lib f = \_ -> f configuration

data Command = HomeCommand | DBCommand

dispatch :: Command -> [(String, [String] -> IO ())]
dispatch HomeCommand = [ ("start",  lib Trump.Web.App.start),
                         ("db",     dbActions),
                         ("help",   \_ -> showHelp) ]

dispatch DBCommand = [ ("drop",     lib DB.drop),
                       ("create",   lib DB.create),
                       ("migrate",  lib DB.migrate),
                       ("recreate", \_ -> do
                                            (DB.drop configuration)
                                            (DB.create configuration)
                                            (DB.migrate configuration) ),
                       ("console",  lib DB.console),
                       ("seed",     \_ -> showHelp) ]

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
  let (Just action) = lookup x $ dispatch DBCommand
  action xs

main :: IO ()
main = do
  showHeader
  args <- getArgs
  case args of
    [] -> showHelp
    (x:xs) -> do
      let (Just action) = lookup x $ dispatch HomeCommand
      action xs
