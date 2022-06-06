#/bin/bash

#if file is passed in argument, use it
if [ $# -eq 1 ]; then
  pack=$1
else
  pack="../packages/ListPack_c++"
fi



while IFS= read -r pkg
do
  mkdir -p ./exceptions/$pkg
  #check if package have a good name  [a-zA-Z0-9][a-zA-Z0-9_.-]*
  if [[ $pkg =~ ^[a-zA-Z0-9][a-zA-Z0-9_.-]*$ ]]
  then
    name="exception_$pkg"
    else
    #get rid of incorrect characters
    name=$(echo retro_$pkg | sed -e 's/[^a-zA-Z0-9_.-]//g')
  fi
  echo "$name"
  cd ./exceptions/$pkg
  docker run --rm -d  \
    -v "$(pwd)":/home/retro \
    --name "$name" \
    --entrypoint=/etc/entry_exception.sh \
    project:debian \
    "$pkg"
  #❯ docker run -it -v "$(pwd)":/home/retro --entrypoint=/etc/entry_exception.sh project:debian 0xffff                                        ─╯

  cd ../..
done < "$pack"


#docker wait $(docker ps -a -f "name=exception" -q)
