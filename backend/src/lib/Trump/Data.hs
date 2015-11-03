module Trump.Data where
  
data TrumpEnvironment = Development | Staging | Production
                        deriving (Eq, Show) 

data TrumpConfig = 
  TrumpConfig {
    port :: Int,
    rootPath :: String,
    environment :: TrumpEnvironment,
    databaseHost :: String
  } deriving (Show)
