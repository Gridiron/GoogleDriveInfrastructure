param environment string
param resourcePostfix string
param location string

resource databaseServer 'Microsoft.Sql/servers@2022-02-01-preview' = {
  name: 'sqlserver-${environment}-${location}-${resourcePostfix}'
  location: location
  properties: {
    administratorLogin: 'sa'
    administratorLoginPassword: '31415qwerty'
  }
}

resource database 'Microsoft.Sql/servers/databases@2020-08-01-preview' = {
  parent: databaseServer
  name: 'sqlDBName-${environment}-${location}-${resourcePostfix}'
  location: location
  sku: {
    name: 'GP_S_Gen5_1'
  }
  properties: {
    autoPauseDelay: 60
    collation: 'SQL_Latin1_General_CP1_CI_AS'
    minCapacity: 1
  }
}

