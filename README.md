_Currently completely untested._

This is aimed at developers who want to build a bi-arch wine in the most compatible and platform independent way, with the best build speed possible.

If you wish to build this Dockerfile locally, `http_proxy` can be passed as an input parameter to greatly speed up the process/subsequent builds if you have a cache.

_Where `$DIR` is this checked-out folder._

This build uses `ccache` for faster re-builds (as `$DIR/build/ccache` once a build has been run). This can consume a lot of disk space over a few builds.

Ensure you have a `wine-git` folder prepared (clone'd, patched etc) in `$DIR/build`, e.g. `$DIR/build/wine-git` and then use `docker run --rm -v $DIR/build/:/build/ molotovsh/wine-builder-ubuntu build.sh $VERSION`

This can take up to 8GB of disk in total, so beware of space usage. Once done in `$DIR/build/` you will find a folder called `wine-runner-$VERSION` with your build in it, you can take this folder out and use it as you please, and the rest of `$DIR/build` is expendable (or partially re-usable for quicker future builds).

If you don't want to use the provided `build.sh` feel free to create your own dockerfile using this as a `FROM`.