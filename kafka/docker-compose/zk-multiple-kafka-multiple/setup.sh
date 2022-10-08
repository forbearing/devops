#!/usr/bin/env bash


DIR_LIST=(
zookeeper
kafka)


BASEDIR="$(dirname $0)"
if [[ ! -f "${DOCKER_FILE}"  ]]; then
    DOCKER_FILE="$(dirname $0)/docker-compose.yaml"
fi
if [[ ! -f "${DOCKER_FILE}"  ]]; then
    DOCKER_FILE="$(dirname $0)/docker-compose.yml"
fi

_start() {
    # create directory
    for dir in "${DIR_LIST[@]}"; do
        if [[ ! -d "$BASEDIR/$dir" ]]; then
            rm -rf "$BASEDIR/$dir"
            mkdir -p "$BASEDIR/$dir"
        fi
        chown -R 1001:0 "$BASEDIR/$dir"
    done
    docker-compose -f "$DOCKER_FILE" up -d
}

_cleanup() {
    _stop
    echo "You should manually delete the data:"
    for dir in "${DIR_LIST[@]}"; do
        echo "rm -rf $BASEDIR/$dir"
    done
}
_cleanupf(){
    _stop
    for dir in "${DIR_LIST[@]}"; do
        rm -rf $BASEDIR/$dir
    done
}
_stop() {       docker-compose -f "$DOCKER_FILE" down; }
_restart() {    docker-compose -f "$DOCKER_FILE" restart; }
_ps() {         docker-compose -f "$DOCKER_FILE" ps; }
_logs(){        docker-compose -f "$DOCKER_FILE" logs -f; }


case $1 in
start)
    _start ;;
stop)
    _stop ;;
restart)
    _restart ;;
cleanup)
    if [[ $2 == "-f" || $2 == "--force"  ]]; then
        _cleanupf
    else
        _cleanup 
    fi
    ;;
ps)
    _ps ;;
logs)
    _logs ;;
*)
    echo "Usage: $(basename $0) start|stop|cleanup|ps|logs"
esac
