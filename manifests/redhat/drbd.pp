class ganeti::redhat::drbd inherits ganeti::drbd {
  include ganeti::redhat::repo

  package {
    "kmod-drbd83":
  }


  Exec["modprobe_drbd"] {
    require => [
      File["/etc/modprobe.d/drbd.conf"],
      Package["drbd8-utils"],
      Package["kmod-drbd83"],
    ]
  }

}

