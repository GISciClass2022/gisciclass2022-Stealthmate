#!/bin/sh

ffmpeg -framerate 5 -pattern_type glob -i 'frames/*.png' -r 25 -c:v libx264 -vf "pad=ceil(iw/2)*2:ceil(ih/2)*2" -pix_fmt yuv420p out.mp4
