class ganeti::redhat::repo {
  Yumrepo {
    enabled => "1",
    gpgcheck => "1",
  }

  yumrepo {
    "elrepo":
      baseurl         => "http://elrepo.org/linux/elrepo/el6/\$basearch/",
      mirrorlist      => "http://elrepo.org/mirrors-elrepo.el6",
      gpgkey          => "file:///etc/pki/rpm-gpg/RPM-GPG-KEY-elrepo.org",
      require         => File["RPM-GPG-KEY-elrepo.org"];
  }

  file {
    "RPM-GPG-KEY-elrepo.org":
      path    => "/etc/pki/rpm-gpg/RPM-GPG-KEY-elrepo.org",
      ensure  => present,
      source  => "puppet:///modules/ganeti/RPM-GPG-KEY-elrepo.org";
  }

  yumrepo {
    "osuosl.org":
      baseurl	=> "http://ftp.osuosl.org/pub/osl/ganeti-centos-6/\$basearch/",
      gpgcheck  => "0",
  }
 
  exec { "/usr/bin/yum makecache":
	require => Yumrepo["elrepo", "osuosl.org"],
	refreshonly => true;
  }

}

