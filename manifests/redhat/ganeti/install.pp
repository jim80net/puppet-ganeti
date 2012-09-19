class ganeti::redhat::ganeti::install { #inherits ganeti::ganeti::install {
  include ganeti::redhat::htools
  include ganeti::redhat::drbd
  include ganeti::redhat::kvm

  package {
    "ganeti":
	ensure => present,
  }

#  File["/etc/init.d/ganeti"] {
#    require => [ Exec["install-ganeti"], File["/etc/sysconfig/ganeti"], ],
#  }
#
#  exec {
#    "patch-daemon-util":
#      command => "/usr/bin/patch -p1 < ${ganeti::params::files}/src/daemon-util.patch",
#      cwd     => "/root/src/ganeti-${ganeti_version}",
#      unless  => "/bin/grep daemonexec /root/src/ganeti-${ganeti_version}/daemons/daemon-util.in",
#      require => [ Ganeti::Unpack["ganeti"], Package["patch"], ];
#  }
#
#  package { "patch": ensure => installed; }
#
#  file {
#    "/etc/sysconfig/ganeti":
#      ensure  => present,
#      source  => "${ganeti::params::files}/ganeti.sysconfig",
#  }
}
