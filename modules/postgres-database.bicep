param postgreSQLDatabaseName string
param serverName string

resource postgresSQLDatabase 'Microsoft.DBforPostgreSQL/flexibleServers/databases@2022-12-01' = {
  name: '${serverName}/${postgreSQLDatabaseName}'
  properties: {
    charset: 'UTF8'
    collation: 'en_US.UTF8'
  }
}

output databaseId string = postgresSQLDatabase.id
output databaseName string = postgresSQLDatabase.name 
