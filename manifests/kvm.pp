class ganeti::kvm {
  
  package {
    "kvm":  
      ensure => present,
  }

  file {
    "/boot/vmlinuz-kvmU":
      ensure  => link,
      target  => "/boot/vmlinuz-${kernelrelease}";
    "/boot/initrd-kvmU":
      ensure  => link,
      target  => $osfamily ? {
        debian  => "/boot/initrd.img-${kernelrelease}",
        redhat  => "/boot/initramfs-${kernelrelease}.img",
      }
  }

  if $osfamily == "debian" {
    service {
      "qemu-kvm":
        enable  => false,
        require => Package["kvm"],
    }
  }
}
