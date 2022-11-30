diskutil unmount $1
dd if=boot.bin of=$1 bs=446 count=1
dd if=boot.bin of=$1 count=2 skip=1 seek=1
