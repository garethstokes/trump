{-# LANGUAGE OverloadedStrings, ScopedTypeVariables #-}
module Main where

import Control.Monad (msum)
import Happstack.Server

homepage :: ServerPart Response
homepage = serveDirectory EnableBrowsing ["index.html"] "frontend/dist/"

trumpApp :: ServerPart Response
trumpApp = msum [
              homepage
           ]

main :: IO ()
main = do
    let conf = nullConf { port = 1123 }
    simpleHTTP conf $ trumpApp
