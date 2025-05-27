using '../main.bicep'

param userAlias = 'mridella' //Replace {alias} with your student alias, and use it in your main.bicep as part of the name of the module deployment to avoid deployment conflicts (e.g. alias of 'aguadamillas@faculty.ie.edu' is 'aguadamillas')
param appServiceContainerBackendName = 'mridella-asc-backend' //Replace {alias} with your student alias to avoid deployment conflicts (e.g. alias of 'aguadamillas@faculty.ie.edu' is 'aguadamillas')
param appServicePlanName = 'mridella-asp' //Replace {alias} with your student alias to avoid deployment conflicts (e.g. alias of 'aguadamillas@faculty.ie.edu' is 'aguadamillas')
param containerRegistryName = 'mridella-acr'  //Replace {alias} with your student alias to avoid deployment conflicts (e.g. alias of 'aguadamillas@faculty.ie.edu' is 'aguadamillas')
param postgreSQLDatabaseName = 'mridella-db'  //Replace {alias} with your student alias to avoid deployment conflicts (e.g. alias of 'aguadamillas@faculty.ie.edu' is 'aguadamillas')
param postgreSQLServerName = 'mridella-dbsrv'  //Replace {alias} with your student alias to avoid deployment conflicts (e.g. alias of 'aguadamillas@faculty.ie.edu' is 'aguadamillas')

// Exercise II (Option BICEP parameters): Add parameters to deploy the infrastructure. The names for the Azure resources must start with your student alias
param keyVaultName = 'mridella-kv'
param ServicePrincipalId = '25d8d697-c4a2-479f-96e0-15593a830ae5'
