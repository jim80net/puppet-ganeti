#$host_ip = network_eth1
#$drbd_ip = "172.26.31.1"
$git     = false
$ganeti_version = "2.5.2"

include ganeti
#include ganeti::networking
include ganeti::kvm
#include ganeti::instance_image
include ganeti::ganeti::install
include ganeti::ganeti::initialize
if $git {
    include ganeti::ganeti::git
    Vcsrepo { provider => "git", }
}

File { owner => "root", group => "root", }
