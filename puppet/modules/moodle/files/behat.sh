#!/usr/bin/env bash
BEHATDATAROOT=/var/www/moodle/behatdata
BEHATPATH=/var/www/behat/`date +%Y%m%d_%H%M%S`/
mkdir $BEHATPATH

vendor/bin/behat --format=moodle_progress,progress,html,failed \
        --out=,$BEHATPATH/progress.txt,$BEHATPATH/status.html,$BEHATPATH/failed.txt \
        --config=$BEHATDATAROOT/behat/behat.yml "$@"
