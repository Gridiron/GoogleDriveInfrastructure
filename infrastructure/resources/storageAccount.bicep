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
    cors: {
      corsRules: [
        {
          allowedHeaders: [
            'string'
          ]
          allowedMethods: [
            'string'
          ]
          allowedOrigins: [
            'string'
          ]
          exposedHeaders: [
            'string'
          ]
          maxAgeInSeconds: 300
        }
      ]
    }
  }
}

resource uploadQueue 'Microsoft.Storage/storageAccounts/queueServices/queues@2022-09-01' = {
  name: 'uploadQueue${resourcePostfix}'
  parent: queueServices
  properties: {
    metadata: {}
  }
}


resource blobServices 'Microsoft.Storage/storageAccounts/blobServices@2022-09-01' = {
  name: 'default'
  parent: storageAccount
  properties: {
    automaticSnapshotPolicyEnabled: false
    changeFeed: {
      enabled: true
      retentionInDays: 30
    }
    containerDeleteRetentionPolicy: {
      allowPermanentDelete: true
      days: 365
      enabled: true
    }
    cors: {
      corsRules: [
        {
          allowedHeaders: [
            'string'
          ]
          allowedMethods: [
            'string'
          ]
          allowedOrigins: [
            'string'
          ]
          exposedHeaders: [
            'string'
          ]
          maxAgeInSeconds: 3000
        }
      ]
    }
    defaultServiceVersion: 'string'
    deleteRetentionPolicy: {
      allowPermanentDelete: true
      days: 365
      enabled: true
    }
    isVersioningEnabled: false
    lastAccessTimeTrackingPolicy: {
      blobType: [
        'string'
      ]
      enable: true
      name: 'AccessTimeTracking'
      trackingGranularityInDays: 100
    }
    restorePolicy: {
      days: 365
      enabled: false
    }
  }
}


resource filesContainer 'Microsoft.Storage/storageAccounts/blobServices/containers@2022-09-01' = {
  name: 'filesContainer${resourcePostfix}'
  parent: blobServices
  properties: {
    defaultEncryptionScope: 'string'
    denyEncryptionScopeOverride: true
    enableNfsV3AllSquash: false
    enableNfsV3RootSquash: true
    immutableStorageWithVersioning: {
      enabled: false
    }
    publicAccess: 'Container'
  }
}
