What we have learned:
We can have at least 3 ingress controllers running if we each ingress daemonset yaml has a name to link to the ingress service and unique ingress-class defined in the args section. We must also specify that ingress-class in the applications ingress obect yaml.
<!-- https://kubernetes.github.io/ingress-nginx/user-guide/multiple-ingress/#multiple-ingress-nginx-controllers -->
<!-- https://www.bmc.com/blogs/kubernetes-daemonset/ -->
<!-- https://github.com/canonical/microk8s/issues/2035 -->
