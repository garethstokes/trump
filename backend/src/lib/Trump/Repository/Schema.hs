module Trump.Repository.Schema where

import Data.Char
import Trump.Data
import System.Process
import Database.HDBC

dbPath :: TrumpConfig -> String
dbPath config = (rootPath config) ++ "/backend/data/trump_" ++ dbName(config)

dbName :: TrumpConfig -> String
dbName config = map toLower $ show (environment config)

dbHost :: TrumpConfig -> String
dbHost config = databaseHost config

dbConnectionString :: TrumpConfig -> String
dbConnectionString config = "host=" ++ (dbHost config) ++ " dbname=trump_" ++ (dbName config)

-- | Calls out to the system and inits the pg db
createDatabase :: TrumpConfig -> IO ()
createDatabase config = callCommand $ "createdb trump_" ++ (dbName config)

dropDatabase :: TrumpConfig -> IO ()
dropDatabase config = callCommand $ "dropdb trump_" ++ (dbName config)

console :: TrumpConfig -> IO ()
console config = callCommand $ "psql -d trump_" ++ (dbName config)

getMigrationSQLFromDisk :: TrumpConfig -> IO String 
getMigrationSQLFromDisk config = do
  script <- readFile $ (rootPath config) ++ "/backend/src/lib/Trump/Repository/SQL/Schema.sql"
  return script
  
-- | Migrate the tables so the are inline with the code.
migrateT :: IConnection conn => TrumpConfig -> conn -> IO ()
migrateT config dbh = do
  script <- (getMigrationSQLFromDisk config)
  _ <- runRaw dbh script
  commit dbh
