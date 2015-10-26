{-# LANGUAGE OverloadedStrings, ScopedTypeVariables #-}
module Web where

import Control.Monad (msum)
import Happstack.Server

-- |homepage: serve compiled frontend assets from the frontend directory.
homepage :: ServerPart Response
homepage = serveDirectory EnableBrowsing ["index.html"] "frontend/dist/"

routes :: ServerPart Response
routes = msum [
              -- TODO: api route goes here.
              homepage
           ]

app :: IO ()
app = do
    let conf = nullConf { port = 1123 }
    simpleHTTP conf $ routes

