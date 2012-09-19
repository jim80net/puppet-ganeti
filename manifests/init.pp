# Ganeti Tutorial

class ganeti inherits ganeti::params {

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
