https://linuxconfig.org/how-to-disable-keyring-popup-on-ubuntu
How to disable keyring popup on Ubuntu
13 April 2022 by Korbin Brown
Ubuntu’s keyring is a feature that collects all of your passwords in a secure application (gnome-keyring) and will use these stored passwords to automatically log you in to various services. All of your stored passwords inside of the keyring are protected by a single master password. The keyring gets “unlocked” when you first provide your system password at sign in.

Users that have enabled automatic log in for their system may have noticed a persistent and annoying popup message that says The login keyring did not get unlocked when you logged into your computer. This is just the gnome-keyring application asking for your password so that it can be used to authenticate with various services and applications on your system.

The problem is that having an automatic login does not do you much good if you still need to provide your password every reboot for some other application. In this tutorial, you will see how to deactivate the keyring pop up on an Ubuntu Linux system.

In this tutorial you will learn:

How to disable keyring popup message on Ubuntu


https://itsfoss.com/ubuntu-keyring/

Let me tell you something. It’s not an error. It’s a security feature.

Surprised? Let me explain the keyring concept in Linux.

What is keyring in Linux and why is it used?

Why do you use a keyring (also called keychain) in the real life? You use it to keep one or more keys grouped together so that they are easy to find and carry.

It’s the same concept in Linux. The keyring feature allows your system to group various passwords together and keep it one place.

Most desktop environments like GNOME, KDE, Xfce etc use an implementation of gnome-keyring to provide this keyring feature in Linux.

This keyring keeps your ssh keys, GPG keys and keys from applications that use this feature, like Chromium browser. By default, the keyring is locked with a master password which is often the login password of the account.

Every user on your system has its own keyring with (usually) the same password as that of the user account itself. When you login to your system with your password, your keyring is unlocked automatically with your account’s password.

The problem comes when you switch to auto-login in Ubuntu. This means that you login to the system without entering the password. In such case, your keyring is not unlocked automatically.

Keyring is a security feature
Remember I told you that the keyring was a security feature? Now imagine that on your Linux desktop, you are using auto-login. Anyone with access to your desktop can enter the system without password but you have no issues with that perhaps because you use it to browse internet only.

But if you use a browser like Chromium or Google Chrome in Ubuntu, and use it to save your login-password for various websites, you have an issue on your hand. Anyone can use the browser and login to the websites for which you have saved password in your browser. That’s risky, isn’t it?

This is why when you try to use Chrome, it will ask you to unlock the keyring repeatedly. This ensures that only the person who knows the keyring’s password (i.e. the account password) can use the saved password in browser for logging in to their respective websites.

If you keep on cancelling the prompt for keyring unlock, it will eventually go away and let you use the browser. However, the saved password won’t be unlocked and you’ll see ‘sync paused’ in Chromium/Chrome browsers.

You can easily manage the keyring and passwords
Where is this keyring located? At the core, it’s a daemon (a program that runs automatically in the background).

Don’t worry. You don’t have to ‘fight the daemon’ in the terminal. Most desktop environments come with a graphical application that interacts with this daemon. On KDE, there is KDE Wallet, on GNOME and others, it’s called Password and Keys (originally known as Seahorse).

Password And Keys App Ubuntu
Password And Keys App in Ubuntu
You can use this GUI application to see what application use the keyring to manage/lock passwords.

As you can see, my system has the login keyring which is automatically created. There is also a keyrings for storing GPG and SSH keys. The Certificates is for keeping the certificates (like HTTPS certificates) issued by a certificate authority.

**[keyring](https://itsfoss.com/content/images/wordpress/2020/03/keyring-pasword-ubuntu.png)**

You can also use this application to manually store passwords for website. For example, I created a new password-protected keyring called ‘Test’ and stored a password in this keyring manually.

This is slightly better than keeping a list of passwords in a text file. At least in this case your passwords can be viewed only when you unlock the keyring with password.

One potential problem here is that if you format your system, the manually saved passwords are definitely lost. Normally, you make backup of personal files, not of all the user specific data such as keyring files.

There is way to handle that. The keyring data is usually stored in ~/.local/share/keyrings directory. You can see all the keyrings here but you cannot see its content directly. If you remove the password of the keyring (I’ll show the steps in later section of this article), you can read the content of the keyring like a regular text file. You can copy this unlocked keyring file entirely and import it in the Password and Keys application on some other Linux computer (running this application).

So, let me summarize what you have learned so far:

Most Linux has this ‘keyring feature’ installed and activated by default
Each user on a system has its own keyring
The keyring is normally locked with the account’s password
Keyring is unlocked automatically when you login with your password
For auto-login, the keyring is not unlocked and hence you are asked to unlock it when you try to use an application that uses keyring
Not all browsers or application use the keyring feature
There is a GUI application installed to interact with keyring
You can use the keyring to manually store passwords in encrypted format
You can change the keyring password on your own
You can export (by unlocking the keyring first) and import it on some other computer to get your manually saved passwords
Change keyring password
Suppose you changed your account password. Now when you login, your system tries to unlock the keyring automatically using the new login password. But the keyring still uses the old login password.

In such a case, you can change the keyring password to the new login password so that the keyring gets unlocked automatically as soon as you login to your system.

Open the Password and Keys application from the menu:

