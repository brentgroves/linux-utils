<https://komodor.com/learn/kubernetes-operator/>

What Is the Operator SDK?
The Operator SDK is a toolkit for building Kubernetes operators. It includes a CLI, a set of libraries, and a number of tools that make it easier to develop and maintain operators.

Some of the main components of the Operator SDK are:

CLI: The Operator SDK includes a CLI that provides a number of commands for developing and maintaining operators. These commands can be used to create a new operator project, generate code and manifests, and build and test the operator.
Make build automation tool: The Operator SDK uses the Make build automation tool to manage the build process for operators. Make is a powerful tool that allows you to define a set of build rules for your operator, and then automate the build process using these rules.
Pre-built Make commands: The Operator SDK includes a set of pre-built Make commands that can be used to automate common tasks such as building and testing the operator, and generating manifests.
Operator Lifecycle Manager (OLM): The Operator Lifecycle Manager (OLM) is a component of the Operator SDK that helps to manage the lifecycle of operators in a cluster. It includes a set of controllers that handle tasks such as installing, upgrading, and uninstalling operators, and ensuring that they are running correctly.

An Example: Creating a Simple Kubernetes Operator
To create a Kubernetes operator, you first define a custom resource definition (CRD) for the resource you want to manage. For example, you might define a CRD named SampleDB to represent a sample database instance.

Next, you write a custom controller that watches for instances of the SampleDB resource and performs actions based on changes to these resources. For example, the controller might deploy a database instance when a SampleDB resource is created, or take a backup of the database when the SampleDB resource is updated.

To deploy an operator, you first build the operator using the Operator SDK or another tool. Then you create a deployment in the cluster that runs the operator, and create an instance of the SampleDB resource using kubectl or another tool.

Once the operator is deployed and the SampleDB resource is created, the operator will begin to manage the resource. It will perform tasks such as deploying the database, taking backups, handling upgrades, and simulating failure.

Here is an example showing how to define a CRD and write a controller for the new operator:

Step 1: Define the SampleDB custom resource definition (CRD)

apiVersion: apiextensions.k8s.io/v1beta1
kind: CustomResourceDefinition
metadata:
  name: sampledbs.app.example.com
spec:
  group: app.example.com
  names:
    kind: SampleDB
    plural: sampledbs
  scope: Namespaced
  version: v1

  Write the operator controller:

package main

import (
 "fmt"
 "time"

 "github.com/operator-framework/operator-sdk/pkg/sdk"
 "github.com/operator-framework/operator-sdk/pkg/util/k8sutil"
 sdkVersion "github.com/operator-framework/operator-sdk/version"

 "github.com/example/app-operator/pkg/apis"
 "github.com/example/app-operator/pkg/controller"
)

func main() {
 sdk.ExposeMetricsPort()

 resource := "app.example.com/v1/sampledbs"
 kind := "SampleDB"
 namespace, err := k8sutil.GetWatchNamespace()
 if err != nil {
  fmt.Println(err)
  os.Exit(1)
 }
 resyncPeriod := time.Duration(5) * time.Second
 logger := log.NewLogfmtLogger(os.Stderr)
 logger = log.With(logger, "ts", log.DefaultTimestampUTC)
 logger = log.With(logger, "caller", log.DefaultCaller)

 ctx := sdk.New(sdkVersion.Version, sdk.WithLogger(logger), sdk.WithNamespace(namespace))

 sdk.Watch(resource, kind, namespace, resyncPeriod)
 sdk.Handle(controller.NewHandler() )
}
