module Trump.Web.Routes where

import Control.Monad (msum)
import Happstack.Server
import qualified Trump.Web.Api as API

-- |homepage: serve compiled frontend assets from the frontend directory.
homepage :: ServerPart Response
homepage = serveDirectory EnableBrowsing ["index.html"] "frontend/dist/"

routeMap :: ServerPart Response
routeMap = msum [
              dirs "api/users" $ API.getUsers,  
              dirs "api/user" $ method GET  >> path (API.getUser),
              dirs "api/user" $ do method POST 
                                   API.createUser,
              homepage
           ]
