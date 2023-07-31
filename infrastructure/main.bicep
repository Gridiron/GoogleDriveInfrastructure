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
