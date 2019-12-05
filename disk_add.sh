	#!/bin/bash

	for i in `ls -l /sys/class/scsi_host/|awk '{print $9}'`
	do
			echo "- - -" > /sys/class/scsi_host/${i}/scan
	done
	fdisk -l
