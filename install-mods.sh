#!/bin/bash

echo "Checking for dependencies..."
echo
deps=(wget unzip)
for dep in ${deps[*]}
do
  which $dep
  if [[ $? -eq 1 ]] ; then echo "This script requires $dep" && exit 1; fi
done

echo
echo "Looks good. Let's go!"
echo

read -n1 -p 'Install mods? (y|Y): ' installmods
echo
echo

mkdir -p ./mods ./zips

if [[ $installmods != "y" && $installmods != "Y" ]] ; then
  echo "OK bye"
  exit 0
fi

tenplus1=(stairs wine farming mob_horse mobs_redo teleport_potion tnt bakedclay
  ethereal protector bonemeal mobs_npc mobs_monster mobs_animal falling_item
  inventory_plus itemframes bows builtin_item ambience lucky_block simple_skins
  toolranks money lapis doors bucket bees creeper mobs_water mobs_sky
  homedecor_modpack moreores boats carts hopper vines season hud_hunger )

for repo in ${tenplus1[*]}
do
  printf "Downloading %s\n" $repo
  wget -O zips/$repo.zip https://notabug.org/TenPlus1/$repo/archive/master.zip
  printf "Unzipping ./zips/%s\n" $repo
  unzip -d ./mods ./zips/$repo.zip
done

echo
echo "Doing certain things to certain mods"
echo

mods=(homedecor_modpack mobs_sky mobs_water hud_hunger)

for mod in ${mods[*]}
do
  printf "Addressing mod %s\n" $mod
  for dir in $(ls -d ./mods/$mod/*/)
  do
    cp -rp $dir ./mods
  done
  rm -rf ./mods/$mod
done

echo
echo "Creating world.mt mod config"
echo

touch world.mt.mods

for mod in $(find ./mods -maxdepth 1 -type d -printf "%f\n")
do
  echo "load_mod_$mod = true" >> world.mt.mods
done

echo "world.mt.mods file: "
echo

cat world.mt.mods

echo
echo "DONE!"
echo

exit 0