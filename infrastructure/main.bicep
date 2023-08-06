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

module apiManagement 'resources/apiManagement.bicep' = {
  name: 'apiManagement-deployment'
  params: {
    publisherEmail: 'nikitai100300100300@gmail.com'
    publisherName: 'Mikita Ishchanka'
    location: config.location
    environment: config.environment
    resourcePostfix: config.resourcePostfix
  }
}

module appService 'resources/appService.bicep' = {
  name: 'appService-deployment'
  params: {
    planConfig: config.planConfig
    location: config.location
    environment: config.environment
    resourcePostfix: config.resourcePostfix
  }
}
