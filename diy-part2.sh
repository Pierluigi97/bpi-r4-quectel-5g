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

# 4. BONIFICA TOTALE E AGGRESSIVA DEL FEED SIRILING
# Entriamo a tappeto in tutti i file del feed incriminato e King-Size eliminiamo il loop.
echo "Eradicazione chirurgica del loop quectel-cm..."
find feeds/siriling5g/ package/feeds/siriling5g/ -type f 2>/dev/null | while read -r file; do
    sed -i 's/+quectel-cm//g' "$file"
    sed -i 's/+PACKAGE_quectel-cm//g' "$file"
    sed -i 's/select PACKAGE_quectel-cm//g' "$file"
    sed -i 's/select quectel-cm//g' "$file"
done

# 5. IL COLPO DI GRAZIA: ELIMINAZIONE DELLA CACHE DI COMPILAZIONE
# Rimuovendo la cartella 'tmp', costringiamo OpenWrt a ignorare la vecchia struttura 
# memorizzata e a rigenerare il file .config-package.in basandosi sui file che abbiamo appena curato.
echo "Nuking della cartella tmp/ per forzare il rescan totale delle dipendenze..."
rm -rf tmp
