#!/bin/bash

main() {

  if [ ! -z ${DEBUG+x} ]
    then
      # show us all environmant variables
      printenv
  fi

  echo 'EMRETL RUNNER'

  # config
  resolverconf
  commonconf
  # make the targets dir for any storage targets
  mkdir -p /emr/targets

  # Storage targets
  if [ "$ES_ENABLE" = "true" ]
    then
      es_conf
  fi

  if [ "$PG_ENABLE" = "true" ]
    then
      pg_conf
  fi

  if [ "$DYNAMODB_ENABLE" = "true" ]
    then
      dynamodb_conf
  fi

  if [ "$REDSHIFT_ENABLE" = "true" ]
    then
      redshift_conf
  fi

  # startup
  # EMR
  if [ "$EMR_ENABLE" = "true" ]
    then
      emrstartup
  fi
  # Storage
  if [ "$STORAGE_ENABLE" = "true" ]
    then
      run_storage
  fi
}

es_conf() {
  envsubst \
  < /assets/elasticsearch.json.template \
  > /emr/targets/elasticsearch.json
}

pg_conf() {
  envsubst \
  < /assets/postgres.json.template \
  > /emr/targets/postgres.json
}

dynamodb_conf() {
  envsubst \
  < /assets/dynamodb.json.template \
  > /emr/targets/dynamodb.json
}

redshift_conf() {
  envsubst \
  < /assets/redshift.json.template \
  > /emr/targets/redshift.json
}

resolverconf() {
  envsubst \
  < /assets/resolver.json.template \
  > /emr/resolver.json
}

commonconf() {
  envsubst \
  < /assets/config.yml.template \
  > /emr/config.yml
}

fastemrstartup() {
  # no config file, all redirect
  envsubst \
  < /assets/config.yml.template \
  | /emr/snowplow-emr-etl-runner \
  --debug \
  --config - \
  --resolver /emr/resolver.json \
  $EMR_ARGS
}

emrstartup() {
  /emr/snowplow-emr-etl-runner \
  --debug \
  -c /emr/config.yml \
  -r /emr/resolver.json \
  $EMR_ARGS
}

run_storage() {
  /emr/snowplow-storage-loader \
  -c /emr/config.yml \
  -r /emr/resolver.json \
  -t /emr/targets
  $STORAGE_ARGS
}

main "$@"
