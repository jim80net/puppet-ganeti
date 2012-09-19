class ganeti::kvm {
  include ganeti::params
  
  package {
    "kvm":  
      name => $ganeti::params::kvm_package_name,
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
