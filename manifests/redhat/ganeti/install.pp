class ganeti::redhat::ganeti::install { 
  include ganeti::redhat::repo
  include ganeti::redhat::htools
  include ganeti::redhat::drbd
  include ganeti::redhat::kvm


  package {
    "ganeti":
	ensure => present,
	require => Class['Ganeti::Redhat::Repo']
  }

  service {
    "ganeti":
      ensure => running,
	enable => true,
	hasstatus => true,
	hasrestart => true,
  }

  file {
    "/etc/ganeti/kvm-vif-bridge":
      ensure  => present,
      require => Package["ganeti"],
  }

  # Set LVM stripe, as by default it is 1. 
  exec {"ganeti_lvm_stripe_set":
  	command => 'env LVMStripe=$(vgdisplay ganeti | grep "Cur PV"| awk \'{print $3}\') sed -i "s/LVM_STRIPECOUNT = .*/LVM_STRIPECOUNT = ${LVMStripe}/" /usr/lib/python2.6/site-packages/ganeti/_autoconf.py && touch /usr/lib/python2.6/site-packages/ganeti/_autoconf.py.puppetizedok',
  	creates => '/usr/lib/python2.6/site-packages/ganeti/_autoconf.py.puppetizedok',
  	logoutput => true,
  	path => ['/usr/local/sbin','/usr/local/bin','/sbin','/bin','/usr/sbin','/usr/bin'],
  	onlyif => 'grep "LVM_STRIPECOUNT = 1" /usr/lib/python2.6/site-packages/ganeti/_autoconf.py',
  	notify => Service['ganeti'],
  }
}
