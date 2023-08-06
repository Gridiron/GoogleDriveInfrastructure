param location string = resourceGroup().location
param environmentName string
param resourcePostfix string

param skuName string = 'Basic'

param queueNames array = [
  'uploadqueue', 'notificationqueue'
]

var deadLetterFirehoseQueueName = 'deadletterfirehose'
var serviceBusNamespaceName = 'googledrive${environmentName}${resourcePostfix}'


resource serviceBusNamespace 'Microsoft.ServiceBus/namespaces@2022-01-01-preview' = {
  name: serviceBusNamespaceName
  location: location
  sku: {
    name: skuName
  }
}

resource deadLetterFirehoseQueue 'Microsoft.ServiceBus/namespaces/queues@2022-01-01-preview' = {
  name: deadLetterFirehoseQueueName
  parent: serviceBusNamespace
  properties: {
    requiresDuplicateDetection: false
    requiresSession: false
    enablePartitioning: false
  }
}

resource queues 'Microsoft.ServiceBus/namespaces/queues@2022-01-01-preview' = [for queueName in queueNames: {
  parent: serviceBusNamespace
  name: queueName
  dependsOn: [
    deadLetterFirehoseQueue
  ]
  properties: {
    forwardDeadLetteredMessagesTo: deadLetterFirehoseQueueName
  }
}]
