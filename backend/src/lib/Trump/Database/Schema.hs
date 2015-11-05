module Trump.Database.Schema where

import Trump.Data
import Trump.Database.Connection
import System.Process
import Database.HDBC

-- | Calls out to the system and inits the pg db
create :: TrumpConfig -> IO ()
create config = callCommand $ "createdb trump_" ++ (dbName config)

drop :: TrumpConfig -> IO ()
drop config = callCommand $ "dropdb trump_" ++ (dbName config)

console :: TrumpConfig -> IO ()
console config = callCommand $ "psql -d trump_" ++ (dbName config)

getMigrationSQLFromDisk :: TrumpConfig -> IO String 
getMigrationSQLFromDisk config = do
  script <- readFile $ (rootPath config) ++ "/backend/src/lib/Trump/Database/SQL/Schema.sql"
  return script
  
-- | Migrate the tables so the are inline with the code.
migrate :: TrumpConfig -> IO ()
migrate config = do
  dbh <- connect $ dbConnectionString config
  script <- (getMigrationSQLFromDisk config)
  _ <- runRaw dbh script
  commit dbh
