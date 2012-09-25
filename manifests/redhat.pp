class ganeti::redhat {
  class {'ganeti::redhat::repo':  stage => pre } 
  include ganeti::redhat::drbd
  include ganeti::redhat::htools
  include ganeti::redhat::kvm
  include ganeti::redhat::ganeti::install
  include ganeti::redhat::instance_image
}
