#!/usr/bin/env bash

token=

curl "https://api.github.com/user/repos?access_token=$token&per_page=100" > all.json
cat all.json | jq '.[] | .ssh_url' > all.txt
cat all.json | jq '.[] | select(.archived == true) | .full_name' > archived.txt