fritteli's Gentoo overlay
=========================

Gentoo overlay with some ebuilds that I found either outdated or missing in the official repository or in other overlays. Ebuilds are usually removed from this overlay whenever I find a version available in the official tree or in another overlay (provided I'm satisfied with them).

Build status of the [master branch](https://gittr.ch/manuel/gentoo-overlay/tree/master), as seen by `repoman -p -x`: [![build status](https://gittr.ch/ci/projects/9/status.png?ref=master)](https://gittr.ch/ci/projects/9?ref=master)

Using with Layman
-----------------

Use layman to easily install and update overlays over time.

If you haven't used layman yet, just run these commands:

	USE=git emerge -va layman
	echo PORTDIR_OVERLAY=\"\" > /var/lib/layman/make.conf
	echo "source /var/lib/layman/make.conf" >> /etc/make.conf


Then you can add this overlay wih:

	layman -o https://gittr.ch/manuel/gentoo-overlay/raw/master/layman.xml -f -a fritteli

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