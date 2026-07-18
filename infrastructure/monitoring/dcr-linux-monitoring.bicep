@description('Name of the Azure Monitor Data Collection Rule.')
param dcrName string = 'dcr-linux-monitoring-dev'

@description('Azure region for the Data Collection Rule.')
param location string = resourceGroup().location

@description('Full resource ID of the destination Log Analytics Workspace.')
param logAnalyticsWorkspaceResourceId string

@description('Project tag value.')
param project string

@description('Environment tag value.')
param environment string = 'Development'

@description('Owner tag value.')
param owner string

@description('Cost center tag value.')
param costCenter string = 'PortfolioLab'

@description('Expiration date tag value.')
param expirationDate string

@description('Tool or workflow responsible for managing the resource.')
param managedBy string = 'AzureCLI-Bicep'

resource linuxMonitoringDcr 'Microsoft.Insights/dataCollectionRules@2024-03-11' = {
  name: dcrName
  location: location
  kind: 'Linux'
  tags: {
    Project: project
    Environment: environment
    Owner: owner
    CostCenter: costCenter
    ExpirationDate: expirationDate
    ManagedBy: managedBy
  }
  properties: {
    description: 'Collects essential Linux performance counters and Syslog events for the Contoso development VM.'

    dataSources: {
      performanceCounters: [
        {
          name: 'linuxPerformanceCounters'
          streams: [
            'Microsoft-Perf'
          ]
          samplingFrequencyInSeconds: 60
          counterSpecifiers: [
            '\\Processor(_Total)\\% Processor Time'
            '\\Memory\\Available MBytes'
            '\\Logical Disk(*)\\% Free Space'
          ]
        }
      ]

      syslog: [
        {
          name: 'linuxSyslog'
          streams: [
            'Microsoft-Syslog'
          ]
          facilityNames: [
            'auth'
            'authpriv'
            'daemon'
            'syslog'
            'user'
          ]
          logLevels: [
            'Info'
            'Notice'
            'Warning'
            'Error'
            'Critical'
            'Alert'
            'Emergency'
          ]
        }
      ]
    }

    destinations: {
      logAnalytics: [
        {
          name: 'centralLogAnalytics'
          workspaceResourceId: logAnalyticsWorkspaceResourceId
        }
      ]
    }

    dataFlows: [
      {
        streams: [
          'Microsoft-Perf'
        ]
        destinations: [
          'centralLogAnalytics'
        ]
      }
      {
        streams: [
          'Microsoft-Syslog'
        ]
        destinations: [
          'centralLogAnalytics'
        ]
      }
    ]
  }
}

output dataCollectionRuleName string = linuxMonitoringDcr.name
output dataCollectionRuleId string = linuxMonitoringDcr.id
output destinationWorkspaceId string = logAnalyticsWorkspaceResourceId