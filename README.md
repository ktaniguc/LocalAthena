# LocalAthena

## Usage
```cp
$ git clone ~~~
$ cd source
$ source setup.sh
$ ./checkout.sh your_branch_name
$ ./compile.sh cmake
>> compile athena wich cmake
```

## Memo

### discription of each script

#### setup.sh
If you want to use different asetup version, you must edit setup.sh.
Like...
```sh
asetup r2018-03-09T2222,Athena,21.0
asetup r2018-03-29T2156,Athena,21.3
asetup 21.0,Athena,r31
asetup AtlasOffline,21.0.20,slc6,gcc62,64
```
When you login again, you must do `source setup.sh`.

#### checkout.sh
```sh
$ ./checkout.sh your_branch_name
$ git branch
master
* your_branch_name
```

#### compile.sh
Once you edit code, you must compile.
Like...
```sh
$ ./compile.sh cmake
```
Then build directory is made.
And once you comile, you must do
```sh
source $TestArea/../build/$CMTCONFIG/setup.sh
```


### How to edit code
```sh
git fetch upstream
git checkout -b my_branch_name upstream/[project-branch] --no-track
```
[project-branch] is master, 21.0, 21.3 etc..

