module Trump.Database.Repository where

import Trump.Data
import Trump.DomainModel
import Trump.Database.Connection
import Database.HDBC

{-
 EXAMPLE SQL RESULT: select * from user_profile

  [
    [
      SqlInteger 1,
      SqlByteString "gareth",
      SqlByteString "garrydanger@gmail.com",
      SqlNull,
      SqlLocalTime 2015-11-03 11:32:29.307721,
      SqlLocalTime 2015-11-03 11:32:29.307721
    ]
  ]
-}

-- |executeQuery: wrapper for handling reads from the database.
executeQuery :: String -> IO [[SqlValue]]
executeQuery query = do
  dbh <- connect $ dbConnectionString configuration
  sqlValues <- quickQuery dbh query []
  commit dbh
  return sqlValues 

-- | getUserProfiles: returns all user profiles from the database. 
--                    TODO: add pagination
getUserProfiles :: IO [UserProfile]
getUserProfiles = do
  r <- executeQuery "select * from user_profile"
  return $ map mapDbUserProfile r

mapDbUserProfile :: [SqlValue] -> UserProfile
mapDbUserProfile (a:b:c:_) = UserProfile { userProfileId=(fromSql a), name=(fromSql b), email=(fromSql c), refreshTokens = [], accessToken = Nothing, userCreated = Nothing, userModified = Nothing }


--createUserProfile :: UserProfile -> Maybe UserProfile
--findUserProfileById :: EntityId -> Maybe UserProfile
--deleteUserProfile :: EntityId -> Nothing
--updateUserProfile :: UserProfile -> Maybe UserProfile
--persistUserProfile :: UserProfile -> Maybe UserProfile
