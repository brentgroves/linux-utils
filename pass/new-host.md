Using our password store on a new host is easy now.

Import your keypair.
ssh brent@reports31
lftp brent@reports-avi
> get pubkey.asc
> get privkey.asc

$ gpg --import pubkey.asc
$ gpg --allow-secret-key-import --import privkey.asc
gpg --edit-key brent.groves@gmail.com
>trust
cd ~
git clone git@ssh.dev.azure.com:v3/MobexGlobal/MobexCloudPlatform/pass .password-store

pass generate test4 10
pass git push origin master

ssh brent@reports-avi
pass git pull origin master

https://gist.github.com/abtrout/d64fb11ad6f9f49fa325
https://www.gnupg.org/gph/en/manual.html#AEN346
https://gist.github.com/abtrout/d64fb11ad6f9f49fa325
At this point you can use pass on each host and manually synch them with pass git push and pass git pull. To delete your password store, just rm -rf ~/.password-store.