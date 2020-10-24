# Wine Builder - Ubuntu

This is aimed at developers who want to build a bi-arch wine in the most compatible and platform independent way, with the best build speed possible.

The 19.10 branch builds on Ubuntu 19.10, which although now unsupported is the oldest (i.e. most compatible) Ubuntu version that can build wine 5.18 to 5.19.

Docker or a docker compatible container system is required to make use of this.

If you wish to build this Dockerfile locally, `http_proxy` can be passed as a `--build-arg` to greatly speed up the process/subsequent builds if you have a cache.

# Usage

- `$DIR` - this checked-out folder or a folder with a `build` subfolder, either:
  - set `$DIR` (e.g. `cd wine-builder-ubuntu; DIR=$(pwd)` or `mkdir wine-builder; cd wine-builder; DIR=$(pwd)`)
  - or replace `$DIR` in commands below with the path to said folder.
- `$VERSION` - a user (i.e. you) determined version string, typically the wine version like "5.16" but can be almost anything - **strong advice**: no spaces, special characters etc.
- `$CORES` - the number of CPU cores you wish to use during build, your total threads + 1 will usually be fastest but could slow your system. If the parameter is skipped, the default is 6.

1) Within your `build` subfolder of your current working directory, have a `wine-git` folder prepared within it (clone'd, patched etc) e.g. `$DIR/build/wine-git`
   - e.g. for a quick checkout of wine 5.16: `mkdir build; git clone --depth 1 --branch wine-5.16 https://github.com/wine-mirror/wine.git build/wine-git`

2) Run `docker run --rm --env build_cores=$CORES -v $DIR/build/:/build/ molotovsh/wine-builder-ubuntu build.sh $VERSION`
   - `$DIR` must be populated or replaced with a full path or docker will (current versions) reject the volume mount

3) Once done you should find `$DIR/build/wine-runner-$VERSION.tgz` with your build packaged in it.

4) Occasionally run `docker pull molotovsh/wine-builder-ubuntu` to get the most recent version.

This can take up to 8GB of disk in total, so beware of space usage. Once done in the rest of `$DIR/build` is expendable (or partially re-usable for quicker future builds).

This build uses `ccache` for faster re-builds (as `$DIR/build/ccache` once a build has been run). This can consume a lot of disk space over a few builds, and may need to be deleted occasionally.

If you don't want to use the provided `build.sh` feel free to create your own dockerfile using this as a `FROM`.

## Debug

To get into the wine-builder container without having to run the build script:

- `docker run --rm --env build_cores=$CORES -v $DIR/build/:/build/ -it molotovsh/wine-builder-ubuntu`

(You can skip the build_cores and volume bind, but just remember to set them before you try a build).

# Notes

### I think I found a bug

Please open an issue on Github throughly describing your setup, distro, docker version, console output, where you got your wine sources from etc.

### I'd like a new feature or package included

Please open an issue on Github describing your request.

### I built a wine runner and game X doesn't work!

So ultimately you may need to apply patches or pick a known compatible wine version. If you can get some known working sources, you could put them in `$DIR/build/wine-git/` and use them in a build of your own!

### Do you accept PRs?

Of course, but before you spend lots of time working on something I'd suggest you create an issue on Github to describe what you're thinking.

I'm open to PRs that make the system more flexible or helper scripts that would setup git folders with particular wine sources.

