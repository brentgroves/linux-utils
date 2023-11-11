https://unix.stackexchange.com/questions/368123/how-to-extract-the-root-ca-and-subordinate-ca-from-a-certificate-chain-in-linux/487546#487546

The following command prints all records in mail-list that contain either ‘edu’ or ‘li’ (or both, of course):

$ awk '/edu/ || /li/' mail-list
-| Amelia       555-5553     amelia.zodiacusque@gmail.com    F
-| Broderick    555-0542     broderick.aliquotiens@yahoo.com R
-| Fabius       555-1234     fabius.undevicesimus@ucb.edu    F
-| Julie        555-6699     julie.perscrutabor@skeeve.com   F
-| Samuel       555-3430     samuel.lanceolis@shu.edu        A
-| Jean-Paul    555-2127     jeanpaul.campanorum@nyu.edu     R

The following command prints all records in mail-list that do not contain the string ‘li’:

$ awk '! /li/' mail-list
