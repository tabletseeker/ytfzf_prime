FROM alpine:3.21 AS baseimage

RUN apk add --no-cache \
	git \
	cmake \
	make \
	build-base \
	openssl-dev \
 	vips-dev \
  	libsixel-dev \
   	chafa-dev \
    	libtbb-dev \
     	libx11-dev \
      	libxcb-dev \
       	wayland-dev \
	extra-cmake-modules \
 	wayland-protocols \
  	opencv-dev

ARG YTDL_VERSION
ARG FZF_VERSION

WORKDIR /opt

RUN git clone https://github.com/jstkdng/ueberzugpp.git -b master \
	&& cd ueberzugpp && mkdir build && cd build && cmake -DCMAKE_BUILD_TYPE=Release -DENABLE_X11=ON -DENABLE_WAYLAND=ON .. \
	&& cmake --build . && make install \
	&& wget -qO- https://github.com/junegunn/fzf/releases/download/v${FZF_VERSION}/fzf-${FZF_VERSION}-linux_amd64.tar.gz | tar -xvz -C /usr/local/bin \
	&& wget https://github.com/yt-dlp/yt-dlp/releases/download/${YTDL_VERSION}/yt-dlp -O /usr/local/bin/yt-dlp \
	&& wget https://raw.githubusercontent.com/tabletseeker/ytfzf/refs/heads/master/ytfzf -O /usr/local/bin/ytfzf

FROM alpine:edge

LABEL maintainer="tabletseeker"
LABEL org.label-schema.description="Containerization of upgraded ytfzf"
LABEL org.label-schema.name="ytfzf_prime"
LABEL org.label-schema.schema-version="1.0"
LABEL org.label-schema.vcs-url="https://github.com/tabletseeker/ytfzf_prime"

COPY --from=baseimage /usr/local/bin/ /usr/local/bin/
COPY --chown=1000:1000 .config/ /home/mpv/.config/
COPY --chown=1000:1000 ytfzf/addons/ /usr/share/ytfzf/addons/

RUN apk add --no-cache \
	mesa-dri-gallium \
	mpv \
	ttf-dejavu \
	pulseaudio \
	python3 \
	jq \
	curl \
	util-linux \
	chafa \
	&& apk add --no-cache --repository=https://dl-cdn.alpinelinux.org/v3.21/main \
	libtbb \
	libxcb \
	vips-cpp \
	vips \
	fmt=10.2.1-r2 \
	xcb-util-image \
	&& apk add --no-cache --repository=https://dl-cdn.alpinelinux.org/v3.21/community \
	libopencv_videoio=4.10.0-r3 \
	&& chmod 0755 /usr/local/bin/* \
	&& adduser -u 1000 -D mpv \
	&& mkdir -p /run/user/1000 \
	&& chown -R 1000:1000 /run

USER mpv

WORKDIR /home/mpv/

CMD ["/bin/ash"]
