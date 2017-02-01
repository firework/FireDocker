#!/usr/bin/env bash

# Env Variables
export APP_ENV=${APP_ENV:-local}
export APP_PORT=${APP_PORT:-80}
export DB_PORT=${DB_PORT:-3306}
export DB_ROOT_PASS=${DB_ROOT_PASS:-secret}
export DB_NAME=${DB_NAME:-docker}
export DB_USER=${DB_USER:-docker}
export DB_PASS=${DB_PASS:-secret}

# Decide which docker-compose file to use
COMPOSE_FILE="dev"

# Disable pseudo-TTY allocation for CI (Jenkins)
TTY=""

if [ ! -z "$BUILD_NUMBER" ]; then
    COMPOSE_FILE="ci"
    TTY="-T"
fi

COMPOSE="docker-compose -f $(dirname $0)/compose.$COMPOSE_FILE.yml"

COMMAND_RUN="run --rm $TTY"
COMMAND_EXEC="exec"

if [ $# -gt 0 ];then
    if [ "$1" == "art" ] || [ "$1" == "artisan" ]; then
        shift 1
        $COMPOSE $COMMAND_EXEC \
            app \
            php artisan "$@"

    # If "composer" is used, pass-thru to "composer"
    # inside a new container
    elif [ "$1" == "composer" ]; then
        shift 1
        $COMPOSE $COMMAND_EXEC \
            app \
            composer "$@"

    # If "test" is used, run unit tests,
    # pass-thru any extra arguments to php-unit
    elif [ "$1" == "t" ] || [ "$1" == "test" ]; then
        shift 1
        $COMPOSE $COMMAND_EXEC \
            app \
            ./vendor/bin/phpunit "$@"

    # If "npm" or "yarn" is used, run it
    # from our node container
    elif [ "$1" == "npm" ] || [ "$1" == "yarn" ]; then
        COMMAND=$1
        shift 1
        $COMPOSE $COMMAND_RUN \
            node \
            $COMMAND "$@"

    # If "gulp" is used, run gulp
    # from our node container
    elif [ "$1" == "gulp" ]; then
        shift 1
        $COMPOSE $COMMAND_RUN \
            node \
            ./node_modules/.bin/gulp "$@"
    else
        $COMPOSE "$@"
    fi
else
    $COMPOSE ps
fi
