##
# This test will ensure that the ganeti vg is in place, then install ganeti. 
# This test will NOT initialize the cluster. 

import "lvm"

physical_volume {
  "/dev/vdb":
    ensure => present;
  "/dev/vdc":
    ensure => present;
}

volume_group { 
  "ganeti":
    ensure => present,
    physical_volumes => ["/dev/vdb", "/dev/vdc"]
}

include ganeti
