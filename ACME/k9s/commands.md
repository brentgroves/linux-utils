# Commands

<https://k9scli.io/topics/commands/>

## port forward list

:pf

CLI Arguments
K9s CLI comes with a view arguments that you can use to launch the tool with different configuration.

# List all available CLI options

k9s help

# Get info about K9s runtime (logs, configs, etc..)

k9s info

# Run K9s in a given namespace

k9s -n mycoolns

# Run K9s and launch in pod view via the pod command

k9s -c pod

# Start K9s in a non default KubeConfig context

k9s --context coolCtx

# Start K9s in readonly mode - with all modification commands disabled

k9s --readonly

They are explained in the K9s release notes here

%CPU/R Percentage of requested cpu
%MEM/R Percentage of requested memory
%CPU/L Percentage of limited cpu
%MEM/L Percentage of limited memory
