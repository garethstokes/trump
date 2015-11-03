module Trump.Database (
  module Trump.Database.Schema,
  migrate
) where

import Trump.Data
import Trump.Database.Schema
import Database.HDBC.PostgreSQL

{- 
createDb :: ...
createSchema :: ...
dropSchema :: ...
migrate :: ...

createUser
findUserById
getUsers
deleteUser
updateUser
-}

-- | Initialize DB and return database Connection 
connect :: String -> IO Connection
connect connectionString = do 
  dbh <- connectPostgreSQL connectionString --"host=localhost dbname=testdb user=foo"
  return dbh

migrate :: TrumpConfig -> IO ()
migrate config = do
  dbh <- connect $ dbConnectionString config
  migrateT config dbh
  
