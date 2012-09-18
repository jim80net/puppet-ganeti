class ganeti::ganeti::initialize inherits ganeti::ganeti::install {
  exec {
    "initialize-ganeti":
      command => "${files}/scripts/initialize-ganeti",
      creates => "/var/lib/ganeti/config.data",
      require => [
        Exec["install-ganeti"], 
        Exec["modprobe_drbd"], ],
  }
}

