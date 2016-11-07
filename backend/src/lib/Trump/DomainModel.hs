{-# LANGUAGE OverloadedStrings #-}
module Trump.DomainModel where

import Data.Aeson 
import Data.DateTime
import Data.ByteString.Lazy.Char8

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

-- |ToJSON instance allows us to encode a value as JSON.
instance ToJSON UserProfile where
  toJSON (UserProfile a b c d e f g) = object [ "id" .= a,
                                                "name" .= b,
                                                "email" .= c,
                                                "refreshTokens" .= d,
                                                "accessToken" .= e,
                                                "dateCreated" .= f,
                                                "dateModified" .= g ]

instance ToJSON Token where
  toJSON (Token a b c d e f) = object [ "id" .= a,
                                        "key" .= b,
                                        "value" .= c,
                                        "isActive" .= d,
                                        "dateCreated" .= e,
                                        "dateModified" .= f ]

instance FromJSON UserProfile where
  parseJSON (Object v) =
    UserProfile <$>
    (v .: "userProfileId")    <*>
    (v .: "name")             <*>
    (v .: "email")            <*>
    (v .: "refreshTokens")    <*>
    (v .:? "accessToken")     <*>
    (v .:? "userCreated")     <*>
    (v .:? "userModified")

instance FromJSON Token where
  parseJSON (Object v) =
    Token <$>
    (v .: "tokenId")          <*>
    (v .: "tokenKey")         <*>
    (v .: "value")            <*>
    (v .: "isActive")         <*>
    (v .: "tokenCreated")     <*>
    (v .: "tokenModified")
