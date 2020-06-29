
/*  
  This configuration is automatically loaded by the pipelineHelper class.
  Property names are arbitrary, the syntax should conform to a map definition.
  Common properties and defaults are typically defined in 'project-config.groovy' 
  and overwrites (properties depending on a build environment) could be specified
  in 'project-config.<env>.groovy' files. 'dev', 'stg' and 'prd' environments are
  supported out of the box for builds from 'development', 'staging' or 'master' 
  branches (respectively).

  Any properties defined here can be referenced in the 'Jenkinsfile' or in the 
  'project-descripor.groovy' as properties of a 'helper.projConfig' variable, for example:

      echo "Hello-Java docker image name is: ${helper.projConfig.helloJavaImage}"

  Any properties defined here can be referenced in the 'project-descripor.groovy' 
  as properties of a 'projConfig' object, for example:

  
    
    services: [
      [ 
        image: projConfig.helloJavaImage,
        ...
      ]
    ]
*/
 
return [
  app1ctx: 'hello-py-1',
  app2ctx: 'hello-py-2',
  app1port: 5000,
  app2port: 5010
]