#!/bin/bash

IMG="tabletseeker/ytfzf_prime"

[[ -z ${1} ]] && \
{ INV_INSTANCE="https://inv.nadeko.net"; \
ARG="
-cS \
--fancy-subs \
--pages=1 \
--thumb-viewer=ueberzug \
--thumbnail-quality=maxres \
--preview-side=right \
--sort-by=upload_date"; } || \

{ INV_INSTANCE="https://invidious.flokinet.to"; \
ARG="
--pages=2 \
--thumb-viewer=ueberzug \
--thumbnail-quality=maxres \
--preview-side=right \
--upload-date=hour,today,week \
--sort-by=upload_date,view_count \
--scrape=youtube ${@}"; }


sudo docker run --rm -i -t \
	--device /dev/dri \
	--network host \
	-e DISPLAY=$DISPLAY \
	-e WINDOWID=$WINDOWID \
	-e XDG_RUNTIME_DIR=$XDG_RUNTIME_DIR \
	-e YTFZF_SYSTEM_ADDON_DIR=/usr/share/ytfzf/addons \
	-e invidious_instance="${INV_INSTANCE}" \
	-v /etc/machine-id:/etc/machine-id:ro \
	-v /run/user/1000/pulse:/run/user/1000/pulse \
	-v $HOME/.Xauthority:/home/mpv/.Xauthority \
	${IMG} ytfzf ${ARG}
