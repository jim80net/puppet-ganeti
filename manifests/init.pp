# Ganeti Tutorial

class ganeti inherits ganeti::params {
  include ganeti::install_deps
  #include ganeti::hosts
  include ganeti::drbd

  $files  = $ganeti::params::files

  file {
    "/root/.ssh":
      ensure  => directory;
    "/var/lib/ganeti":
      ensure  => directory;
    "/var/lib/ganeti/rapi/":
      require => File["/var/lib/ganeti"],
      ensure  => directory;
    "/root/puppet":
      ensure  => link,
      target  => "/vagrant/modules/ganeti";
    "/var/lib/ganeti/rapi/users":
      ensure  => "present",
      mode    => 640,
      require => File["/var/lib/ganeti/rapi/"],
      source  => "puppet:///modules/ganeti/rapi-users";
  }

  case $operatingsystem {
    debian:   {
      include ganeti::debian
      include ganeti::apt
    }
    ubuntu:   { include ganeti::apt }
    centos:   { include ganeti::redhat }
    default:  { }
  }
}
