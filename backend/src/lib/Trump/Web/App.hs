module Trump.Web.App where

import Happstack.Server
import Trump.Web.Routes
import qualified Trump.Data as D

start :: D.TrumpConfig -> IO ()
start configuration = do
  let portNumber = D.port configuration
  putStrLn $ " - Trump.Web: listening on port " ++ show portNumber
  simpleHTTP nullConf { port = portNumber } $ Trump.Web.Routes.routeMap
