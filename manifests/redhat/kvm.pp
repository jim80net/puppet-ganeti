class ganeti::redhat::kvm inherits ganeti::kvm {
  file {
    "/usr/bin/kvm":
      ensure  => link,
      target  => "/usr/libexec/qemu-kvm",
  }
  package {
    "python-virtinst":
      ensure => present,
 }
}

