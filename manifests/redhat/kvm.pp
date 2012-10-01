class ganeti::redhat::kvm {
  file {
    "/usr/bin/kvm":
      ensure  => link,
      target  => "/usr/libexec/qemu-kvm",
  }

  package {
    "python-virtinst":
	;
    "qemu-kvm":  
      ensure => '0.12.1.2-2.295.el6',
	;
    "qemu-img":  
      ensure => '0.12.1.2-2.295.el6',
	;
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
}
