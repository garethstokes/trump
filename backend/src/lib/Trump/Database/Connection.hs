module Trump.Database.Connection where

import Data.Char
import Trump.Data
import Database.HDBC.PostgreSQL

dbPath :: TrumpConfig -> String
dbPath config = (rootPath config) ++ "/backend/data/trump_" ++ dbName(config)

dbName :: TrumpConfig -> String
dbName config = map toLower $ show (environment config)

dbHost :: TrumpConfig -> String
dbHost config = databaseHost config

dbConnectionString :: TrumpConfig -> String
dbConnectionString config = "host=" ++ (dbHost config) ++ " dbname=trump_" ++ (dbName config)

-- | Initialize DB and return database Connection 
connect :: String -> IO Connection
connect connectionString = do 
  dbh <- connectPostgreSQL connectionString --"host=localhost dbname=testdb user=foo"
  return dbh
