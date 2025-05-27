@sys.description('The environment type (nonprod or prod)')
@allowed([
  'nonprod'
  'prod'
])
param environmentType string = 'nonprod'
@sys.description('The user alias to add to the deployment name')
param userAlias string = 'aguadamillas'
@sys.description('The PostgreSQL Server name')
@minLength(3)
@maxLength(24)
param postgreSQLServerName string = 'ie-bank-db-server-dev'
@sys.description('The PostgreSQL Database name')
@minLength(3)
@maxLength(24)
param postgreSQLDatabaseName string = 'ie-bank-db'
@sys.description('The App Service Plan name')
@minLength(3)
@maxLength(24)
param appServicePlanName string = 'ie-bank-app-sp-dev'
@sys.description('The Web App name (frontend)')
@minLength(3)
@maxLength(24)
param appServiceAppName string = 'ie-bank-dev'
@sys.description('The API App name (backend)')
@minLength(3)
@maxLength(24)
param appServiceAPIAppName string = 'ie-bank-api-dev'
@sys.description('The Azure location where the resources will be deployed')
param location string = resourceGroup().location

@secure()
param postgreSQLAdminPassword string

@sys.description('The value for the environment variable ENV')
param appServiceAPIEnvVarENV string

@sys.description('The value for the environment variable DBHOST')
param appServiceAPIEnvVarDBHOST string

@sys.description('The value for the environment variable DBNAME')
param appServiceAPIEnvVarDBNAME string

@sys.description('The value for the environment variable DBPASS')
@secure()
param appServiceAPIEnvVarDBPASS string

@sys.description('The value for the environment variable DBUSER')
param appServiceAPIDBHostDBUSER string

@sys.description('The value for the environment variable FLASK_APP')
param appServiceAPIDBHostFLASK_APP string

@sys.description('The value for the environment variable FLASK_DEBUG')
param appServiceAPIDBHostFLASK_DEBUG string

module postgresServer 'modules/postgres-flexible-server.bicep' = {
  name: 'postgresServer'
  params: {
    location: location
    postgreSQLServerName: postgreSQLServerName
    postgreSQLAdminPassword: postgreSQLAdminPassword
  }
}

module postgresDatabase 'modules/postgres-database.bicep' = {
  name: 'postgresDatabase'
  params: {
    postgreSQLDatabaseName: postgreSQLDatabaseName
    serverName: postgresServer.outputs.serverName
  }
  dependsOn: [
    postgresServer
  ]
}

module keyVault 'modules/key-vault.bicep' = {
  name: 'keyVault'
  params: {
    location: location
    name: keyVaultName
  }
}


param containerRegistryName string
param ServicePrincipalId string
param keyVaultName string
module containerRegistry 'modules/container-registry.bicep' = {
  name: 'containerRegistry'
  params: {
    location: location
    name: containerRegistryName
    ServicePrincipalId: ServicePrincipalId
    keyVaultName: keyVaultName
  }
}

module appService 'modules/app-service.bicep' = {
  name: 'appService-${userAlias}'
  params: {
    location: location
    environmentType: environmentType
    appServiceAppName: appServiceAppName
    appServiceAPIAppName: appServiceAPIAppName
    appServicePlanName: appServicePlanName
    appServiceAPIDBHostDBUSER: appServiceAPIDBHostDBUSER
    appServiceAPIDBHostFLASK_APP: appServiceAPIDBHostFLASK_APP
    appServiceAPIDBHostFLASK_DEBUG: appServiceAPIDBHostFLASK_DEBUG
    appServiceAPIEnvVarDBHOST: appServiceAPIEnvVarDBHOST
    appServiceAPIEnvVarDBNAME: appServiceAPIEnvVarDBNAME
    appServiceAPIEnvVarDBPASS: appServiceAPIEnvVarDBPASS
    appServiceAPIEnvVarENV: appServiceAPIEnvVarENV
  }
  dependsOn: [
    postgresDatabase
  ]
}

output appServiceAppHostName string = appService.outputs.appServiceAppHostName
