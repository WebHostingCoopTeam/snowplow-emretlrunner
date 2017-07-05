#!/bin/bash
	grep -oP '\$(\S*)' assets/config.yml.template |sed 's/\$//'|sed 's/\(.*\)/\1=/' >example-env
