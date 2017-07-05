#!/bin/sh

main() {
  printenv
  # and startup
  startup
}

startup() {
  envsubst \
  < /assets/config.yml.template \
  | /emr/snowplow-emr-etl-runner --config - $EMR_ARGS
}

main "$@"
