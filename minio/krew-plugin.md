<https://github.com/canonical/microk8s/issues/841>

microk8s.kubectl plugin list

Is microk8s currently supporting plugins? Or I just mess up some setups...
I installed some popular plugins and kubectl was able to find them with plugin list

working-computer:~$ sudo microk8s.kubectl plugin list
The following compatible plugins are available:

/usr/local/bin/kubectl-ctx
/usr/local/bin/kubectl-krew
/usr/local/bin/kubectl-ns

But the ctl cannot find it when I try to use them

working-computer:~$ sudo microk8s.kubectl krew
Error: unknown command "krew" for "kubectl"
Run 'kubectl --help' for usage.

it could be apparmor is denying the execution of binaries outside the snap confines.

If you add the plugins inside $SNAP_DATA/bin and add this path to the bin would u be able to exec the plugin?

I think i know the issue here. microk8s.kubectl adds the option --kubeconfig= when invoked. This breaks kubectl when invoking a plugin.
In short it runs like this:
kubectl --kubeconfig='wherethekubeconfigis' krew --help

If running this on a standalone kubectl (i.e. not part of microk8s), it also spits out the same error.

Have you tried adding options in kubectl and pair it with a plugin execution?

Thank you for reporting and debugging this. Here is what you can do:

edit /var/snap/microk8s/current/args/kubectl and comment out the line that adds the --kubeconfig argument.
place the kubeconfig file in the default location so microk8s.kubectl can find it microk8s.config > ~/.kube/config
After that the plugin should work:

$ microk8s.kubectl krew
krew is the kubectl plugin manager.
You can invoke krew through kubectl: "kubectl krew [command]..."
