About netctl
============

`netctl` is a utility to manage network locations, interface
configuration files, and to start, stop, or restart interfaces on
OpenBSD.

`netctl` is not a replacement for `ifconfig(8)` or `netstart(8)`. It's
utility to make managing locations easier. `netstart` and `ifconfig`
still do the work. `netctl` makes the user's life, especially portable
users, easier.


Features
--------
+ Create, delete and switch between **locations** (including restarting
  **interfaces**)
+ Enable and disable **configurations**.
+ Start, stop and restart **interfaces**.
+ Detect and join known wireless networks (**waps**).
+ Scan for wireless access points.
+ List **locations**, **configurations**, **interfaces**, and **waps**.

See the man page for further details.


Install
-------

There's no installer for `netctl` at the moment. `doas make install`
will install to **/usr/local** unless you override the PREFIX
variable.

`make install` will also create **/etc/hostname.d/** and
**/etc/hostname.d/nwids/**


Locations
---------

`netctl` works by symlinking **hostname.if** files in location
directories to **/etc/hostname.if** so that the normal `netstart(8)`
code can do what it already does well.

`netctl` will create **location** directories for you by calling `doas
netctl create location_name`. `netctl` will **not** at this time
create the **hostname.if** files. They have to be created the same
ways as documented in `hostname.if(5)`. See the `man` page for more
details.


Auto Detecting and Joining Networks
-----------------------------------

Auto detecting and joining requires some setup. `netctl` will not
connect to wireless access points that are not known. To create a
*known* wap, a standard wireless **hostname.if** file should be
created in **/etc/hostname.d/nwids**. *E.g.,*

```
	$ cat /etc/hostname.d/nwids/Silly\ Wap.nwid
	nwid "Silly Wap"
	wpakey '$w@pau7h99'
	dhcp
```

The filename **must** be the same as the **nwid** in the file which
**must** match the **ESSID** of the wireless access point. Any valid
configuration directive `ifconfig(8)` will accept may be placed in the
file.

Executing `doas netctl -a start iwm0` will cause `netctl` to scan the
local network (with `ifconfig iwm0 scan`) and attempt to match the
results with the names of the **nwids** found by `ls`-ing
**/etc/hostname.d/nwids**.

**N.B.** `ifconfig scan` is called with *each* wlan device unless one
is specified after the **start** parameter.


Auto Detecting and Joining Networks When Resuming
-------------------------------------------------

`netctl` is not a daemon so it doesn't know when a computer has
resumed from sleep. `apmd(8)` does know and will call a script called
**resume** if it exists in **/etc/apm** and is executable.

A simple script like the following will work where the script is
called **suspend** and the other scripts are symlinked to it (see the
**man** page for `apmd(8)`):

```
#!/bin/sh

cmd="${0##*([[:blank:]])/etc/apm/}"
case "${cmd}" in
		powerup|resume)
				/usr/local/bin/netctl -a restart
				;;
		*)
		;;
esac
```


TODO
----

+ Add boot time detecting and joining wireless networks
+ Create hostname.if files in locations


Maybe TODO
----------
+ Set and get values in hostname.if files. *E.g.,*
```
	$ doas netctl get home nwid
	"Silly Wap"

	$ doas netctl set home nwid "My WAP Name"

	$ doas netctl set home dhcp on
```


Comments on Boot Time Configuration
--------

`netctl` is written in pure shell (using no commands outside of shell,
**/bin** and **/sbin**), so that it can run at boot time when **/usr**
may not be mounted yet.

I think I can get automated location switching working at boot time. I
already have code from an earlier project that will match wap scans to
the correct configuration. I'm rewriting it in pure shell and
integrating it for use during boot.


Copyright and License
---------------------

Copyright (c) 2017 Aaron Poffenberger <akp@hypernote.com>

Permission to use, copy, modify, and distribute this software for any
purpose with or without fee is hereby granted, provided that the above
copyright notice and this permission notice appear in all copies.

THE SOFTWARE IS PROVIDED "AS IS" AND THE AUTHOR DISCLAIMS ALL WARRANTIES
WITH REGARD TO THIS SOFTWARE INCLUDING ALL IMPLIED WARRANTIES OF
MERCHANTABILITY AND FITNESS. IN NO EVENT SHALL THE AUTHOR BE LIABLE FOR
ANY SPECIAL, DIRECT, INDIRECT, OR CONSEQUENTIAL DAMAGES OR ANY DAMAGES
WHATSOEVER RESULTING FROM LOSS OF USE, DATA OR PROFITS, WHETHER IN AN
ACTION OF CONTRACT, NEGLIGENCE OR OTHER TORTIOUS ACTION, ARISING OUT OF
OR IN CONNECTION WITH THE USE OR PERFORMANCE OF THIS SOFTWARE.

Updates and Suggestions
-----------------------

Let me know by `Issue` or email if you find bugs or have suggestions.
