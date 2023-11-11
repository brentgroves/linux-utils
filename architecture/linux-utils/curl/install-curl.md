# install with apt

This might already be installed but if you need a newer version then remove apt installed version and install from snap store or conda.

sudo apt install curl

## Install from snap store

sudo snap install curl

## Install from conda

conda install -c conda-forge curl
The following NEW packages will be INSTALLED:

  c-ares             conda-forge/linux-64::c-ares-1.19.1-hd590300_0 None
  curl               conda-forge/linux-64::curl-8.2.0-hca28451_0 None
  keyutils           conda-forge/linux-64::keyutils-1.6.1-h166bdaf_0 None
  krb5               conda-forge/linux-64::krb5-1.21.1-h659d440_0 None
  libcurl            conda-forge/linux-64::libcurl-8.2.0-hca28451_0 None
  libedit            conda-forge/linux-64::libedit-3.1.20191231-he28a2e2_2 None
  libev              conda-forge/linux-64::libev-4.33-h516909a_1 None
  libnghttp2         conda-forge/linux-64::libnghttp2-1.52.0-h61bc06f_0 None
  libssh2            conda-forge/linux-64::libssh2-1.11.0-h0841786_0 None
  zstd               conda-forge/linux-64::zstd-1.5.2-hfc55251_7 None

The following packages will be UPDATED:

  ca-certificates                      2022.12.7-ha878542_0 --> 2023.7.22-hbcca054_0 None
  openssl                                  3.1.0-h0b41bf4_0 --> 3.1.1-hd590300_1 None

curl --version
curl 8.2.0 (x86_64-conda-linux-gnu) libcurl/8.2.0 OpenSSL/3.1.1 zlib/1.2.13 zstd/1.5.2 libssh2/1.11.0 nghttp2/1.52.0
Release-Date: 2023-07-19
Protocols: dict file ftp ftps gopher gophers http https imap imaps mqtt pop3 pop3s rtsp scp sftp smb smbs smtp smtps telnet tftp
Features: alt-svc AsynchDNS GSS-API HSTS HTTP2 HTTPS-proxy IPv6 Kerberos Largefile libz NTLM NTLM_WB SPNEGO SSL threadsafe TLS-SRP UnixSockets zstd

# older version of curl will be present if you are using an older openssl version from anaconda

curl 7.82.0 (x86_64-conda-linux-gnu) libcurl/7.82.0 OpenSSL/1.1.1n zlib/1.2.12 libssh2/1.10.0 nghttp2/1.46.0
Release-Date: 2022-03-05
Protocols: dict file ftp ftps gopher gophers http https imap imaps mqtt pop3 pop3s rtsp scp sftp smb smbs smtp smtps telnet tftp
Features: alt-svc AsynchDNS GSS-API HSTS HTTP2 HTTPS-proxy IPv6 Kerberos Largefile libz NTLM NTLM_WB SPNEGO SSL TLS-SRP UnixSockets
