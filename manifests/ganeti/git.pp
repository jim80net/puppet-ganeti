class ganeti::ganeti::git inherits ganeti::ganeti::install {
  package {
    "automake":         ensure => present;
    "autoconf":         ensure => present;
    "pandoc":           ensure => present;
    "python-docutils":  ensure => present;
    "python-sphinx":    ensure => present;
    "graphviz":         ensure => present;
  }

  Exec["install-ganeti"] {
    require => [ Vcsrepo["/root/src/ganeti-${ganeti_version}"],
      Package["ghc"],
      Package["libghc6-json-dev"],
      Package["libghc6-network-dev"],
      Package["libghc6-parallel-dev"],
      Package["libghc6-curl-dev"],
      Package["automake"], Package["autoconf"],
      Package["pandoc"], Package["graphviz"],
      Package["python-docutils"], Package["python-sphinx"], ],
  }
}
