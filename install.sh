#! /bin/bash

#### formating partision
DISABLES=1

	(
	echo g;
	echo n;
	echo ;
	echo ;
	echo +512M;

	echo n;
	echo ;
	echo ;
	echo +2G;

	echo n;
	echo ;
	echo ;
	echo ;

	echo t;
	echo 1;
	echo 1;

	echo t;
	echo 2;
	echo swap;

	echo w;
	) | fdisk /dev/sda

	echo "step1: formating partision started ..."

	mkfs.fat -F 32 /dev/sda1

	mkswap /dev/sda2

	mkfs.ext4 /dev/sda3

	echo "step2: mounting partision started ..."

	mount /dev/sda3 /mnt

	mkdir /mnt/boot

	mount /dev/sda1 /mnt/boot

	swapon /dev/sda2





if [ $DISABLES -eq 0 ]
then

#### this is installing kernel/linux/firmware and other

	echo "step3: installing kernel firmware base and other ..."

	pacstrap -K /mnt base linux linux-firmware vim 
 
echo "step4: genfstab add config mounting to /mnt/etc/fstab ..."

genfstab -U /mnt >> /mnt/etc/fstab

########################################
########################################

echo "step5: configuration system ..."

arch-chroot /mnt ln -sf usr/share/zoneinfo/Asia/Tehran /etc/localtime

arch-chroot /mnt hwclock --systohc

arch-chroot /mnt echo "LANG=en_US.UTF-8" > /etc/locale.conf

arch-chroot /mnt echo "ahmadreza" >> /etc/hostname

arch-chroot /mnt mkinitcpio -P

arch-chroot /mnt echo "step6: set password for root ..."

arch-chroot /mnt passwd

arch-chroot /mnt echo "step7: install grub and configuration bootabling"

arch-chroot /mnt pacman -S  grub efibootmgr

arch-chroot /mnt grub-install --target=x86_64-efi --efi-directory=/boot --bootloader-id=GRUB

arch-chroot /mnt grub-mkconfig -o /boot/grub/grub.cfg

umount -R /mnt

reboot

fi
