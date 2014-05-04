fritteli's Gentoo overlay
=========================

Gentoo overlay with some ebuilds that I found either outdated or missing in the official repository or in other overlays. Ebuilds are usually removed from this overlay whenever I find a version available in the official tree or in another overlay (provided I'm content with them).


Using with Layman
-----------------

Use layman to easily install and update overlays over time.

If you haven't used layman yet, just run these commands:

	USE=git emerge -va layman
	echo PORTDIR_OVERLAY=\"\" > /var/lib/layman/make.conf
	echo "source /var/lib/layman/make.conf" >> /etc/make.conf


Then you can add this overlay wih:

	layman -o https://git.friedli.info/manuel/gentoo-overlay/raw/master/layman.xml -f -a fritteli

Keep the overlay up to date from Git:

	layman -s fritteli


Maintainers
-----------

* [Manuel Friedli](mailto:manuel@fritteli.ch)

Acknowledgements
----------------

Thanks go to Jakub Jirutka, the maintainer of the [CVUT Overlay](https://github.com/cvut/gentoo-overlay), from whom I shamelessly copied this README.md for a start.

