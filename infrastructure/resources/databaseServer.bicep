param environment string
param resourcePostfix string
param location string

resource databaseServer 'Microsoft.Sql/servers@2022-02-01-preview' = {
  name: 'sqlServer-${environment}-${resourcePostfix}'
  location: location
  properties: {
    administratorLogin: 'mikita_ishchanka'
    administratorLoginPassword: '31415Qwerty'
  }
}

resource database 'Microsoft.Sql/servers/databases@2020-08-01-preview' = {
  parent: databaseServer
  name: 'sqlDBName-${environment}-${resourcePostfix}'
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

