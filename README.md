## ytfzf_prime
A working update of the popular terminal tool ytfzf for searching and watching Youtube videos with a thumbnail display and without ads or privacy concerns.
This project utilizes an alpine:edge Docker Container that includes an updated (fully working) version of ytfzf featuring all expected
custmization options, X11 forwarding to display mpv on the host and a full invidious implementation to ensure optimal speed, realiability and privacy.

#### Subscriptions:
![o,age](https://i.postimg.cc/tTS9cWKn/2.png)
#### Search:
![o,age](https://i.postimg.cc/YS6JVZWh/3.png)

## Dependencies
* `docker`
* `jq`
* `curl`

## Pulling Docker Image
* Pull the latest tag:
```
docker pull tabletseeker/ytfzf_prime:latest
```

## Building Docker Image 
* Recommended, if you want an image with customized subscriptions.
* Clone repo:
```
git clone https://github.com/tabletseeker/ytfzf_prime -b master
```
* Enter ytfzf_prime directory:
```
cd ytfzf_prime
```
* Add/Remove channels to/from the subscriptions file:
```
nano .config/ytfzf/subscriptions 
```
* Run Docker build script:
```
./build.sh
```
* Run ytfzf_prime:
```
./launch.sh
```

## Usage
* Ensure sufficient terminal width:
```
185x40
```
* View Subcriptions:
```
./launch.sh
```
* General Youtube Search:
```
./launch.sh <Search Term>
```
* Multi-Search:
```
./launch.sh <Search Term>,<Search Term>
```
* Search with Spaces:
```
./launch.sh "<S e a r c h T e r m>"
```
* Reload Search or Subscriptions:
```
Ctrl + c
```
## Environment Variables

|  Variable                                             | Values                                                                                          
| ---------------------------------------------------- | ------------------------------------------------------------------------------------------------|
| DISPLAY           | Current $DISPLAY   		                        |
| WINDOW_ID         | Current terminal $WINDOWID |
| XDG_RUNTIME_DIR         | Current terminal $XDG_RUNTIME_DIR                              |
| YTFZF_SYSTEM_ADDON_DIR         | Ytfzf Addon Directory                  |
| invidious_instance 	    | Custom Invidious Instance                                           			 |

## Volumes
*	`-v /etc/machine-id:/etc/machine-id:ro`
*	`-v /run/user/1000/pulse:/run/user/1000/pulse`
* `-v /path/to/your/media/:/home/mpv/media:ro`

### Mounting subscriptions file to be edited on host:
* Create mount directory | example: `$HOME/ytfzf_mount`
* Copy `ytfzf_prime/.config/ytfzf/conf.sh` and `ytfzf_prime/.config/ytfzf/subscriptions` to `$HOME/ytfzf_mount`
```
cp ytfzf_prime/.config/ytfzf/* $HOME/ytfzf_mount
```
* Add ` -v $HOME/ytfzf_mount:$HOME/.config/ytfzf:rw ` to docker run command in launch.sh
```
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
 -v /path/to/your/media/:/home/mpv/media:ro \
 -v $HOME/ytfzf_mount:$HOME/.config/ytfzf:rw \
 ${IMG} ytfzf ${ARG}
```
## Config Files
### conf.sh
* Location: `ytfzf_prime/.config/ytfzf/conf.sh`
* Owner: `1000:1000`
* Documentation: https://github.com/pystardust/ytfzf/wiki/ytfzf(1)

### subscriptions
* Location: `ytfzf_prime/.config/ytfzf/subscriptions`
* Owner: `1000:1000`
* Documentation: https://github.com/pystardust/ytfzf/wiki/ytfzf(5)

## Donations :heartpulse:
- Bitcoin Address: bc1qjz2dqu4u5uhxcv43jqmlefgffe3hnfavcs8w90
