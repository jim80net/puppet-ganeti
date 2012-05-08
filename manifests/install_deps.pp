class ganeti_tutorial::install_deps {
    package {
        # Ganeti deps
        "lvm2":             ensure => installed;
        "bridge-utils":     ensure => installed;
        "iproute":          ensure => installed;
        "iputils-arping":   ensure => installed;
        "ndisc6":           ensure => installed;
        "python-openssl":   ensure => installed;
        "openssl":          ensure => installed;
        "python-pyparsing": ensure => installed;
        "python-simplejson": ensure => installed;
        "python-pyinotify": ensure => installed;
        "python-pycurl":    ensure => installed;
        "socat":            ensure => installed;
        "python-paramiko":  ensure => installed;
        # htools deps
        "ghc6":                 ensure  => installed;
        "libghc6-json-dev":     ensure  => installed;
        "libghc6-network-dev":  ensure  => installed;
        "libghc6-parallel-dev": ensure  => installed;
        "libghc6-curl-dev":     ensure  => installed;
        # Misc
        "vim":              ensure => installed;
        "screen":           ensure => installed;
        "git":              ensure => installed;
        "python-pip":       ensure => "installed";
    }

    file {
        "/root/src":
            ensure  => present,
            source  => "/vagrant/modules/ganeti_tutorial/files/src/",
            recurse => true;
    }
}
