class ganeti::redhat::ganeti::initialize inherits ganeti::ganeti::initialize {
  file {
    "/usr/lib/python2.6/site-packages/ganeti":
      ensure => link,
      target => "/usr/local/lib/python2.6/site-packages/ganeti";
  }
  Exec["initialize-ganeti"] {
    require => [ Exec["install-ganeti"], 
      Exec["modprobe_drbd"],
      File["/usr/lib/python2.6/site-packages/ganeti"], ],
  }
}
