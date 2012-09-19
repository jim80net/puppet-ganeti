class ganeti::redhat::ganeti::install { 
  require ganeti::redhat::repo

  include ganeti::redhat::htools
  include ganeti::redhat::drbd
  include ganeti::redhat::kvm

  package {
    "ganeti":
	ensure => present,
  }
}
