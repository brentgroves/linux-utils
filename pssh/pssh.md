https://www.cyberciti.biz/cloud-computing/how-to-use-pssh-parallel-ssh-program-on-linux-unix/
parallel-ssh is pssh
parallel-scp is pscp
parallel-rsync is prsync
parallel-nuke is pnuke
parallel-slurp is pslurp
https://stackoverflow.com/questions/4437331/pssh-and-known-hosts-file
#!/bin/bash
cat ~/.ssh/id_ed25519.pub                    \
    | parallel-ssh -O StrictHostKeyChecking=no -h ips.txt -l remoteuser -A -I -i  \
    '                                         \
      umask 077;                              \
      mkdir -p ~/.ssh;                        \
      afile=~/.ssh/authorized_keys;           \
      cat - >> $afile;                        \
      sort -u $afile -o $afile                \
    '  

# cat ~/.ssh/id_ed25519.pub | parallel-ssh -O StrictHostKeyChecking=no -h ips.txt -l remoteuser -A -I -i 'umask 077; mkdir -p ~/.ssh; afile=~/.ssh/authorized_keys; cat - >> $afile; sort -u $afile -o $afile'    
Rather than type your password multiple times you can make use of pssh and its -A switch to prompt for it once, and then feed the password to all the servers in a list.

NOTE: Using this method doesn't allow you to use ssh-copy-id, however, so you'll need to roll your own method for appending your SSH pub key file to your remote account's ~/.ssh/authorized_keys file.

Example
Here's an example that does the job:

$ cat ~/.ssh/my_id_rsa.pub                    \
    | pssh -h ips.txt -l remoteuser -A -I -i  \
    '                                         \
      umask 077;                              \
      mkdir -p ~/.ssh;                        \
      afile=~/.ssh/authorized_keys;           \
      cat - >> $afile;                        \
      sort -u $afile -o $afile                \
    '
Warning: do not enter your password if anyone else has superuser
privileges or access to your account.
Password:
[1] 23:03:58 [SUCCESS] 10.252.1.1
[2] 23:03:58 [SUCCESS] 10.252.1.2
[3] 23:03:58 [SUCCESS] 10.252.1.3
[4] 23:03:58 [SUCCESS] 10.252.1.10
[5] 23:03:58 [SUCCESS] 10.252.1.5
[6] 23:03:58 [SUCCESS] 10.252.1.6
[7] 23:03:58 [SUCCESS] 10.252.1.9
[8] 23:03:59 [SUCCESS] 10.252.1.8
[9] 23:03:59 [SUCCESS] 10.252.1.7
The above script is generally structured like so:

$ cat <pubkey> | pssh -h <ip file> -l <remote user> -A -I -i '...cmds to add pubkey...'
High level pssh details
cat <pubkey> outputs the public key file to pssh
pssh uses the -I switch to ingest data via STDIN
-l <remote user> is the remote server's account (we're assuming you have the same username across the servers in the IP file)
-A tells pssh to ask for your password and then reuse it for all the servers that it connects to
-i tells pssh to send any output to STDOUT rather than store it in files (itparallel-ssh is pssh
parallel-scp is pscp
parallel-rsync is prsync
parallel-nuke is pnuke
parallel-slurp is pslurpremote servers
These are the commands that pssh will run on each server:

'                                         \
  umask 077;                              \
  mkdir -p ~/.ssh;                        \
  afile=~/.ssh/authorized_keys;           \
  cat - >> $afile;                        \
  sort -u $afile -o $afile                \
'
In order:
set the remote user's umask to 077, this is so that any directories or files we're going to create, will have their permissions set accordingly like so:

  $ ls -ld ~/.ssh ~/.ssh/authorized_keys
  drwx------ 2 remoteuser remoteuser 4096 May 21 22:58 /home/remoteuser/.ssh
  -rw------- 1 remoteuser remoteuser  771 May 21 23:03 /home/remoteuser/.ssh/authorized_keys
create the directory ~/.ssh and ignore warning us if it's already there

set a variable, $afile, with the path to authorized_keys file

cat - >> $afile - take input from STDIN and append to authorized_keys file

sort -u $afile -o $afile - uniquely sorts authorized_keys file and saves it

NOTE: That last bit is to handle the case where you run the above multiple times against the same servers. This will eliminate your pubkey from getting appended multiple times.

Notice the single ticks!
Also pay special attention to the fact that all these commands are nested inside of single quotes. That's important, since we don't want $afile to get evaluated until after it's executing on the remote server.

'               \
   ..cmds...    \
'
I've expanded the above so it's easier to read here, but I generally run it all on a single line like so:

$ cat ~/.ssh/my_id_rsa.pub | pssh -h ips.txt -l remoteuser -A -I -i 'umask 077; mkdir -p ~/.ssh; afile=~/.ssh/authorized_keys; cat - >> $afile; sort -u $afile -o $afile'
Bonus material
By using pssh you can forgo having to construct files and either provide dynamic content using -h <(...some command...) or you can create a list of IPs using another of pssh's switches, -H "ip1 ip2 ip3".

For example:

$ cat .... | pssh -h <(grep -A1 dp15 ~/.ssh/config | grep -vE -- '#|--') ...
The above could be used to extract a list of IPs from my ~/.ssh/config file. You can of course also use printf to generate dynamic content too:

$ cat .... | pssh -h <(printf "%s\n" srv0{0..9}) ....
For example:

$ printf "%s\n" srv0{0..9}
srv00
srv01
srv02
srv03
srv04
srv05
srv06
srv07
srv08
srv09
You can also use seq to generate formatted numbers sequences too!

References & similar tools to pssh
If you don't want to use pssh as I've done so above there are some other options available.

sshpt
Ansible's authorized_key_module
