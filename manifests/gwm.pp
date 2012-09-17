class ganeti::gwm {
  $python_dev  = $ganeti::params::python_dev
  $gwm_version = $ganeti::params::gwm_version
  $fab_path    = $ganeti::params::fab_path

  package {
    "python-dev":   ensure => "installed", name => $python_dev, ;
    "python-pip":   ensure => "installed";
    "fabric":
      ensure    => "installed",
      require   => Package["python-pip"],
      provider  => "pip";
    "virtualenv":
      ensure    => "installed",
      require   => Package["python-pip"],
      provider  => "pip";
  }

  ganeti::unpack {
    "gwm":
      source  => "/root/src/ganeti-webmgr-${gwm_version}.tar.gz",
      cwd     => "/root/",
      creates => "/root/ganeti_webmgr",
      require => File["/root/src"];
  }

  file {
    "/root/ganeti_webmgr/settings.py":
      ensure  => present,
      source  => "/root/ganeti_webmgr/settings.py.dist",
      require => Ganeti::Unpack["gwm"];
    "/etc/init.d/vncap":
      ensure  => present,
      source  => "puppet:///modules/ganeti/gwm/vncap",
      mode    => 755;
    "/etc/init.d/flashpolicy":
      ensure  => present,
      source  => "puppet:///modules/ganeti/gwm/flashpolicy",
      mode    => 755;
  }

  exec { 
    "deploy-gwm":
      command => "$fab_path prod deploy",
      cwd     => "/root/ganeti_webmgr",
      timeout => "400",
      creates => "/root/ganeti_webmgr/bin/activate",
      require => [ Package["fabric"], Package["virtualenv"], 
        Package["python-dev"], Exec["unpack-gwm"] ];
  }

  service {
    "vncap":
      enable  => true,
      require => [ File["/etc/init.d/vncap"], Exec["deploy-gwm"], ];
    "flashpolicy":
      enable  => true,
      require => [ File["/etc/init.d/flashpolicy"], Exec["deploy-gwm"], ];
  }

  case $osfamily {
    redhat:   { include ganeti::redhat::gwm }
    default:  { }
  }
}

class ganeti::gwm::initialize {
  $files       = $ganeti::params::files

  exec {
    "syncdb-gwm":
      command => "${files}/scripts/syncdb-gwm",
      cwd     => "/root/ganeti_webmgr",
      creates => "/root/ganeti_webmgr/ganeti.db",
      require => Exec["deploy-gwm"];
  }
}
