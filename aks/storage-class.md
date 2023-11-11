https://learn.microsoft.com/en-us/azure/aks/concepts-storage#storage-classes
scc.sh reports-aks-admin.yaml reports-aks-admin
kubectl get sc
NAME                    PROVISIONER          RECLAIMPOLICY   VOLUMEBINDINGMODE      ALLOWVOLUMEEXPANSION   AGE
azurefile               file.csi.azure.com   Delete          Immediate              true                   29m
azurefile-csi           file.csi.azure.com   Delete          Immediate              true                   29m
azurefile-csi-premium   file.csi.azure.com   Delete          Immediate              true                   29m
azurefile-premium       file.csi.azure.com   Delete          Immediate              true                   29m
default (default)       disk.csi.azure.com   Delete          WaitForFirstConsumer   true                   29m
managed                 disk.csi.azure.com   Delete          WaitForFirstConsumer   true                   29m
managed-csi             disk.csi.azure.com   Delete          WaitForFirstConsumer   true                   29m
managed-csi-premium     disk.csi.azure.com   Delete          WaitForFirstConsumer   true                   29m
managed-premium         disk.csi.azure.com   Delete          WaitForFirstConsumer   true                   29m
