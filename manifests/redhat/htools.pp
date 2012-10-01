class ganeti::redhat::htools {
  include ganeti::redhat::repo
  include ganeti::htools

  package {
    "libcurl-devel": ;
    "ganeti-htools": ;# From osuosl.org repo
  }
}
