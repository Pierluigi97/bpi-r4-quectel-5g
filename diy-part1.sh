#!/bin/bash
# OpenWrt DIY script part 1 (Before Update feeds)

# Aggiunge il feed di Siriling per i driver 5G PCIe del Quectel
echo 'src-git siriling5g https://github.com/Siriling/5G-Modem-Support.git' >> feeds.conf.default

# Aggiunge il feed per il tema grafico moderno "Argon"
echo 'src-git argon https://github.com/jerrykuku/luci-theme-argon.git' >> feeds.conf.default
