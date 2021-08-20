sel dis 0
clean
convert gpt
cre par efi size=200
assign letter=G
format fs=fat32 quick
cre par msr size=16
cre par pri
assign letter=H
format fs=ntfs quick
lis vol
exit
