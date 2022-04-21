# debian_docker
**goal**: test the [retrowrite](https://github.com/HexHive/RetroWrite) program on debian packages. 

How to proceed:
```
$ docker build -t project:debian .
$ ./clone.sh
```

When the docker images have finished running, execute the following command:
```
$ ./result_count 
```
This will create a "result" folder which will contain two files:
no_diff_list.log and diff_list.log. The first one contains the list of all the packages whose modified version works and the second one the one that differs with the original executable.
 

issue:
some commands in certain packages display different outputs when executed several times, due to randomness (game) or because the date is displayed
