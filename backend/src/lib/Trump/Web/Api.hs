module Trump.Web.Api where

import Control.Monad.IO.Class
import Happstack.Server
import Trump.Data
import Trump.DomainModel

import qualified Trump.Database.Repository as R

getUsers :: ServerPart Response
getUsers = do
  users <- liftIO R.getUserProfiles
  ok $ toResponse $ "get_users: " ++ show users

createUser :: ServerPart Response
createUser = ok (toResponse "create_user: success")

getUser :: String -> ServerPart Response
getUser x = ok $ toResponse ("get_user: " ++ x)
