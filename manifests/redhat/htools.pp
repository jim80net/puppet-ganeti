class ganeti::redhat::htools {
  require ganeti::redhat::repo
  include ganeti::htools

  package {
    "libcurl-devel": ;
    "ganeti-htools": ;# From osuosl.org repo
  }
}
