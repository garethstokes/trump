module Trump.Web.Api where

import Control.Monad.IO.Class
import Happstack.Server
import Trump.Data
import Trump.DomainModel

import qualified Trump.Database.Repository as R

apiOk :: String -> ServerPart Response
apiOk r = 
  ok $ (toResponse r) { rsHeaders=(mkHeaders [("Content-Type","application/json")]) }

getUsers :: ServerPart Response
getUsers = do
  users <- liftIO R.getUserProfiles
  apiOk $ show users

createUser :: ServerPart Response
createUser = ok (toResponse "create_user: success")

getUser :: String -> ServerPart Response
getUser x = ok $ toResponse ("get_user: " ++ x)
