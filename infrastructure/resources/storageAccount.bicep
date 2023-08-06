param environment string
param resourcePostfix string
param location string

resource storageAccount 'Microsoft.Storage/storageAccounts@2021-06-01' = {
  name: 'sa${environment}${location}${resourcePostfix}'
  location: location
  sku: {
    name: 'Standard_LRS'
  }
  kind: 'StorageV2'
  properties: {
    accessTier: 'Hot'
  }
}

resource queueServices 'Microsoft.Storage/storageAccounts/queueServices@2022-09-01' = {
  name: 'default'
  parent: storageAccount
  properties: {
  }
}

resource uploadHistoryQueue 'Microsoft.Storage/storageAccounts/queueServices/queues@2022-09-01' = {
  name: 'uploadhistoryqueue${resourcePostfix}'
  parent: queueServices
  properties: {
  }
}


resource blobServices 'Microsoft.Storage/storageAccounts/blobServices@2022-09-01' = {
  name: 'default'
  parent: storageAccount
  properties: {

  }
}


resource filesContainer 'Microsoft.Storage/storageAccounts/blobServices/containers@2022-09-01' = {
  name: 'filescontainer${resourcePostfix}'
  parent: blobServices
  properties: {
    publicAccess: 'Container'
  }
}
