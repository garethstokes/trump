{-# LANGUAGE OverloadedStrings, ScopedTypeVariables #-}
module Main where

import Control.Monad (msum)
import qualified Web

main :: IO ()
main = Web.app
