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

class ganeti::redhat::ganeti inherits ganeti::ganeti::install {

  File["/etc/init.d/ganeti"] {
    require => [ Exec["install-ganeti"], File["/etc/sysconfig/ganeti"], ],
  }

  exec {
    "patch-daemon-util":
      command => "/usr/bin/patch -p1 < ${ganeti::params::files}/src/daemon-util.patch",
      cwd     => "/root/src/ganeti-${ganeti_version}",
      unless  => "/bin/grep daemonexec /root/src/ganeti-${ganeti_version}/daemons/daemon-util.in",
      require => [ Ganeti::Unpack["ganeti"], Package["patch"], ];
  }

  package { "patch": ensure => installed; }

  file {
    "/etc/sysconfig/ganeti":
      ensure  => present,
      source  => "${ganeti::params::files}/ganeti.sysconfig",
  }
}

class ganeti::redhat::ganeti::initialize inherits ganeti::ganeti::initialize {
  file {
    "/usr/lib/python2.6/site-packages/ganeti":
      ensure => link,
      target => "/usr/local/lib/python2.6/site-packages/ganeti";
  }
  Exec["initialize-ganeti"] {
    require => [ Exec["install-ganeti"], 
      Exec["modprobe_drbd"],
      File["/usr/lib/python2.6/site-packages/ganeti"], ],
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
