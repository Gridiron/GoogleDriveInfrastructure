param environment string
param resourcePostfix string
param location string
param planConfig object

resource plan 'Microsoft.Web/serverfarms@2021-02-01' = {
  name: 'plan-badadvisor-${environment}-${resourcePostfix}'
  location: location
  sku: {
    tier: planConfig.skuTier
    name: planConfig.skuName
  }
  kind: 'linux'
  properties: {
    maximumElasticWorkerCount: 1
    reserved: true
  }
}
resource appService 'Microsoft.Web/sites@2020-06-01' = {
  name: 'appservice${environment}${resourcePostfix}'
  location: location
  properties: {
    serverFarmId: plan.id
    siteConfig: {
      linuxFxVersion: 'DOTNETCORE|6.0'
    }
  }
}
