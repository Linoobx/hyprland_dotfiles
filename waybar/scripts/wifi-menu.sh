#!/bin/bash

# Obtener lista de redes
networks=$(nmcli -t -f SSID,SIGNAL,SECURITY device wifi list | grep -v "^--" | sort -t: -k2 -nr | uniq)

if [ -z "$networks" ]; then
    notify-send "WiFi" "No se encontraron redes"
    exit 1
fi

# Formatear para wofi
options=""
while IFS=: read -r ssid signal security; do
    if [ -n "$ssid" ]; then
        if [ -n "$security" ]; then
            options+="  $ssid ($signal%) \n"
        else
            options+="  $ssid ($signal%) \n"
        fi
    fi
done <<< "$networks"

# Añadir opciones extra
options+=" Escanear redes\n"
options+="󰖪 Desactivar WiFi\n"
options+="󰖩 Activar WiFi"

# Mostrar menú
selected=$(echo -e "$options" | wofi --dmenu --prompt "WiFi" --width 300 --height 400)

case "$selected" in
    *"Escanear redes"*)
        nmcli device wifi rescan
        notify-send "WiFi" "Escaneando redes..."
        sleep 2
        ~/.config/waybar/scripts/wifi-menu.sh
        ;;
    *"Desactivar WiFi"*)
        nmcli radio wifi off
        notify-send "WiFi" "WiFi desactivado"
        ;;
    *"Activar WiFi"*)
        nmcli radio wifi on
        notify-send "WiFi" "WiFi activado"
        ;;
    *)
        if [ -n "$selected" ]; then
            ssid=$(echo "$selected" | sed 's/^[^ ]* //' | sed 's/ ([0-9]*%).*$//')
            
            # Verificar si ya está guardada
            if nmcli connection show "$ssid" &>/dev/null; then
                nmcli connection up "$ssid"
            else
                # Pedir contraseña
                password=$(wofi --dmenu --prompt "Contraseña para $ssid" --password --width 300 --height 100)
                if [ -n "$password" ]; then
                    nmcli device wifi connect "$ssid" password "$password"
                fi
            fi
        fi
        ;;
esac
