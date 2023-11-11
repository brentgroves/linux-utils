<https://pnpm.io/installation>

curl -fsSL <https://get.pnpm.io/install.sh> | sh -

Copying pnpm CLI from /tmp/tmp.m6uU6IQIZU/pnpm to /home/brent/.local/share/pnpm/pnpm
Appended new lines to /home/brent/.zshrc

Next configuration changes were made:
export PNPM_HOME="/home/brent/.local/share/pnpm"
case ":$PATH:" in
  *":$PNPM_HOME:"*) ;;
  *) export PATH="$PNPM_HOME:$PATH" ;;
esac
