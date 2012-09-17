#!/bin/bash
export LANG="en_US.UTF-8"
update-alternatives --set editor /usr/bin/vim.basic
update-alternatives --set pager /usr/bin/less
mkdir -p /etc/puppet/modules
git clone git://github.com/ramereth/puppet-ganeti-tutorial.git /etc/puppet/modules/ganeti
ln -s /etc/puppet/modules/ganeti /root/puppet
