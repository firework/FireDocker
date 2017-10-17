### Getting started with Docker

Add `project-name.app` to your `/etc/hosts` is recommended:

````bash
127.0.0.1  project-name.app
````

```bash
# Build app/node images
./docker/develop.sh build # d build

# Get laravel requirements
./docker/develop.sh composer install # dci
./docker/develop.sh yarn install # dyi
./docker/develop.sh node gulp # dg

# Spin up Laravel (defaults to binding to port 80)
./docker/develop.sh up -d # dud

# Alternatively, bind to port 8888 (or any other port)
APP_PORT=8888 ./docker/develop.sh up -d # APP_PORT=8888 dud

# Run Migration and Seed
./docker/develop.sh art migrate --seed # dms

# Run tests
./docker/develop.sh test # dt
```

Some useful aliases:

````bash
alias d="./docker/develop.sh"
alias db="d build"
alias du="d up"
alias dud="d up -d"
alias ds="d stop"
alias dd="d down"
alias dp="d php"
alias dc="d composer"
alias dci="dc install"
alias da="d art"
alias dm="da migrate"
alias dms="dm --seed"
alias dn="d node"
alias dy="d yarn"
alias dyv="dy dev"
alias dyw="dy watch"
alias dyp="dy prod"
````
