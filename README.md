# blue-green-beanstalk-example

This is a simple example of how to use [Blue/Green Beanstalk](https://github.com/tmshkr/blue-green-beanstalk).

There are two sample GitHub Actions workflow:

- [blue-green.yml](.github/workflows/blue-green.yml) uses two environments to perform a blue/green deployment.
- [single-env.yml](.github/workflows/single-env.yml) uses a single environment, which may be useful for development/testing.

You can use the provided [CloudFormation template](./beanstalk-iam.yml) to create the necessary roles to deploy using the [GitHub OIDC provider](https://docs.github.com/en/actions/deployment/security-hardening-your-deployments/configuring-openid-connect-in-amazon-web-services).

```bash
aws cloudformation deploy \
  --stack-name beanstalk-iam \
  --template-file beanstalk-iam.yml \
  --capabilities CAPABILITY_NAMED_IAM \
  --parameter-overrides SubjectClaimFilters="repo:<USER|ORG>/<REPO>:*"
```
