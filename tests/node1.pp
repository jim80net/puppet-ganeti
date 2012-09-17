$host_ip = "33.33.33.11"
$drbd_ip = "33.33.34.11"
$git     = false
$ganeti_version = "2.5.2"

include ganeti
include ganeti::networking
include ganeti::kvm
include ganeti::instance_image
include ganeti::ganeti::install
include ganeti::ganeti::initialize
if $git {
    include ganeti::ganeti::git
    Vcsrepo { provider => "git", }
}

File { owner => "root", group => "root", }
