#!/bin/bash
#
# OpenWrt DIY script part 2 (After Update feeds)
#

# 1. Modifica l'IP di default del router per evitare conflitti con il modem 5G
sed -i 's/192.168.1.1/192.168.50.1/g' package/base-files/files/bin/config_generate

# 2. Modifica il nome del router (Hostname)
sed -i 's/OpenWrt/BPI-R4-5G/g' package/base-files/files/bin/config_generate

# 3. Imposta il tema grafico Argon come predefinito all'avvio
sed -i 's/luci-theme-bootstrap/luci-theme-argon/g' feeds/luci/collections/luci/Makefile

# 4. SCANSIONE GLOBALE ANTILOOP KCONFIG
# Individua dinamicamente i file sorgente di quectel-cm sia nei feed che nelle cartelle
# generate di OpenWrt, rimuovendo l'auto-dipendenza distruttiva.
echo "Riparazione loop Kconfig per quectel-cm..."
grep -rlE "define Package/quectel-cm|config PACKAGE_quectel-cm" package/ feeds/ 2>/dev/null | while read -r file; do
    echo "Fix applicato a: $file"
    sed -i 's/+quectel-cm//g' "$file"
    sed -i 's/+PACKAGE_quectel-cm//g' "$file"
    sed -i 's/select PACKAGE_quectel-cm//g' "$file"
    sed -i 's/select quectel-cm//g' "$file"
done
