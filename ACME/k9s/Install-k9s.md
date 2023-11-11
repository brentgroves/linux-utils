# Install K9s

- I have not used K9s much.  It could be helpful but I suggest learning kubectl first to make sure you know what K9s is doing.

**[Install K9s](https://k9scli.io/topics/install/)**

## Via LinuxBrew

- This works but the snap install did not install k9s in /snap/bin but it did install config files in /var/snap/k9s

brew install derailed/k9s/k9s

## Via Snap (Dont use this way)

DOES NOT INSTALL THE BINARY AT /snap/bin for some unknown reason.

<https://askubuntu.com/questions/1477547/installing-k9s-on-ubuntu>
snap info k9s
[...]
channels:
  latest/stable:    v0.27.4 2023-06-10 (155) 19MB -
  latest/candidate: ↑
  latest/beta:      ↑
  latest/edge:      0.5.1   2019-04-19  (99)  9MB devmode
If you DON'T have the k9s snap installed, then
snap install k9s --channel=latest/stable
k9s v0.27.4 from Fernand Galiana (derailed) installed

If you DO already have the k9s snap installed, then
snap refresh k9s --channel=latest/stable

## snap did not work

<https://github.com/derailed/k9s/issues/144>
sudo snap install k9s

<https://webinstall.dev/k9s/>
<https://github.com/derailed/k9s>

Action Command Comment
Show active keyboard mnemonics and help ?
Show all available resource alias ctrl-a
To bail out of K9s :q, ctrl-c
View a Kubernetes resource using singular/plural or short-name :po⏎ accepts singular, plural, short-name or alias ie pod or pods
View a Kubernetes resource in a given namespace :alias namespace⏎
Filter out a resource view given a filter /filter⏎ Regex2 supported ie `fred
Inverse regex filter /! filter⏎ Keep everything that doesn't match.
Filter resource view by labels /-l label-selector⏎
Fuzzy find a resource given a filter /-f filter⏎
Bails out of view/command/filter mode <esc>
Key mapping to describe, view, edit, view logs,... d,v, e, l,...
To view and switch to another Kubernetes context :ctx⏎
To view and switch to another Kubernetes context :ctx context-name⏎
To view and switch to another Kubernetes namespace :ns⏎
To view all saved resources :screendump or sd⏎
To delete a resource (TAB and ENTER to confirm) ctrl-d
To kill a resource (no confirmation dialog!) ctrl-k
Launch pulses view :pulses or pu⏎
Launch XRay view :xray RESOURCE [NAMESPACE]⏎ RESOURCE can be one of po, svc, dp, rs, sts, ds, NAMESPACE is optional
Launch Popeye view :popeye or pop⏎ See popeye
