class ganeti::debian {
  package {
    "qemu-utils": ensure => installed;
  }
}

class ganeti::debian::instance_image inherits ganeti::instance_image {
  Exec["install-instance-image"] {
    require +> Package["qemu-utils"],
  }
}
