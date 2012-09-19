class ganeti::redhat::gwm inherits ganeti::gwm {
  file {
    "/usr/local/bin/pip":
      ensure  => link,
      target  => "/usr/bin/pip-python",
      require => Package["python-pip"],
  }

  Package["fabric"] {
    require => [ Package["python-pip"], File["/usr/local/bin/pip"], ],
  }
  Package["virtualenv"] {
    require => [ Package["python-pip"], File["/usr/local/bin/pip"], ],
  }
}
