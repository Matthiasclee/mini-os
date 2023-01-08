# MLos
A 2.5kb OS written entirely in assembly

## Assembling
`bash ./assemble.sh`

## Running
`qemu-system-x86_64 main.bin`

## Copying to disk
`sudo dd if=main.bin of=/dev/sdX`

## QR code
### Creating a QR code 
`cat main.bin | lz4 -c | base64 | qrencode -o ml-os-qr.png`
### Reading a QR code
From file: `zbarimg --raw ml-os-qr.png | base64 -d | lz4 -cd > qr.bin`
From camera: `zbarcam -1 --raw | base64 -d | lz4 -cd > qr.bin`


