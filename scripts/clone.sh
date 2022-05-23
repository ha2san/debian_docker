#/bin/bash

#if file is passed in argument, use it
if [ $# -eq 1 ]; then
  pack=$1
else
  pack="../packages/ListPack_c++"
fi



while IFS= read -r pkg
do
  mkdir -p ./repo/$pkg
  #check if package have a good name  [a-zA-Z0-9][a-zA-Z0-9_.-]*
  if [[ $pkg =~ ^[a-zA-Z0-9][a-zA-Z0-9_.-]*$ ]]
  then
    name="retro_$pkg"
    else
    #get rid of incorrect characters
    name=$(echo retro_$pkg | sed -e 's/[^a-zA-Z0-9_.-]//g')
  fi
  echo "$name"
  cd ./repo/$pkg
  docker run --rm -d  \
    --cpus=4.0 --cpuset-cpus=0,1,2,3 -e cpuload=100 \
    -m 12gb --memory-swap -1 \
    -v "$(pwd)":/home/retro \
    --name "$name" \
    project:debian "$pkg"
  cd ../..
done < "$pack"


docker wait $(docker ps -a -f "name=retro" -q)
./result_count.sh
