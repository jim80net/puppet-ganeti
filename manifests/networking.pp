class ganeti::networking {
#  if $osfamily == "debian" {
#    file { "/etc/network/interfaces":
#      ensure  => present,
#      content => template("ganeti/interfaces.erb"),
#      notify  => [ Exec["ifup_br0"], Exec["ifup_eth2"], ],
#    }
#  } elsif $osfamily == "redhat" {
#    file { 
#      "/etc/sysconfig/network-scripts/ifcfg-br0":
#        ensure  => present,
#        content => template("ganeti/ifcfg-br0.erb"),
#        require => File["/etc/sysconfig/network-scripts/ifcfg-eth1"],
#        notify  => Exec["ifup_br0"];
#      "/etc/sysconfig/network-scripts/ifcfg-eth1":
#        ensure  => present,
#        source  => "puppet:///modules/ganeti/ifcfg-eth1",
#    }
#  }
#
#  exec {
#    "ifup_br0":
#      command     => "/sbin/ifup br0",
#      refreshonly => true,
#      require     => $osfamily ? {
#        debian  => File["/etc/network/interfaces"],
#        redhat  => File["/etc/sysconfig/network-scripts/ifcfg-br0"],
#      };
#
#    "ifup_eth2":
#      command     => "/sbin/ifup eth2",
#      refreshonly => true,
#      require     => $osfamily ? {
#        debian  => File["/etc/network/interfaces"],
#        redhat  => File["/etc/sysconfig/network-scripts/ifcfg-eth2"],
#      };
#  }
}
