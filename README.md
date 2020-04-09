This is Java Spring Boot project which exposes some simple restful apis to add, update, delete, query student details. 
The data is persisted in MySql DB, connectivity to which is configurable via application properties.

Technologies used for development - **Spring Boot**, **Spring Data JPA**, **Maven**, **Docker**, **Terraform**, **Github Actions**, **Mysql** 

For Local Setup - Software required - _Git_, _Java_, _Apache Maven_, _Docker_, _Terraform_, Any IDE like _IntelliJ_ or _Eclipse_


_**Build & Run Locally**_ 

This is a maven project. The artifact generated is a executable jar. 

**mvn clean install** (will run the unit tests before building the artifact jar).
Unit Tests and Integration Tests are inside src/test. The integration test files are named like *IntegrationTests.java

For running the integration tests run the custom maven integration profile - **mvn clean install -Pintegration**. 
The **integration tests**, runs by starting **H2 in-memory DB**, created in test application context.

**Code Coverage report** generated using jacoco maven plugin. Runs for both unit tests and integration test phases. 

Easiest way to run and manually test the application locally is by running **docker-compose up**. 
It run the **mysql container** locally, using the file **Dockerfile-mysql** and sets up mysql user required by the application.
Also, Application docker image is built locally using the Dockerfile, and run with the linked mysql container.

The apis can be accessed over port 8080. Swagger API documentation added.
The swagger ui has details of all the apis which can be accessed over /swagger-ui.html

Actuator enabled for metrics and health related info. url - /actuator


_****Deployment architecture on AWS****_

* VPC with Private Subnets(with Nat Gateways) and Public Subnets(with Internet gateways).
* ECS cluster comprising of EC2 instances launched in private subnets. The EC2 instances are part of Autoscaling group.
* RDS MariaDB instance launched in private subnets. Access to EC2 instances or API containers are given using db security groups allowing inbound connections to port 3306 for the compute subnets. 
* Application LB(in public subnet) for load balancing the containers launched by ECS services. The APIs can be accessed using the load balancer DNS.
* ECS Task Definitions and Services to run and orchestrate the API containers. 
 
More details in the terraform configuration files inside **terraform directory**. Steps to run the terraform configs are mentioned in the readme inside terraform directory.
 
_**Build and Deployment Pipelines**_

Build and Deployment pipelines are created using Github Actions. Workflow files are present in **.github/workflows** directory.

There is a infra-deployment workflow(create-infra-resources.yml) for creating the AWS infrastructure.
It is triggered on creation of a tag named in the pattern INFRA-DEPLOY-* or when any push is done to terraform/infra/ or terraform/db directories.
This pipeline has to be run before the CI/CD pipeline is triggered.

The CI/CD pipeline for API build and deployment is ci-cd.yml inside .github/workflows directory.
This pipeline is trigegred when any code change is made in src directory.

Stages are - 
* Code Checkout
* Maven Build, Test, Create Jar
* Store test and code coverage artifacts
* Build Docker Image and Push to DockerHub repository.
* Update docker image version in Task Definition config file and perform update of AWS ECS TaskDefinition and Services
