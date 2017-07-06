#!/bin/sh

main() {
  printenv
  # and startup
  startup
}

startup() {
  # no files all redirects and aweseme sauce
  envsubst \
  < /assets/config.yml.template \
  | /emr/snowplow-emr-etl-runner --config - \
  --debug \
  --config - \
  --resolver /assets/resolver.json \
  $EMR_ARGS
}

altstartup() {
  # useful for debugging
  envsubst \
  < /assets/config.yml.template \
  > /emr/config.yml

  cp /emr/config.yml /tmp/

  /emr/snowplow-emr-etl-runner \
  --debug \
  --config /emr/config.yml \
  --resolver /assets/resolver.json \
  $EMR_ARGS
}

main "$@"
