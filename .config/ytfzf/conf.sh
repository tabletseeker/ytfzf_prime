#!/bin/sh

# This is a sample config file, refer to ytfzf(5) for more information

# In the previous version of ytfzf this file had all the examples, with all defaults set,
# this has been changed because it made it impossible for us to change default values that were broken or causing bugs,
# as everyone used the default configuration file.
# we are now going to only have this sample config file, and the ytfzf(5) manual, which has explanation of every variable and function that can be set.

#a sample config below:
ytdl_pref='bestvideo[height<=?1080]+bestaudio/best'
sub_link_count=8
show_thumbnails=1
pages_start=1
search_again=1
multi_search=1

on_opt_parse_c () {
    arg="$1"
    case "$arg" in
	#when scraping subscriptions enable -l
	#-cSI or -cS
	SI|S) is_loop=1 ;;
    esac
}
