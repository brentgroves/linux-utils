certmgr.msc


https://success.outsystems.com/support/enterprise_customers/installation/add_self_signed_certificate_to_trusted_root_store_on_outsystems/
Certificate installation
Open the Microsoft Management Console (Start > MMC);
Provide the self-signed certificate:
Choose File > Add/Remove Snap-in;
in the standalone tab, choose Add;
choose the Certificates snap-in > Add;
in the wizard, choose the Computer Account > Local Computer;
press Finish to end the wizard;
close the Add/Remove Snap-in dialog;
Navigate to Certificates (Local Computer);
choose the Trusted Root Certification Authorities store to import the certificate;
right click the store and choose All Tasks > Import ;
Follow the wizard and provide the certificate file you have.
Export the certificate
Export the public certificate to the following path: D:\Certificates:

Still on the Microsoft Management Console;
choose Certificates (Local Computer) > select the folder where the certificate was installed > Certificates;
right-click on the certificate > All Tasks > Export;
choose to export the certificate without the private key;
choose the format to be DER encoded binary X.509 (CER);
save the file into D:\Certificates.
