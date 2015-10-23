{-# LANGUAGE OverloadedStrings, ScopedTypeVariables #-}
module Main where

import Control.Monad (msum)
import Happstack.Server

import           Text.Blaze ((!))
import qualified Text.Blaze.Html4.Strict as H
import qualified Text.Blaze.Html4.Strict.Attributes as A

appTemplate :: String -> [H.Html] -> H.Html -> H.Html
appTemplate title headers body =
    H.html $ do
      H.head $ do
        H.title (H.toHtml title)
        H.meta ! A.httpEquiv "Content-Type"
               ! A.content "text/html;charset=utf-8"
        sequence_ headers
      H.body $ do
        body

homepage :: ServerPart Response
homepage =
   ok $ toResponse $
    appTemplate "Email Manager: (Trump Edition)"
                [H.meta ! A.name "keywords"
                        ! A.content "happstack, blaze, html"
                ]
                (H.p $ do "Hello, "
                          H.b "blaze-html!")

trumpApp :: ServerPart Response
trumpApp = msum [
              serveDirectory EnableBrowsing ["index.html"] "frontend/dist/"
            ]

main :: IO ()
main = do
    let conf = nullConf { port = 1123 }
    simpleHTTP conf $ trumpApp
