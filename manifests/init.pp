# Ganeti Tutorial

class ganeti_tutorial {
    require ganeti_tutorial::params

    include ganeti_tutorial::install_deps
    include ganeti_tutorial::hosts
    include ganeti_tutorial::networking
    include ganeti_tutorial::drbd

    file {
        "/root/.ssh":
            ensure  => directory;
        "/root/puppet":
            ensure  => link,
            target  => "/etc/puppet/modules/ganeti_tutorial";
        "/var/lib/ganeti/rapi/users":
            ensure  => "present",
            source  => "${ganeti_tutorial::params::files}/rapi-users";
    }
}
