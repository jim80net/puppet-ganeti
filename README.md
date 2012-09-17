# Puppet Ganeti Module

This module was modified from: [Puppet Configs for a Ganeti Tutorial](https://github.com/ramereth/puppet-ganeti-tutorial)

This module is customized for use on a network with prefixes 172.26. This is hard coded.
It will setup ganeti nodes with the basics to install
[Ganeti](http://code.google.com/p/ganeti/), [Ganeti Instance
Image](http://code.osuosl.org/projects/ganeti-image), and [Ganeti Web
Manager](http://code.osuosl.org/projects/ganeti-webmgr).

# Requirements

This assumes that you have two to three Ubuntu 11.10 VMs setup inside of
VirtualBox. Images can be downloaded from
[here](http://ftp.osuosl.org/pub/osl/ganeti-tutorial/).

# Switching Ganeti versions

This module supports changing of the versions via two variables in
`nodes/node#.pp`.

* `git` = boolean (default: false)
  * This pulls ganeti from its git repository if set to true.
* `ganeti_version` = string (default: 2.5.1)
  * Version of ganeti to use. Currently only supports 2.4.5, 2.5.1, and any of
    the tagged versioned releases.

# Copyright

This work is licensed under a [Creative Commons Attribution-Share Alike 3.0
United States License](http://creativecommons.org/licenses/by-sa/3.0/us/).

vi: set tw=80 ft=markdown :
