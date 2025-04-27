#!/bin/bash

REPO=("yt-dlp/yt-dlp" "junegunn/fzf")

for i in ${REPO[@]}; do

	GIT_URL="https://github.com/${i}/releases/latest"
	VERSION+=($(curl -Ls -o /dev/null -w %{url_effective} ${GIT_URL} | sed -e 's@.*/@@' | tr -d v))

done

sudo docker build -t tabletseeker/ytfzf_prime:latest --build-arg YTDL_VERSION=${VERSION[0]} --build-arg FZF_VERSION=${VERSION[1]} .


