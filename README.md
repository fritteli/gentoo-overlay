fritteli's Gentoo overlay
=========================

Gentoo overlay with some ebuilds that I found either outdated or missing in the official repository or in other overlays. Ebuilds are usually removed from this overlay whenever I find a version available in the official tree or in another overlay (provided I'm satisfied with them).

Build status of the [master branch](https://gittr.ch/linux/gentoo-overlay/src/branch/master), as seen by `repoman -p -x`: [![Build Status](https://ci.gittr.ch/api/badges/linux/gentoo-overlay/status.svg?ref=/refs/heads/master)](https://ci.gittr.ch/linux/gentoo-overlay)

Using with plain (recent) Portage
---------------------------------

Create a new config file under `/etc/portage/repos.conf/fritteli.conf` with the following contents:

	[fritteli]
	auto-sync = yes
	location = /usr/local/portage/overlays/fritteli
	sync-type = git
	sync-uri = https://gittr.ch/linux/gentoo-overlay.git


You may adapt the `location` attribute to your system's own setup.

If you prefer to use the overlay hostet at GitHub (which tends to be more stable but less up-to-date than the one hosted at gittr.ch), you may use `https://github.com/fritteli/gentoo-overlay.git` for the `sync-uri`.

Using with Layman
-----------------

You may also use [`layman`](https://wiki.gentoo.org/wiki/Layman) to manage this overlay. If you choose this method, you will be using the overlay hosted at GitHub.

If you haven't used layman yet, just install it running these commands:

	USE=git emerge -va layman
	echo PORTDIR_OVERLAY=\"\" > /var/lib/layman/make.conf
	echo "source /var/lib/layman/make.conf" >> /etc/make.conf


Then you can add this overlay wih:

	layman -a fritteli

You will be prompted for confirmation because this is an experimental overlay. Just continue by hitting `y`.

Keep the overlay up to date from Git:

	layman -s fritteli


Bug reports and ebuild requests
--------------------------------

If you find a bug in an ebuild, encounter a build error or would like me to add a new ebuild, please open an issue on [GitHub](https://github.com/fritteli/gentoo-overlay/issues) or on [gittr.ch](https://gittr.ch/linux/gentoo-overlay/issues).

Contributing
------------

I gladly accept pull requests for bugs or new ebuilds. Before opening a pull request, please make sure your changes don't upset [`repoman`](https://wiki.gentoo.org/wiki/Repoman). Run the following command and fix warnings and errors:

	repoman -x -p

Maintainers
-----------

* [Manuel Friedli](mailto:manuel@fritteli.ch)

Acknowledgements
----------------

Thanks go to Jakub Jirutka, the maintainer of the [CVUT Overlay](https://github.com/cvut/gentoo-overlay), from whom I shamelessly copied this README.md for a start.

