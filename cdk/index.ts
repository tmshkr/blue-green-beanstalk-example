import * as iam from "aws-cdk-lib/aws-iam";
import * as cdk from "aws-cdk-lib";

export class BlueGreenBeanstalkStack extends cdk.Stack {
  constructor(scope: cdk.App, id: string, props?: cdk.StackProps) {
    super(scope, id, props);

    const user = new iam.User(this, "BlueGreenBeanstalkUser");
    user.addManagedPolicy({
      managedPolicyArn:
        "arn:aws:iam::aws:policy/AdministratorAccess-AWSElasticBeanstalk",
    });
    user.addManagedPolicy({
      managedPolicyArn:
        "arn:aws:iam::aws:policy/ElasticLoadBalancingFullAccess",
    });
  }
}

const app = new cdk.App();
new BlueGreenBeanstalkStack(app, "MyStack");
