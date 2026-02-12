# Détection de l'icône selon le hostname
case $(hostname) in
    megumi) ICON="🍎" ;;
    misaki) ICON="🍉" ;;
    madoka) ICON="🍋" ;;
    frog)   ICON="🐸" ;;
    titan)  ICON="🛰️ " ;;
    blue)   ICON="🐦" ;;
    raspberrypi) ICON="🍓" ;;
    dartboard)   ICON="🎯" ;;
    "RS-LPC144FR.corp.ateme.com") ICON="💻" ;;
    *) ICON="🚧" ;;
esac

# On exporte l'icône pour que Starship puisse la lire
export MY_HOST_ICON=$ICON

eval "$(starship init zsh)"
