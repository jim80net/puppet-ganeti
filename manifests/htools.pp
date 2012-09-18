class ganeti::htools {
  include ganeti::params
  include ganeti::install_deps

  Package {
    ensure => present,
  }

  package {
    "ghc":
      name    => $ganeti::params::ghc_package_name;
    "libghc6-curl-dev":
      name    => $ganeti::params::libghc_curl_dev;
    "libghc6-json-dev":
      name    => $ganeti::params::libghc_json_dev;
    "libghc6-network-dev":
      name    => $ganeti::params::libghc_network_dev;
    "libghc6-parallel-dev":
      name    => $ganeti::params::libghc_parallel_dev;
  }

  if "$ganeti::params::ganeti_version" < "2.5.0" {
    ganeti::unpack {
      "htools":
        source  => "/root/src/ganeti-htools-${ganeti::params::htools_version}.tar.gz",
        cwd     => "/root/src",
        creates => "/root/src/ganeti-htools-${ganeti::params::htools_version}",
        require => Ganeti::Wget["htools-tgz"];
    }

    ganeti::wget {
      "htools-tgz":
        source      => "http://ganeti.googlecode.com/files/ganeti-htools-${ganeti::params::htools_version}.tar.gz",
        destination => "/root/src/ganeti-htools-${ganeti::params::htools_version}.tar.gz",
        require     => File["/root/src"];
    }

    exec {
      "install-htools":
        command => "/vagrant/modules/ganeti/files/scripts/install-htools",
        cwd     => "/root/src/ganeti-htools-${ganeti::params::htools_version}",
        creates => "/usr/local/sbin/hbal",
        require => [ Package["ghc"], Package["libghc6-json-dev"],
          Package["libghc6-network-dev"], Package["libghc6-parallel-dev"],
          Package["libghc6-curl-dev"], Ganeti::Unpack["htools"],];
    }
  }
}
