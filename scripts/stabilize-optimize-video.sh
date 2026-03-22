#!/bin/sh
# Stabilize and optimize the size of a video

vid="$1"

mkdir -p transformed

ffmpeg -y -i "$vid" -vf vidstabdetect -f null -
ffmpeg -y -i "$vid" -vcodec libx265 -crf 28 -vf vidstabtransform "transformed/$vid"
