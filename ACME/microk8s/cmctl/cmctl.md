https://cert-manager.io/v1.6-docs/usage/cmctl/#installation

cmctl
cmctl is a CLI tool that can help you to manage cert-manager resources inside your cluster.

While also available as a kubectl plugin, it is recommended to use as a stand alone binary as this allows the use of command auto-completion.

Installation
You need the cmctl.tar.gz file for the platform you're using, these can be found on our GitHub releases page. In order to use cmctl you need its binary to be accessible under the name cmctl in your $PATH. Run the following commands to set up the CLI. Replace OS and ARCH with your systems equivalents:
OS=$(go env GOOS); ARCH=$(go env GOARCH); curl -L -o cmctl.tar.gz https://github.com/cert-manager/cert-manager/releases/download/v1.6.3/cmctl-$OS-$ARCH.tar.gz
tar xzf cmctl.tar.gz
sudo mv cmctl /usr/local/bin

Commands
Approve and Deny CertificateRequests
CertificateRequests can be approved or denied using their respective cmctl commands:

Note: The internal cert-manager approver may automatically approve all CertificateRequests unless disabled with the flag on the cert-manager-controller --controllers=*,-certificaterequests-approver


$ cmctl approve -n istio-system mesh-ca --reason "pki-team" --message "this certificate is valid"
Approved CertificateRequest 'istio-system/mesh-ca'

$ cmctl deny -n my-app my-app --reason "example.com" --message "violates policy"
Denied CertificateRequest 'my-app/my-app'

Create
cmctl create can be used to create cert-manager resources manually. Sub-commands are available to create different resources:

CertificateRequest
To create a cert-manager CertificateRequest, use cmctl create certificaterequest. The command takes in the name of the CertificateRequest to be created, and creates a new CertificateRequest resource based on the YAML manifest of a Certificate resource as specified by --from-certificate-file flag, by generating a private key locally and creating a 'certificate signing request' to be submitted to a cert-manager Issuer. The private key will be written to a local file, where the default is <name_of_cr>.key, or it can be specified using the --output-key-file flag.

If you wish to wait for the CertificateRequest to be signed and store the X.509 certificate in a file, you can set the --fetch-certificate flag. The default timeout when waiting for the issuance of the certificate is 5 minutes, but can be specified with the --timeout flag. The default name of the file storing the X.509 certificate is <name_of_cr>.crt, you can use the --output-certificate-file flag to specify otherwise.

Note that the private key and the X.509 certificate are both written to file, and are not stored inside Kubernetes.

For example this will create a CertificateRequest resource with the name "my-cr" based on the cert-manager Certificate described in my-certificate.yaml while storing the private key and X.509 certificate in my-cr.key and my-cr.crt respectively.


cmctl create certificaterequest my-cr --from-certificate-file my-certificate.yaml --fetch-certificate --timeout 20m
Renew
cmctl allows you to manually trigger a renewal of a specific certificate. This can be done either one certificate at a time, using label selectors (-l app=example), or with the --all flag:

For example, you can renew the certificate example-com-tls:

kubectl get certificate
NAME                       READY   SECRET               AGE
example-com-tls            True    example-com-tls      1d

$ cmctl renew example-com-tls
Manually triggered issuance of Certificate default/example-com-tls

$ kubectl get certificaterequest
NAME                              READY   AGE
example-com-tls-tls-8rbv2         False    10s



