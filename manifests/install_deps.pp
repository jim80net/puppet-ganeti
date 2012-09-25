class ganeti::install_deps {
  include ganeti::params

  Package {
    ensure => present
  }

  package {
    # Ganeti deps
    "bridge-utils":     ;
    "iproute":          ;
    "iputils-arping":   name => $ganeti::params::iputils_arping;
    "lvm2":             ;
    "make":             ;
    "ndisc6":           ;
    "openssl":          ;
    "python-openssl":   name => $ganeti::params::python_openssl;
    "python-paramiko":  ;
    "python-pycurl":    ;
    "python-pyinotify": name => $ganeti::params::python_pyinotify;
    "python-pyparsing": name => $ganeti::params::python_pyparsing;
    "python-simplejson": ;
    "socat":            ;
    # Misc
    "git":              ;
    "screen":           ;
    }

  file {
    "/root/src":
      ensure  => present,
      source  => "puppet:///modules/ganeti/src/",
      require => Package["make"],
      recurse => true;
  }
}
