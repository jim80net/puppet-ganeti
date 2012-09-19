class ganeti::redhat {
  require ganeti::redhat::repo
  include ganeti::redhat::drbd
  include ganeti::redhat::htools
  include ganeti::redhat::kvm
  include ganeti::redhat::ganeti::install
}
