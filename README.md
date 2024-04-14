# fritteli's Gentoo overlay
Gentoo overlay with some ebuilds that I found either outdated or missing in the
official repository or in other overlays. Ebuilds are usually removed from this
overlay whenever I find a version available in the official tree or in another
overlay (provided I'm satisfied with them).

Build status of the
[main branch](https://gittr.ch/linux/gentoo-overlay/src/branch/main), as seen
by `pkgcheck scan --exit error --net .`:
[![Build Status](https://ci.gittr.ch/api/badges/linux/gentoo-overlay/status.svg?ref=refs/heads/main)](https://ci.gittr.ch/linux/gentoo-overlay)

## Using this overlay
Just execute these commands:
```commandline
eselect repository enable fritteli
emaint -r fritteli sync
```

In case this doesn't work, it might be because of a recent rename of the
`master` branch to `main`. In that case, execute the following commands.  
**NOTE**: You will be using the latest and most recent development version
of the overlay. But that does no harm.
```commandline
eselect repository add fritteli git https://gittr.ch/linux/gentoo-overlay.git
emaint -r fritteli sync
```
If you prefer to use the overlay hosted at GitHub (which tends to be more
stable but less up-to-date than the one hosted at gittr.ch), you may use
`https://github.com/fritteli/gentoo-overlay.git` as the URL.

## Bug reports and ebuild requests

If you find a bug in an ebuild, encounter a build error or would like me to add
a new ebuild, please open an issue on
[GitHub](https://github.com/fritteli/gentoo-overlay/issues).

## Contributing

I gladly accept pull requests for bugs or new ebuilds. Before opening a pull
request, please make sure your changes don't upset
[`pkgcheck`](https://wiki.gentoo.org/wiki/Pkgcheck). Run the following command
in the directory of the ebuild and fix warnings and errors:
```commandline
pkgcheck scan --net .
```

## Maintainers

* [Manuel Friedli](mailto:manuel@fritteli.ch)

## Acknowledgements

Thanks go to Jakub Jirutka, the maintainer of the (now defunct)
[CVUT Overlay](https://github.com/cvut/gentoo-overlay), from whom I shamelessly
copied this README.md for a start.
