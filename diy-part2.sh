#!/bin/bash

# 1. Trova e patcha il Device Tree del BPI-R4 (gestisce kernel 6.1 e 6.6)
DTS_FILE="target/linux/mediatek/files-6.6/arch/arm64/boot/dts/mediatek/mt7988a-banana-pi-bpi-r4.dts"
[ ! -f "$DTS_FILE" ] && DTS_FILE="target/linux/mediatek/files-6.1/arch/arm64/boot/dts/mediatek/mt7988a-banana-pi-bpi-r4.dts"

if [ -f "$DTS_FILE" ]; then
    # Disattiva l'interfaccia USB 3.0 sullo slot M.2 Key-B
    sed -i '/&usb3 {/!b;n;c\\tstatus = "disabled";' "$DTS_FILE"
    # Forza lo stato 'okay' sul controller PCIe 2 destinato al modem
    sed -i '/&pcie2 {/!b;n;c\\tpinctrl-names = "default";\n\tpinctrl-0 = <&pcie2_pins>;\n\tstatus = "okay";' "$DTS_FILE"
fi

# 2. Inietta lo script rc.local personalizzato per il PCI Rescan all'avvio del router
cat << 'EOF' > package/base-files/files/etc/rc.local
# Attesa boot elettrico del modulo RM551E-GL
sleep 12
echo 1 > /sys/bus/pci/devices/0002\:00\:00.0/remove 2>/dev/null
echo 1 > /sys/bus/pci/rescan
/etc/init.d/qmodem restart 2>/dev/null
exit 0
EOF
