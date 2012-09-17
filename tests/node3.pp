$host_ip = "33.33.33.13"
$drbd_ip = "33.33.34.13"
$git     = false
$ganeti_version = "2.5.2"

include ganeti
include ganeti::networking
include ganeti::kvm
include ganeti::instance_image
include ganeti::ganeti::install
if $git {
    include ganeti::ganeti::git
    Vcsrepo { provider => "git", }
}

File { owner => "root", group => "root", }
