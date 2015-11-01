module Trump.DomainModel where

import Data.DateTime

data Token = Token {
                tokenId       :: Int,
                tokenKey      :: String,
                value         :: String,
                isActive      :: Bool,
                tokenCreated  :: DateTime,
                tokenModified :: DateTime
              } deriving (Show)

data User = User {
              userId        :: Int,
              name          :: String,
              email         :: String,
              refreshTokens :: [Token],
              accessToken   :: Token,
              userCreated   :: DateTime,
              userModified  :: DateTime
            } deriving (Show)
