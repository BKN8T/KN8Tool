# Update check
#--------------------------------
    install_sqlmap() {
        echo "SQLMap yükleniyor..."
        git clone https://github.com/sqlmapproject/sqlmap.git "$HOME/sqlmap"
        echo -e "${GREEN}SQLMap başarıyla yüklendi: $HOME/sqlmap${NC}"
    }

     install_hydra() {
        echo "Hydra yükleniyor..."
        git clone https://github.com/vanhauser-thc/thc-hydra "$HOME/hydra"
        echo -e "${GREEN}Hydra başarıyla yüklendi: $HOME/hydra${NC}"
    }


    install_msf() {
        echo "Metasploit yükleniyor..."
        if [[ "$OSTYPE" == "darwin"* ]]; then
            brew install metasploit
            brew services start postgresql

        else
            curl https://raw.githubusercontent.com/rapid7/metasploit-framework/master/scripts/installer.sh | bash
        fi
    }

    check_msf_update() {
        if ! command -v msfconsole &> /dev/null; then
            echo -e  "${RED}Metasploit yüklü değil! Yüklemek ister misiniz? (e/h)${NC}"
            read -n 1 response
            echo # Yeni satıra geç
            if [[ $response == "e" || $response == "E" ]]; then
                install_msf
            fi
        else
            echo -e "${GREEN}Metasploit mevcut.${NC}"
            echo -e "${YELLOW}Güncelleme kontrol ediliyor...${NC}"
            msf_update_output=$(msfupdate 2>&1)
            if [[ "$msf_update_output" == *"already up to date"* ]]; then
                echo -e "${GREEN}Metasploit zaten güncel!${NC}"
            else
                echo -e "${YELLOW}Metasploit güncelleniyor...${NC}"
                echo -e "$msf_update_output"
            fi
        fi
    }

    check_update() {
        local tool_name=$1
        local current_version
        local latest_version

        case $tool_name in
            nmap)
                if command -v nmap &> /dev/null; then
                    current_version=$(nmap --version | head -n 1 | awk '{print $2}')
                else
                    echo -e "${RED}Nmap yüklü değil! Yüklemek ister misiniz? (e/h)${NC}"
                    read -n 1 response
                    echo # Yeni satıra geç
                    if [[ $response == "e" || $response == "E" ]]; then
                        install_nmap
                    fi
                    return
                fi

                if [[ "$OSTYPE" == "darwin"* ]]; then
                    latest_version=$(curl -s https://formulae.brew.sh/api/formula/nmap.json | jq -r '.versions.stable')
                    package_manager="brew"
                else
                    latest_version=$(apt-cache show nmap | grep -m 1 Version | awk '{print $2}')
                    package_manager="apt-get"
                fi
                ;;
            john)
                if command -v john &> /dev/null; then
                    current_version=$(john --version)
                else
                    echo  "${RED}John the Ripper yüklü değil! Yüklemek ister misiniz? (e/h)${NC}"
                    read -n 1 response
                    echo # Yeni satıra geç
                    if [[ $response == "e" || $response == "E" ]]; then
                        install_john
                    fi
                    return
                fi

                if [[ "$OSTYPE" == "darwin"* ]]; then
                    latest_version=$(curl -s https://formulae.brew.sh/api/formula/john.json | jq -r '.versions.stable')
                    package_manager="brew"
                else
                    latest_version=$(apt-cache show john | grep -m 1 Version | awk '{print $2}')
                    package_manager="apt-get"
                fi
                ;;
            *)
                echo  -e "${RED}Geçersiz araç adı: $tool_name${NC}"
                return
                ;;
        esac

        if [ "$current_version" != "$latest_version" ]; then
            echo -e "${YELLOW}$tool_name güncellemeleri mevcut: $latest_version (Mevcut: $current_version)${NC}"
            echo -e "${YELLOW}Güncellemek ister misiniz? (e/h)${NC}"
            read -n 1 response
            echo # Yeni satıra geç
            if [[ $response == "e" || $response == "E" ]]; then
                if [[ "$package_manager" == "brew" ]]; then
                    brew upgrade "$tool_name"
                else
                    sudo apt-get update && sudo apt-get install -y "$tool_name"
                fi
                echo -e  "${GREEN}$tool_name güncellendi!${NC}"
            else
                echo "Güncelleme iptal edildi."
            fi
        else
            echo -e "${GREEN}$tool_name zaten güncel!${NC}"
        fi
    }

    install_nmap() {
        if [[ "$OSTYPE" == "darwin"* ]]; then
            echo "Nmap yükleniyor..."
            brew install nmap
        else
            echo "Nmap yükleniyor..."
            sudo apt-get update && sudo apt-get install -y nmap
        fi
    }

    install_set() {
        echo "Social Engineering Toolkit (SET) yükleniyor..."
        # SET'in yüklenmesi için git ile klonlama işlemi yapılır
        if [ ! -d "$HOME/setoolkit" ]; then
            git clone https://github.com/trustedsec/social-engineer-toolkit.git "$HOME/setoolkit"
            cd "$HOME/setoolkit" || return
            sudo python3 setup.py install
            echo -e "${GREEN}SET başarıyla yüklendi: $HOME/setoolkit${NC}"
        else
            echo -e  "${GREEN}SET zaten yüklü: $HOME/setoolkit${NC}"
        fi
    }


    install_john() {
        if [[ "$OSTYPE" == "darwin"* ]]; then
            echo "John the Ripper yükleniyor..."
            brew install john
        else
            echo "John the Ripper yükleniyor..."
            sudo apt-get update && sudo apt-get install -y john
        fi
    }
