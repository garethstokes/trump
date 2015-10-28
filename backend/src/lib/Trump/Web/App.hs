module Trump.Web.App where

import Happstack.Server
import Trump.Web.Routes

start :: IO ()
start = do
  let portNumber = 1123
  putStrLn $ " - Trump.Web: listening on port " ++ show portNumber
  simpleHTTP nullConf { port = portNumber } $ Trump.Web.Routes.routeMap
