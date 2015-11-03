module Trump.Web.Api where

import Happstack.Server
--import Trump.DomainModel

getUsers :: ServerPart Response
getUsers = ok $ toResponse "get_users: success"

createUser :: ServerPart Response
createUser = ok (toResponse "create_user: success")

getUser :: String -> ServerPart Response
getUser x = ok $ toResponse ("get_user: " ++ x)
