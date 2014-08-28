#!/usr/bin/env bash

today=$(date +"%Y%m%d")

git filter-branch -f --tree-filter 'rm -rf output/sabotage-stage0*' --prune-empty sabotage-stage0

docker run -v $(pwd)/output:/output -v $(pwd)/script:/opt/mkimage jprjr/arch /opt/mkimage/mkimage-sabotage.sh $today

cp dockersrc/Dockerfile output/Dockerfile
sed -i "s/##DATE##/$today/" output/Dockerfile

git add output/Dockerfile && git commit -m "Updating dockerfile $today"
git add output/sabotage-stage0-$today.tar.xz && git commit -m "Updating rootfs $today"
