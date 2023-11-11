{
  "listeners": {
      "*:8080": {
          "pass": "applications/php"
      }
  },
  "applications": {
      "php": {
          "type": "php",
          "root": "/usr/share/doc/unit-php/examples/phpinfo-app"
      }
  }
}