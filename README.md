fritteli's Gentoo overlay
=========================

Gentoo overlay with some ebuilds that I found either outdated or missing in the official repository or in other overlays. Ebuilds are usually removed from this overlay whenever I find a version available in the official tree or in another overlay (provided I'm satisfied with them).

Build status of the [master branch](https://gittr.ch/linux/gentoo-overlay/tree/master), as seen by `repoman -p -x`: [![build status](https://gittr.ch/ci/projects/10/status.png?ref=master)](https://gittr.ch/ci/projects/10?ref=master)

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

You may also use `layman` to manage this overlay, although that requires some more setup and manual sync'ing.

If you haven't used layman yet, just installing running these commands:

	USE=git emerge -va layman
	echo PORTDIR_OVERLAY=\"\" > /var/lib/layman/make.conf
	echo "source /var/lib/layman/make.conf" >> /etc/make.conf


Then you can add this overlay wih:

	layman -o https://gittr.ch/linux/gentoo-overlay/raw/master/layman.xml -f -a fritteli

Alternatively, you may use the overlay hosted on GitHub. That may not be quite as up-to-date as the one on gittr.ch. To use the GitHub version, use this command:

	layman -o https://raw.githubusercontent.com/fritteli/gentoo-overlay/master/layman.xml -f -a fritteli

Keep the overlay up to date from Git:

	layman -s fritteli


Maintainers
-----------

* [Manuel Friedli](mailto:manuel@fritteli.ch)

Acknowledgements
----------------

Thanks go to Jakub Jirutka, the maintainer of the [CVUT Overlay](https://github.com/cvut/gentoo-overlay), from whom I shamelessly copied this README.md for a start.