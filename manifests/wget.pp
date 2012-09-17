define ganeti::wget($source, $destination) {
  exec { "wget-$name":
    command => "/usr/bin/wget -q -O $destination $source",
    timeout => "300",
    creates => "$destination",
  }
}
