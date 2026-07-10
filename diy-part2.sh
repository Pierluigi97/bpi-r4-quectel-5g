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
