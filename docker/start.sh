#!/bin/bash

echo
echo "Setting up server"
echo "--------"
echo

# Exit script if any command returns a non-zero status
set -e

export GIT_REPO=git_repo

if [[ ! -d "/app/${GIT_REPO}" ]]
then
	echo "Cloning research repo "

	if [[ -z "$(ls -A ${GIT_REPO})" ]]
    then
#		This will need to be the PAT for the knowledge repo github account
		git clone ${GIT_URL} ${GIT_REPO}
	fi
fi
echo Runtime context ${RUNTIME_CONTEXT}

echo
if [[ "${RUNTIME_CONTEXT}" == "local" ]]
then
    echo Starting local server
    echo ---
    knowledge_repo --repo /app/${GIT_REPO} --debug runserver --config ./server_config.py --port ${PORT}
else
    echo Starting remote server
    echo ---
    knowledge_repo --repo /app/${GIT_REPO} runserver --config ./server_config.py --port ${PORT}

fi
