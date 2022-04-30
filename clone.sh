#/bin/bash

pack="./ListPack_c++"

while IFS= read -r pkg
do
  mkdir -p ./repo/$pkg
  cd ./repo/$pkg
  docker run --rm -d  \
    -v "$(pwd)":/home/retro \
    --name "$pkg" \
    project:debian "$pkg"
  cd ../..
done < "$pack"
