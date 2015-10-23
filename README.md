This project is result of MesosCon Europe 2015 Hackathon.
---------------------------------------------------------

Original aim was deploy Mesos cluster with:
 * Multiple Mesos master.
 * Multiple Mesos slaves.
 * Marathon and Chronos frameworks.
 * Zookeeper for service discovery.
 * Docker isolation support.
 * Auto-scaling to any size of cluster with AWS AutoScalingGroup.
 * Run all mesos components as docker containers.
 * Run on AWS EC2 instances.
 * Describe all infrasturcture with CloudFormation template.


Tech Stack ( Docker dependencies):
 * ogavrisevs/zookeeper-aws:latest
 * mesoscloud/mesos-master:0.24.1-centos-7
 * mesoscloud/mesos-slave:0.24.1-centos-7
 * mesoscloud/marathon:0.11.0-centos-7
 * mesoscloud/chronos:2.4.0-centos-7

You can deploy cluster by running CF template :

`aws cloudformation create-stack --stack-name mesos --template-body file:////aws/cloudformation.json`

You can access on any instance  :
 * Mesos master -> http://aws.instance.ip:5050
 * Marathon -> http://aws.instance.ip:8080
 * Chronos ->  http://aws.instance.ip:4400
