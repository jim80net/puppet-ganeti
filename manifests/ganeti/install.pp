class ganeti::ganeti::install {
  include ganeti::htools
  include ganeti::drbd
  include ganeti::kvm

  $ganeti_init_source = $ganeti::params::ganeti_init_source
  $files              = $ganeti::params::files

  file {
    "/etc/init.d/ganeti":
      ensure  => present,
      require => Exec["install-ganeti"],
      source  => $ganeti_init_source,
      mode    => 755;
    "/etc/ganeti":
      ensure  => directory;
    "/etc/ganeti/kvm-vif-bridge":
      ensure  => present,
      require => File["/etc/ganeti"],
      content => "";
  }

  if $git {
    vcsrepo {
      "/root/src/ganeti-${ganeti_version}":
        ensure    => present,
        provider  => "git",
        source    => "git://git.ganeti.org/ganeti.git",
        revision  => "${ganeti_version}";
    }
  } else {
    ganeti::unpack {
      "ganeti":
        source  => "/root/src/ganeti-${ganeti_version}.tar.gz",
        cwd     => "/root/src/",
        creates => "/root/src/ganeti-${ganeti_version}",
        require => Ganeti::Wget["ganeti-tgz"];
    }
  }

  if "$ganeti_version" < "2.5.0" {
    exec {
      "install-ganeti":
        command => "${files}/scripts/install-ganeti",
        cwd     => "/root/src/ganeti-${ganeti_version}",
        creates => "/usr/local/sbin/gnt-cluster",
        require => Ganeti::Unpack["ganeti"];
    }
  } else {
    exec {
      "install-ganeti":
        command =>
          "${files}/scripts/install-ganeti --enable-htools --enable-htools-rapi",
        cwd     => "/root/src/ganeti-${ganeti_version}",
        creates => "/usr/local/sbin/gnt-cluster",
        require => [ Ganeti::Unpack["ganeti"], Package["ghc"],
          Package["libghc6-json-dev"], Package["libghc6-network-dev"],
          Package["libghc6-parallel-dev"], Package["libghc6-curl-dev"], ];
    }
  }

  ganeti::wget {
    "ganeti-tgz":
      source      => "http://ganeti.googlecode.com/files/ganeti-${ganeti_version}.tar.gz",
      destination => "/root/src/ganeti-${ganeti_version}.tar.gz",
      require     => File["/root/src"];
  }


  service {
    "ganeti":
      enable  => true,
      require => File["/etc/init.d/ganeti"],
  }
}

