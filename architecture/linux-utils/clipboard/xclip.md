https://www.cyberciti.biz/faq/xclip-linux-insert-files-command-output-intoclipboard/


copy the output of the following command to the Linux clipboard. The syntax is:
command | xclip
command | xclip -i

To paste selection to standard out or pipe, use the following command again:
xclip -o
xclip -o | myapp1 -arg1

xclip -selection clipboard -i < 'subject=CN_=__stackexchange_com.pem'

xclip -selection clipboard -i < hockeypuck.conf
