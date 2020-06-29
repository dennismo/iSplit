### Project Configuration & Jenkins Pipeline

This folder contains the application (project) configuration and Jenkins Pipeline scripts used for a continues integration & deployment cycle of this SSEB-deployable application.

- `Jenkinsfile` - a Jenkins pipeline that deploys the application into a Cloud Workbench environment. This is the script that has to be pointed to in the created Jenking pipeline configuration. For details see this [Tutorial](https://thehub.thomsonreuters.com/docs/DOC-2564738) on the Hub. The pipeline consist of the following _stages_: 
  - 'Init build' - standard CDW pipeline initialization, like loading project desriptor and configuration files and determining the target deployment environment - the logic is encapsulated in the shared library's [PipelineHelper](https://git.sami.int.thomsonreuters.com/cloud-provisioning/sseb-pipeline-shared/blob/master/src/com/trgr/pipeline/sseb/PipelineHelper.groovy) class 
  - Hello-Java service - gradle build
  - Hello-Java service - docker image build
  - Hello-Python service - docker image build
  - 'Deploy' - deployment of service docker containers ans the static frontend code to the target Cloud Workbech environment - the deployment logic is encapsulated in the shared library's [PipelineHelper](https://git.sami.int.thomsonreuters.com/cloud-provisioning/sseb-pipeline-shared/blob/master/src/com/trgr/pipeline/sseb/Project.groovy) class.

- `project-config.groovy` - this configuration is automatically loaded by the pipelineHelper class. Property names  are arbitrary, the syntax should conform to a Groovy map definition. Common properties and defaults are typically defined in this file and overwrites (property values depending on a build environment) could be specified in `project-config.<env>.groovy` files - where environments _dev_, _stg_ and _prd_ are supported out of the box for builds originating from _development_, _staging_ or _master_ branches (respectively).

- `project-descriptor.groovy` - this is the application's deployment descriptor. At a high level it defines the following:
   - the application name - has to be unique within the target environment
   - local directory where the frontend static code (if any) is located and is to be deployed to the envionment
   - a list of services to be deployed:
      - each service is essentially a docker container deployed into the ECS cluser (as an ECS service/task)
      - many more configuration options are available but most of them have sensible defaults and only a handfull are required to be provided explicitly. At present, the best way to learn about the full set of available/supported properties is to look directly at the shared pipeline library [code](https://git.sami.int.thomsonreuters.com/cloud-provisioning/sseb-pipeline-shared/tree/master/vars).
