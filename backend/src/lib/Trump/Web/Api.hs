module Trump.Web.Api where

import Control.Monad
import Control.Monad.IO.Class
import Happstack.Server
import Trump.Data
import Trump.DomainModel
import Data.Aeson

import qualified Trump.Database.Repository as R
import qualified Data.ByteString.Lazy.Char8 as B

instance ToMessage UserProfile where
    toContentType _ = toContentType "application/json"

    toMessage d   = encode d
    toMessage [d] = encode d

{-
 
  IO<UserProfile[]> userProfiles = R.getUserProfiles
  
  encode :: ToJSON a => a -> Data.ByteString.Lazy.Internal.ByteString
  ByteString encode(UserProfile[]);

  liftM :: Monad m => (a1 -> r) -> m a1 -> m r
  IO<ByteString> liftM(Action<ByteString, UserProfile[]> a, IO<UserProfile[]> b);

  IO<ByteString> result = liftM(encode, userProfiles)

  ByteString str <- liftM encode $ R.getUserProfiles

  >>= :: Monad m => m a -> (a -> m b) -> m b
  
-}

getUsers :: ServerPart Response
getUsers = ok R.getUserProfiles
  --apiOk "userProfiles" $ liftM (B.unpack . encode) R.getUserProfiles

createUser :: ServerPart Response
createUser = ok (toResponse "create_user: success")

getUser :: String -> ServerPart Response
getUser x = ok $ toResponse ("get_user: " ++ x)
