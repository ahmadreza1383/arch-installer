#! /bin/bash


	echo "step1: formating partision started ..."

	mkfs.fat -F 32 /dev/sda1

	mkswap /dev/sda2

	mkfs.ext4 /dev/sda3

	echo "step2: mounting partision started ..."

	mount /dev/sda3 /mnt

	mkdir /mnt/boot

	mount /dev/sda1 /mnt/boot

	swapon /dev/sda2
