class ganeti::redhat::patches::hv_boot_kvm {
	include ganeti::redhat::ganeti::install

	package {"patch":
		ensure => present,
	}

	file { '/root/src/ganeti-kvm-hv-boot-patch.diff':
		source => 'puppet:///modules/ganeti/patches/ganeti-kvm-hv-boot-patch.diff',
	}

	exec {'/usr/bin/patch --backup --forward /usr/lib/python2.6/site-packages/ganeti/hypervisor/hv_kvm.py /root/src/ganeti-kvm-hv-boot-patch.diff':
		creates => '/usr/lib/python2.6/site-packages/ganeti/hypervisor/hv_kvm.py.orig',
		require => [File['/root/src/ganeti-kvm-hv-boot-patch.diff'], Package['patch'], Package['ganeti']],#Class['Ganeti::Redhat::Ganeti::Install']],
		notify => Service['ganeti'],
	}



}
