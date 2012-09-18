class ganeti::redhat::repo {
  yumrepo {
    "elrepo":
      baseurl         => "http://elrepo.org/linux/elrepo/el6/\$basearch/",
      mirrorlist      => "http://elrepo.org/mirrors-elrepo.el6",
      enabled         => "1",
      gpgcheck        => "1",
      gpgkey          => "file:///etc/pki/rpm-gpg/RPM-GPG-KEY-elrepo.org",
      require         => File["RPM-GPG-KEY-elrepo.org"];
  }

  file {
    "RPM-GPG-KEY-elrepo.org":
      path    => "/etc/pki/rpm-gpg/RPM-GPG-KEY-elrepo.org",
      ensure  => present,
      source  => "puppet:///modules/ganeti/RPM-GPG-KEY-elrepo.org";
  }
}

