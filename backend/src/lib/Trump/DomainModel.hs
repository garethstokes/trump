module Trump.DomainModel where

import Data.DateTime

type EntityId = Int

data Token = Token {
               tokenId       :: EntityId,
               tokenKey      :: String,
               value         :: String,
               isActive      :: Bool,
               tokenCreated  :: DateTime,
               tokenModified :: DateTime
             } deriving (Show)

data UserProfile = UserProfile {
                     userProfileId :: EntityId,
                     name          :: String,
                     email         :: String,
                     refreshTokens :: [Token],
                     accessToken   :: Maybe Token,
                     userCreated   :: Maybe DateTime,
                     userModified  :: Maybe DateTime
                   } deriving (Show)
