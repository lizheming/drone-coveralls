#!/usr/bin/env bash
set -e

start_time=$(date +%s.%N)
files="${FILES:-$PLUGIN_FILES}"

echo "-- Pushing coverage to Coveralls.io..."

# check coveralls token exist.
if [[ -n $PLUGIN_TOKEN ]]; then
  COVERALLS_REPO_TOKEN=$PLUGIN_TOKEN
fi
if [[ -z $COVERALLS_REPO_TOKEN ]]; then
    echo "-- Error: missing coveralls token"
    exit 1
fi

vfiles=""
for file in $(echo $files | tr -d '[[:space:]]' | tr "," "\n"); do
    if [[ -f $PWD/$file ]]; then
      vfiles="$vfiles -f $PWD/$file"
      
      echo "-- Sending $file to Coveralls.io --"
      eval 'cat $PWD/$file | coveralls'
    fi
done

token="-t $COVERALLS_REPO_TOKEN"
branch=""
commit=""
pr=""
buildnum=""
tag=""
if [[ -n $DRONE_BRANCH ]]; then
    branch="-B $DRONE_BRANCH"
fi
if [[ -n $DRONE_COMMIT ]]; then
    commit="-C $DRONE_COMMIT"
fi
if [[ -n $DRONE_PULL_REQUEST ]]; then
    pr="-P $DRONE_PULL_REQUEST"
fi
if [[ -n $DRONE_BUILD_NUMBER ]]; then
    buildnum="-b $DRONE_BUILD_NUMBER"
fi
if [[ -n $DRONE_TAG ]]; then
    tag="-T $DRONE_TAG"
fi

if [[ $PLUGIN_DEBUG = "true" ]]; then
    echo "-- DEBUG: running following command..."
    echo "-- DEBUG: coveralls $token $vfiles $branch $commit $pr $buildnum $tag"
fi

end_time=$(date +%s.%N)
echo "duration: $(echo "$end_time $start_titme" | awk '{printf "%f", $1 - $2}')s"

if [[ $exitcode -eq 0 ]]; then
    echo "-- Coverage successfully pushed to Coveralls!"
else
    echo "-- Coverage failed to push to Coveralls!"
fi
