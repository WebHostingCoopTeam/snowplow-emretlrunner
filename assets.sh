#!/bin/bash
curl https://raw.githubusercontent.com/snowplow/snowplow/master/3-enrich/emr-etl-runner/config/config.yml.sample \
  |sed  's/^\(\s*\)\(.*\):\s*ADD HERE/\1\2:\ $AWS_\2_AWS/' \
  |sed  's/\ EMR_\(.*\)\ / $EMR_\1_EMR /g' \
  > assets/config.yml.template
echo 'there are a few more stragglers, check logging level, and the in points (will still be "- ADD HERE")'
