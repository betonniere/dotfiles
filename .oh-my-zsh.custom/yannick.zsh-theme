#
# Configuration
#
HIST_IGNORE_SPACE="true"
HIST_IGNORE_DUPS="true"

#
# starship ignation
#
case $(hostname) in
    megumi) ICON="🍎" ;;
    misaki) ICON="🍉" ;;
    madoka) ICON="🍋" ;;
    frog)   ICON="🐸" ;;
    titan)  ICON="🛰️ " ;;
    blue)   ICON="🐦" ;;
    surcouf) ICON="🍓" ;;
    raspberrypi) ICON="🍓" ;;
    dartboard)   ICON="🎯" ;;
    "RS-LPC144FR.corp.ateme.com") ICON="💻" ;;
    *) ICON="🚧" ;;
esac

export MY_HOST_ICON=$ICON

eval "$(starship init zsh)"
