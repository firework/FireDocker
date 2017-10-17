#!/usr/bin/env bash

# Env Variables
export APP_ENV=${APP_ENV:-local}
export APP_PORT=${APP_PORT:-80}
export DB_PORT=${DB_PORT:-3306}
export DB_ROOT_PASS=${DB_ROOT_PASS:-secret}
export DB_NAME=${DB_NAME:-docker}
export DB_USER=${DB_USER:-docker}
export DB_PASS=${DB_PASS:-secret}

# Normalize basedir
cd "$(dirname $0)"/../
BASE_DIR=$(pwd)

# Decide project name
PROJECT_NAME=$(basename $BASE_DIR)

# Decide which docker-compose file to use
COMPOSE_FILE="dev"

# Disable pseudo-TTY allocation for CI (Jenkins)
TTY=""

# if [ ! -z "$BUILD_NUMBER" ]; then
#     COMPOSE_FILE="ci"
#     TTY="-T"
# fi

COMPOSE="docker-compose -f $BASE_DIR/docker/compose.$COMPOSE_FILE.yml -p $PROJECT_NAME"

COMMAND_RUN="run --rm $TTY"
COMMAND_EXEC="exec"

if [ $# -gt 0 ]; then
    COMMAND=$1
    shift 1
else
    COMMAND="ps"
fi

case "$COMMAND" in
    "art" | "artisan")
        $COMPOSE $COMMAND_EXEC app php artisan "$@"
    ;;
    "composer")
        $COMPOSE $COMMAND_EXEC app composer "$@"
    ;;
    "t" | "test")
        $COMPOSE $COMMAND_EXEC app ./vendor/bin/phpunit "$@"
    ;;
    "node")
        $COMPOSE $COMMAND_RUN node "$@"
    ;;
    "npm" | "yarn")
        $COMPOSE $COMMAND_RUN node $COMMAND "$@"
    ;;
    "exec")
        $COMPOSE $COMMAND_EXEC "$@"
    ;;
    "run")
        $COMPOSE $COMMAND_RUN "$@"
    ;;
    *)
        $COMPOSE $COMMAND "$@"
    ;;
esac
