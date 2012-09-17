class ganeti::install_deps {
  $iputils_arping   = $ganeti::params::iputils_arping
  $python_openssl   = $ganeti::params::python_openssl
  $python_pyinotify = $ganeti::params::python_pyinotify
  $python_pyparsing = $ganeti::params::python_pyparsing
  $vim_package_name = $ganeti::params::vim_package_name

  package {
    # Ganeti deps
    "bridge-utils":     ensure => installed;
    "iproute":          ensure => installed;
    "iputils-arping":   ensure => installed, name => $iputils_arping;
    "lvm2":             ensure => installed;
    "make":             ensure => installed;
    "ndisc6":           ensure => installed;
    "openssl":          ensure => installed;
    "python-openssl":   ensure => installed, name => $python_openssl;
    "python-paramiko":  ensure => installed;
    "python-pycurl":    ensure => installed;
    "python-pyinotify": ensure => installed, name => $python_pyinotify;
    "python-pyparsing": ensure => installed, name => $python_pyparsing;
    "python-simplejson": ensure => installed;
    "socat":            ensure => installed;
    # Misc
    "git":              ensure => installed;
    "screen":           ensure => installed;
    "vim":              ensure => installed, name => $vim_package_name
    }

  file {
    "/root/src":
      ensure  => present,
      source  => "puppet:///modules/ganeti/src/",
      require => Package["make"],
      recurse => true;
  }
}
