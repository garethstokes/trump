{-# LANGUAGE OverloadedStrings, ScopedTypeVariables #-}
module Main where

import Control.Monad (msum)
import qualified Trump.Web.App

main :: IO ()
main = do
  putStrLn $ "{ Email Manager: Codename Trump }"
  putStrLn $ "---------------------------------"
  Trump.Web.App.start
