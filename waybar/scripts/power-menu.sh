#!/bin/bash

opciones="⏻ Apagar\n󰑓  Reiniciar\n Suspender\n  Cerrar sesion"

seleccion=$(echo -e "$opciones" | wofi --dmenu --prompt "Power" --width 200 --height 200)

case $seleccion in
	"⏻ Apagar") systemctl poweroff ;;
	"󰑓  Reiniciar") systemctl reboot ;;
	" Suspender") systemctl suspend ;;
	"  Cerrar sesion") hyprctl dispatch exit ;;
esac
