class ganeti::redhat::instance_image {
	require ganeti::redhat::repo
	
	package {
		"ganeti-instance-image":
			ensure => present,
	}

}
