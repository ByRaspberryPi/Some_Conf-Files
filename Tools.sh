#!/bin/bash

# Aggiungere i colori
GREEN="\033[32m"
CYAN="\033[36m"
ORANGE="\033[38;5;214m"  # Colore arancione
RESET="\033[0m"

echo -e "${GREEN}This simple program will install some tools. For use, please be sure you're using a Linux system.${RESET}"

# Installazione di Python3 e Git, se non già presenti
echo -e "${GREEN}Checking for Python3 and Git installation...${RESET}"
if ! command -v python3 &>/dev/null; then
    echo -e "${GREEN}Python3 not found. Installing Python3...${RESET}"
    sudo apt update
    sudo apt install -y python3 python3-pip git
    echo -e "${GREEN}Python3 and Git have been installed.${RESET}"
else
    echo -e "${GREEN}Python3 is already installed.${RESET}"
fi

# Domanda di continuare
echo -e "${CYAN}Do you want to continue [y-n]?${RESET}"
read -p "" scelta
echo -e "${ORANGE}You chose: $scelta${RESET}"  # Colore arancione per la risposta

# Installazione dei tool
if [ "$scelta" = "y" ]; then
    # Installazione automatica con l'opzione -y per evitare la richiesta di conferma
    sudo apt install -y tmux
    sudo apt install -y crunch
    sudo apt install -y yersinia
    sudo apt install -y ettercap-graphical
    sudo apt install -y hydra

    echo -e "${GREEN}Tools installed:${RESET}"
    echo -e "${GREEN}- Tmux${RESET}"
    echo -e "${GREEN}- Crunch${RESET}"
    echo -e "${GREEN}- Yersinia${RESET}"
    echo -e "${GREEN}- Ettercap${RESET}"
    echo -e "${GREEN}- Hydra${RESET}"

    # Ciclo per rimuovere più tool, finché l'utente non sceglie di uscire
    while true; do
        # Domanda per disinstallare un tool
        echo -e "${CYAN}Do you want to uninstall any tool? [tmux/crunch/yersinia/ettercap/hydra] or 'n' to exit:${RESET}"
        read -p "" scelta2
        echo -e "${ORANGE}You chose: $scelta2${RESET}"  # Colore arancione per la risposta

        # Rimozione dei tool in base alla scelta dell'utente
        if [ "$scelta2" = "tmux" ]; then
            sudo apt remove -y tmux
            echo -e "${GREEN}Tmux has been uninstalled.${RESET}"
        elif [ "$scelta2" = "crunch" ]; then
            sudo apt remove -y crunch
            echo -e "${GREEN}Crunch has been uninstalled.${RESET}"
        elif [ "$scelta2" = "yersinia" ]; then
            sudo apt remove -y yersinia
            echo -e "${GREEN}Yersinia has been uninstalled.${RESET}"
        elif [ "$scelta2" = "ettercap" ]; then
            sudo apt remove -y ettercap-graphical
            echo -e "${GREEN}Ettercap has been uninstalled.${RESET}"
        elif [ "$scelta2" = "hydra" ]; then
            sudo apt remove -y hydra
            echo -e "${GREEN}Hydra has been uninstalled.${RESET}"
        elif [ "$scelta2" = "n" ]; then
            echo -e "${GREEN}No tool will be uninstalled.${RESET}"
            break  # Esce dal ciclo se l'utente non vuole disinstallare altro
        else
            echo -e "${GREEN}Invalid choice. Please try again.${RESET}"
        fi
    done

    # Pulizia pacchetti inutilizzati
    sudo apt autoremove -y
    echo -e "${GREEN}Unnecessary packages removed.${RESET}"

    # Domanda per installare SocialBox
    echo -e "${CYAN}Do you want to install SocialBox? [y-n]:${RESET}"
    read -p "" scelta_sb
    echo -e "${ORANGE}You chose: $scelta_sb${RESET}"  # Colore arancione per la risposta

    if [ "$scelta_sb" = "y" ]; then
        # Aggiorna il sistema e installa git
        echo -e "${GREEN}Updating system and installing git...${RESET}"
        sudo apt-get update && sudo apt-get install -y git

        # Clona il repository di SocialBox
        echo -e "${GREEN}Cloning SocialBox repository...${RESET}"
        git clone https://github.com/TunisianEagles/SocialBox.git

        # Entra nella cartella SocialBox
        cd SocialBox || { echo -e "${GREEN}Cloning failed or SocialBox folder not found!${RESET}"; exit 1; }

        # Modifica i permessi per i file di installazione
        echo -e "${GREEN}Setting permissions for installation files...${RESET}"
        chmod +x SocialBox.sh
        chmod +x install-sb.sh

        # Esegui lo script di installazione
        echo -e "${GREEN}Running install-sb.sh...${RESET}"
        ./install-sb.sh

        # Esegui SocialBox
        echo -e "${GREEN}Starting SocialBox...${RESET}"
        ./SocialBox.sh

        echo -e "${GREEN}SocialBox installation completed!${RESET}"
    elif [ "$scelta_sb" = "n" ]; then
        echo -e "${GREEN}Skipping SocialBox installation.${RESET}"
    else
        echo -e "${GREEN}Invalid choice. Please try again.${RESET}"
    fi

    # Domanda per installare PyPhisher
    echo -e "${CYAN}Do you want to install PyPhisher? [y-n]:${RESET}"
    read -p "" scelta_pp
    echo -e "${ORANGE}You chose: $scelta_pp${RESET}"  # Colore arancione per la risposta

    if [ "$scelta_pp" = "y" ]; then
        # Aggiorna il sistema e installa git
        echo -e "${GREEN}Updating system and installing git...${RESET}"
        sudo apt-get update && sudo apt-get install -y git

        # Clona il repository di PyPhisher
        echo -e "${GREEN}Cloning PyPhisher repository...${RESET}"
        git clone https://github.com/KasRoudra/PyPhisher.git

        # Entra nella cartella PyPhisher
        cd PyPhisher || { echo -e "${GREEN}Cloning failed or PyPhisher folder not found!${RESET}"; exit 1; }

        # Modifica i permessi per i file di installazione
        echo -e "${GREEN}Entering in pyphisher director...${RESET}"
        cd PyPhisher
        pip3 install -r files/requirements.txt
        
        # Avvia PyPhisher
        echo -e "${GREEN}Starting PyPhisher...${RESET}"
        python3 pyphisher.py

        echo -e "${GREEN}PyPhisher installation completed!${RESET}"
    elif [ "$scelta_pp" = "n" ]; then
        echo -e "${GREEN}Skipping PyPhisher installation.${RESET}"
    else
        echo -e "${GREEN}Invalid choice. Please try again.${RESET}"
    fi

