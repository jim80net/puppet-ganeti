class ganeti::instance_image {
  $image_version  = $ganeti::params::image_version
  $cirros_version = $ganeti::params::cirros_version

  package {
    "dump":   ensure => installed;
    "kpartx": ensure => installed;
  }

  file {
    "/etc/default/ganeti-instance-image":
      ensure  => present,
      require => Exec["install-instance-image"],
      content => template("ganeti/instance-image/defaults.erb");
    "/etc/ganeti/instance-image/variants.list":
      ensure  => present,
      require => Exec["install-instance-image"],
      source  => "${ganeti::params::files}/instance-image/variants.list";
    "/etc/ganeti/instance-image/variants/cirros.conf":
      ensure  => present,
      require => Exec["install-instance-image"],
      source  => "${ganeti::params::files}/instance-image/cirros.conf";
    "/etc/ganeti/instance-image/variants/default.conf":
      ensure  => "/etc/ganeti/instance-image/variants/cirros.conf",
      require => [ Exec["install-instance-image"],
        File["/etc/ganeti/instance-image/variants/cirros.conf"] ];
    "/etc/ganeti/instance-image/hooks/interfaces":
      mode    => 755,
      require => Exec["install-instance-image"];
    "/etc/ganeti/instance-image/hooks/zz_no-net":
      ensure  => present,
      mode    => 755,
      require => Exec["install-instance-image"],
      source  => "puppet:///modules/ganeti/instance-image/hooks/zz_no-net";
  }

  ganeti::wget {
    "cirros-root":
      require     => Exec["install-instance-image"],
      source      => "http://staff.osuosl.org/~ramereth/ganeti-tutorial/cirros-${cirros_version}-${hardwaremodel}.tar.gz",
      destination => "/var/cache/ganeti-instance-image/cirros-${cirros_version}-${hardwaremodel}.tar.gz";
    "instance-image-tgz":
      source      => "http://ftp.osuosl.org/pub/osl/ganeti-instance-image/ganeti-instance-image-${image_version}.tar.gz",
      destination => "/root/src/ganeti-instance-image-${image_version}.tar.gz",
      require     => File["/root/src"];
  }

  ganeti::unpack {
    "instance-image":
      source  => "/root/src/ganeti-instance-image-${image_version}.tar.gz",
      cwd     => "/root/src/",
      creates => "/root/src/ganeti-instance-image-${image_version}",
      require => Ganeti::Wget["instance-image-tgz"];
  }

  exec {
    "install-instance-image":
      command => "/vagrant/modules/ganeti/files/scripts/install-instance-image",
      cwd     => "/root/src/ganeti-instance-image-${image_version}",
      creates => "/srv/ganeti/os/image/",
      require => [ Ganeti::Unpack["instance-image"], 
        Package["dump"], Package["kpartx"], File["/root/puppet"], ];
  }
}

class ganeti::instance_image::ubuntu {
  $ubuntu_version = "${ganeti::params::ubuntu_version}"

  file {
    "/etc/ganeti/instance-image/variants/ubuntu-11.10.conf":
      ensure  => present,
      require => Exec["install-instance-image"],
      source  => "${ganeti::params::files}/instance-image/ubuntu-11.10.conf";
  }

  ganeti::wget {
    "ubuntu-root":
      require     => Exec["install-instance-image"],
      source      => "http://staff.osuosl.org/~ramereth/ganeti-tutorial/ubuntu-${ubuntu_version}-${hardwaremodel}.tar.gz",
      destination => "/var/cache/ganeti-instance-image/ubuntu-${ubuntu_version}-${hardwaremodel}.tar.gz";
  }
}
