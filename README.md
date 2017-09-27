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
+ Scan for wireless access points.
+ List **locations**, **configurations**, and **interfaces**.

See the man page for further details.

Directions
----------

The main feature that's missing is auto-wap detection and connecting
to existing known access points as users move or wireless-access
points appear and disappear (*.e.g.,* phones with tethering).

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
