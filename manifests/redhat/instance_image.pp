class ganeti::redhat::instance_image {
	include ganeti::redhat::repo
	
	package {
		"ganeti-instance-image":
	}

}
