#!/usr/bin/env bash

token=

while read repo; do
    echo curl -X PATCH --data \'{ \"archived\": true }\' \"https://api.github.com/repos/$repo?access_token=$token\"
    curl -X PATCH --data '{ "archived": true }' "https://api.github.com/repos/$repo?access_token=$token"
done < "archived.txt"