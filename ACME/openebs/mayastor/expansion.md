<https://mayastor.gitbook.io/introduction/quickstart/configure-mayastor/storage-class-parameters>

I don't know if you can because this is not one of the paramaters discussed in the storage-class document

For a pool of a particular size, say 10 Gigabytes, a volume > 10 Gigabytes cannot be created, as Mayastor currently does not support pool expansion.

allowVolumeExpansion: true
