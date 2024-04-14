If you want to help improve an ebuild in this overlay, I gladly accept pull
requests. So, go over to GitHub and fork this repository:

[https://github.com/fritteli/gentoo-overlay](https://github.com/fritteli/gentoo-overlay)

After you're done, please make sure that your changes don't upset
[`pkgcheck`](https://wiki.gentoo.org/wiki/Pkgcheck). Run the following
command and fix warnings and errors:
```commandline
pkgcheck scan --exit error,warning,style --net .
```

Then send me the pull request. If you want, you can also create an issue along
with it. But you don't have to.

Thank you for your help!
