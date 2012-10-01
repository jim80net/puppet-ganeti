class ganeti::redhat {
  class {'ganeti::redhat::repo':  stage => pre } 
  Package {
	subscribe => Yumrepo["elrepo", "osuosl.org"],
	ensure => present,
  }
  include ganeti::redhat::drbd
  include ganeti::redhat::htools
  include ganeti::redhat::kvm
  include ganeti::redhat::ganeti::install
  include ganeti::redhat::instance_image
  include ganeti::redhat::patches::hv_boot_kvm

}