elif [ "$scelta" = "n" ]; then
    echo -e "${GREEN}Exiting...${RESET}"
    exit 0
else
    echo -e "${GREEN}Invalid choice. Please try again.${RESET}"
fi

# Alla fine, installazione di proxychains4
echo -e "${CYAN}Do you want to install proxychains4? [y-n]:${RESET}"
read -p "" scelta_pc
echo -e "${ORANGE}You chose: $scelta_pc${RESET}"  # Colore arancione per la risposta

if [ "$scelta_pc" = "y" ]; then
    echo -e "${GREEN}Updating system and installing proxychains4...${RESET}"
    sudo apt update
    sudo apt install -y proxychains4
    echo -e "${GREEN}Proxychains4 has been installed.${RESET}"

    # Sostituzione del file proxychains4.conf dalla stessa cartella dello script
    if [ -f "./proxychains4.conf" ]; then
        echo -e "${GREEN}Found proxychains4.conf in the current directory. Replacing the existing file...${RESET}"
        sudo cp ./proxychains4.conf /etc/proxychains4.conf
        echo -e "${GREEN}The proxychains4.conf file has been replaced.${RESET}"
    else
        echo -e "${GREEN}Error: proxychains4.conf not found in the current directory.${RESET}"
    fi

elif [ "$scelta_pc" = "n" ]; then
    echo -e "${GREEN}Skipping proxychains4 installation.${RESET}"
else
    echo -e "${GREEN}Invalid choice. Please try again.${RESET}"
fi

# Termina lo script
echo -e "${GREEN}Script execution completed!${RESET}"
