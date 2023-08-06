param location string
param environmentName string
param resourcePostfix string
param principalId string
param tenantId string

resource keyVault 'Microsoft.KeyVault/vaults@2016-10-01' = {
  name: 'akv${environmentName}${resourcePostfix}'
  location: location
  properties: {
    enabledForDeployment: true
    enabledForTemplateDeployment: true
    enabledForDiskEncryption: true
    tenantId: tenantId
    accessPolicies: [
      {
        tenantId: tenantId
        objectId: principalId
        permissions: {
          secrets: [
            'get'
            'list'
          ]
        }
      }
    ]
    sku: {
      name: 'standard'
      family: 'A'
    }
  }  
}
