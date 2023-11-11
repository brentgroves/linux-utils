https://gist.github.com/BenSampo/aa5f72584df79f679a7e603ace517c14
curl -s "https://laravel.build/example-app?with=mysql,redis" | bash
curl -s "https://laravel.build/example-app?with=mysql,redis&devcontainer" > deploy-with-devcontainer.sh
curl -s "https://laravel.build/example-app?with=mysql,redis" > deploy.sh