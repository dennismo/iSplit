// You can reference projConfig variable to access properties defined in the project-config[.<stage>].groovy files
return [
  version: 2,
  project: 'trlabs-cw-flask-boilerplate',
  resourceDir: 'aws/resources',
  cfTemplate: 'cloudformation/main-cf.yml',
  webSource: [
    type: 'service'
  ],
  services: [
    [
      name: 'backend-simple',
      composeDir: 'services/backend-simple',
      contextPath: '/'+projConfig.app1ctx,
      healthCheckPath: '/health',
      targetContainer: 'backend',
      targetPort: projConfig.app1port
    ]
    // , [
    //   name: 'backend-with-data-model',
    //   composeDir: 'services/backend-with-data-model',
    //   contextPath: '/'+projConfig.app2ctx,
    //   healthCheckPath: '/health',
    //   targetContainer: 'backend',
    //   targetPort: projConfig.app2port
    // ]
  ]
]
