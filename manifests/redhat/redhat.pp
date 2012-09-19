class ganeti::redhat {
  include ganeti::redhat::drbd
  include ganeti::redhat::htools
  include ganeti::redhat::ganeti
  include ganeti::redhat::ganeti::initialize
  include ganeti::redhat::kvm

  yumrepo {
    "ganeti":
      baseurl         => "http://ftp.osuosl.org/pub/osl/ganeti-centos-6/\$basearch/",
      enabled         => "1",
      gpgcheck        => "0";
  }
}


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
