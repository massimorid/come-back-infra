param location string = resourceGroup().location
param appServicePlanId string
param appServiceAppName string

resource appServiceApp 'Microsoft.Web/sites@2022-03-01' = {
  name: appServiceAppName
  location: location
  properties: {
    serverFarmId: appServicePlanId
    httpsOnly: true
    siteConfig: {
      linuxFxVersion: 'NODE|18-lts'
      alwaysOn: false
      ftpsState: 'FtpsOnly'
      appCommandLine: 'pm2 serve /home/site/wwwroot --spa --no-daemon'
      appSettings: []
    }
  }
}

output frontendAppId string = appServiceApp.id
output frontendAppName string = appServiceApp.name
output frontendAppHostName string = appServiceApp.properties.defaultHostName 
