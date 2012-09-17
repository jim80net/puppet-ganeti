class ganeti::apt {
  Exec["apt_update"] -> Package <| |>

  exec {
    "apt_update":
      command     => "/usr/bin/apt-get update",
  }
}
