class ganeti::redhat::drbd inherits ganeti::drbd {
  require ganeti::redhat::repo

  Package["drbd8-utils"] {
    require => Yumrepo["elrepo"],
  }

  package {
    "kmod-drbd83":
      ensure  => present,
      require => Yumrepo["elrepo"];
  }


  Exec["modprobe_drbd"] {
    require => [
      File["/etc/modprobe.d/drbd.conf"],
      Package["drbd8-utils"],
      Package["kmod-drbd83"],
    ]
  }

}

