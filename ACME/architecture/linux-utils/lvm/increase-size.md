# Extend LVM when there is free space

## Reference

<https://4sysops.com/archives/extending-lvm-space-in-ubuntu/>

```bash
# To check the disk usage summary, use the following command:
sudo df -Th

# Use the sudo vgs or vgdisplay commands to verify whether there is any free space available in the volume group.
sudo vgdisplay

# If you see free space, use the lvdisplay command to view the LV path. Then run the lvextend command, as shown below:
sudo lvdisplay
sudo lvextend -l +100%FREE -r /dev/ubuntu-vg/ubuntu-lv
# The lvextend command with the -l (lowercase L) option specifies the size in extents. If you use -L (uppercase L), you need to specify the size (+10 GB to extend by 10 GB, for example).

# The +100%FREE option indicates that all remaining free space in the volume group should be added.
# The -r option resizes the underlying file system together with the logical volume. If you skip this option, you need to use the sudo resize2fs /dev/mapper/ubuntu--vg-ubuntu--lv command separately to extend the actual file system.
```
