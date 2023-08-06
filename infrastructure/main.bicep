param config object

module fileStorage 'resources/storageAccount.bicep' = {
  name: 'fileStorage-deployment'
  params: {
    environment: config.environment
    resourcePostfix: config.resourcePostfix
    location: config.location
  }
}

module metadataDatabase 'resources/databaseServer.bicep' = {
  name: 'metadataDatabase-deployment'
  params: {
    environment: config.environment
    resourcePostfix: config.resourcePostfix
    location: config.location
  }
}

module workloadProcessorFunctionApp 'resources/functionApp.bicep' = {
  name: 'workloadProcessorFunctionApp-deployment'
  params: {
    environmentName: config.environment
    resourcePostfix: config.resourcePostfix
    location: config.location
    appInsightsLocation: config.location
  }
}

module keyVault 'resources/keyVault.bicep' = {
  name: 'keyVault-deployment'
  params: {
    principalId: workloadProcessorFunctionApp.outputs.principalId
    tenantId: workloadProcessorFunctionApp.outputs.principalId
    location: config.location
    environmentName: config.environment
    resourcePostfix: config.resourcePostfix
  }
}

module cosmosDb 'resources/cosmosDb.bicep' = {
  name: 'cosmosDb-deployment'
  params: {
    containerName: 'filesContainer'
    databaseName: 'databaseContainer'
    location: config.location
    environment: config.environment
    resourcePostfix: config.resourcePostfix
  }
}
