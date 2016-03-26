npm-exec
========

Install script
--------------

```sh
curl -o- https://raw.githubusercontent.com/rcsole/npm-exec/v1.0.0/install.sh | bash

wget -qO- https://raw.githubusercontent.com/rcsole/npm-exec/v1.0.0/install.sh | bash
```

Usage
-----

This is intended to work as a `bundle exec` in your projects. So you can
use your locally installed packages (like generators, eg. tsc, sequelize-cli...)
and avoid using global packages.

It will, in theory, take every argument you give it. The first argument being
the command to run.

```
npm-exec tsc -w

# would run

node_modules/.bin/tsc -w
```
