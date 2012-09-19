# Puppet Ganeti Module

This module was modified from: [Puppet Configs for a Ganeti Tutorial](https://github.com/ramereth/puppet-ganeti-tutorial)

It will setup ganeti nodes with the basics to install
[Ganeti](http://code.google.com/p/ganeti/). 

[Ganeti Instance Image](http://code.osuosl.org/projects/ganeti-image), and [Ganeti Web
Manager](http://code.osuosl.org/projects/ganeti-webmgr) are still in development.

# Requirements

This module will not configure networking. Please ensure that your node is configured networking-wise. 
This module will not configure storage, though as you will note in tests/nodes/testpup-6-0.pp, that one might be able to 
  realize this with other modules. That example uses puppetlabs-lvm, available at github.
This module will not initialize the cluster. Given the low frequency of such an action, this feature will eventually be removed from the code. 


# Switching Ganeti versions

This was supported in the parent of this fork. In this instance, I will be removing this ability, in favor of simpler code. 

# Testing

This module is presently being developed on :
  CentOS 6.3 
  drbd 8.3
  ganeti 2.5.1 of the osuosl.org variety. 
  puppet version 2.6.6

# Copyright

This work is licensed under a [Creative Commons Attribution-Share Alike 3.0
United States License](http://creativecommons.org/licenses/by-sa/3.0/us/).

vi: set tw=80 ft=markdown :
