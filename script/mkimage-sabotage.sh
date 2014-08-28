#!/usr/bin/env bash
today=$1

pacman -Syy && pacman -S --noconfirm base-devel git wget sed bzip2 tar

cd /tmp

git clone https://github.com/sabotage-linux/sabotage.git sabotage-build
cd sabotage-build

cp KEEP/config.stage0 config

sed -i 's/^export A=i386/#export A=i386/' config
sed -i 's/^#export A=x86_64/export A=x86_64/' config

./build-stage 0

tar --xz -f /output/sabotage-stage0-$today.tar.xz --numeric-owner -C /tmp/sabotage -c .
