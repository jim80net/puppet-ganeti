class ganeti::drbd {
  require ganeti::params

  package {
    "drbd8-utils":
      ensure  => installed,
      name    => $ganeti::params::drbd8_utils_package_name,
  }

  file {
    "/etc/modules":
      ensure  => present,
      source  => "puppet:///modules/ganeti/modules";
    "/etc/modprobe.d/drbd.conf":
      ensure  => present,
      source  => "puppet:///modules/ganeti/modprobe.d_drbd.conf",
      notify  => Exec["modprobe_drbd"];
  }

  exec {
    "modprobe_drbd":
      command => "/sbin/modprobe drbd",
      creates => "/sys/module/drbd/parameters/usermode_helper",
      require => [
        File["/etc/modprobe.d/drbd.conf"], Package["drbd8-utils"], ],
  }

  service {
    "drbd":
      enable  => false,
      require => Package["drbd8-utils"],
  }
}
