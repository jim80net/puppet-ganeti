define ganeti::unpack($source, $cwd, $creates) {
  exec { "unpack-$name":
    command => "/bin/tar -zxf $source",
    cwd     => "$cwd",
    creates => "$creates",
  }
}
