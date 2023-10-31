# blue-green-beanstalk-example

This is a simple example of how to use [Blue/Green Beanstalk](https://github.com/tmshkr/blue-green-beanstalk).

The sample GitHub Actions workflow is in [deploy.yml](.github/workflows/deploy.yml).

An AWS IAM user or role with the `AdministratorAccess-AWSElasticBeanstalk` and `ElasticLoadBalancingFullAccess` policies attached will provide sufficient permissions to run the GitHub Action.

You can use the provided [CDK stack](./cdk) to create an IAM user.
