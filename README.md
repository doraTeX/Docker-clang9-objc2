# Dockerfile to build an Objective-C 2.0 development environment

This repository contains Dockerfiles to build Docker images that consist of:

* Ubuntu 19.10 / 18.04
* Clang 9
* GNUstep
* libobjc2

By using this Docker container, you can compile Objective-C 2.0 sources with Clang 9. Since `libobjc2` is set up, you can use the modern Objective-C features in your Objective-C sources, such as:

* Automatic Reference Counting (ARC)
* Blocks
* Dot Notation
* Object Literal
* Object Subscripting
* Fast Enumeration
* Lightweight Generics
* Grand Central Dispatch (GCD)

# Usage

## Pull or build Docker image

```sh
$ docker pull doratex/clang9-objc2:latest
```

or you can build the Docker image by yourself.

```sh
$ cd Dockerfile/ubuntu1910
$ docker build --no-cache=true -t clang9-objc2:ubuntu1910 .
```


## Run Docker container and compile your Objective-C sources

```sh
$ docker run --rm -it -v $(pwd):/workdir doratex/clang9-objc2:latest /bin/bash
# clang-objc -o foobar foobar.m
# ./foobar
```

The `clang-objc` command is just an alias that is set in `~/.bashrc` as follows.

```sh
alias clang-objc="\${CC} \$(gnustep-config --objc-flags) \$(gnustep-config --objc-libs) -fobjc-arc -lobjc -ldispatch -lgnustep-base"
```

# Test various Objective-C 2.0 features

`test` directory is included in this repository. You can test various Objective-C 2.0 features using `test_all.sh`.

```sh
$ docker run --rm -it -v $(pwd):/workdir doratex/clang9-objc2:latest /bin/bash
# cd test
# ./test_all.sh
```

Note that the last `GUI` test does not pass without X Window System.

# Acknowledgments

I owe most of these building procedures and test files to [@plaurent](https://github.com/plaurent)'s [GitHub repository](https://github.com/plaurent/gnustep-build).
