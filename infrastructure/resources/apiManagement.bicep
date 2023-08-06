param environment string
param resourcePostfix string
param apiManagementServiceName string = 'apimanagementservice${environment}${resourcePostfix}'
@minLength(1)
param publisherEmail string
@minLength(1)
param publisherName string
@allowed([
  'Developer'
  'Standard'
  'Premium'
])
param sku string = 'Developer'
@allowed([
  1
  2
])
param skuCount int = 1
param location string = resourceGroup().location

resource apiManagementService 'Microsoft.ApiManagement/service@2021-08-01' = {
  name: apiManagementServiceName
  location: location
  sku: {
    name: sku
    capacity: skuCount
  }
  properties: {
    publisherEmail: publisherEmail
    publisherName: publisherName
  }
}
