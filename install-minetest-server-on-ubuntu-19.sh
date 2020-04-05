#!/bin/bash

echo "deb http://deb.debian.org/debian bullseye main" >> deb http://deb.debian.org/debian bullseye main
apt-get update
apt-get -t bullseye install minetest-server
minetestserver --version
echo
echo
echo "Verify Minetest 5.1.1 (Linux) is installed. If not, something went wrong."

exit 0