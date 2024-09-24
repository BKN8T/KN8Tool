    #! /bin/bash 

    #--------------------------------
    VERSION="0.0.0.2"

    HISTORY_FILE="Command_history.txt" 

    #--------------------------------
    # Renk Kodları 
    RED='\033[0;31m'
    GREEN='\033[0;32m'
    YELLOW='\033[1;33m'
    BLUE='\033[0;34m'
    MAGENTA='\033[0;35m'
    CYAN='\033[0;36m'
    WHITE='\033[1;37m'
    BLACK='\033[0;30m'
    BOLD='\033[1m'
    NC='\033[0m'
    #--------------------------------
    # Update check
    #--------------------------------
    install_sqlmap() {
        echo "SQLMap yükleniyor..."
        git clone https://github.com/sqlmapproject/sqlmap.git "$HOME/sqlmap"
        echo "${GREEN}SQLMap başarıyla yüklendi: $HOME/sqlmap${NC}"
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
            echo  "${RED}Metasploit yüklü değil! Yüklemek ister misiniz? (e/h)${NC}"
            read -n 1 response
            echo # Yeni satıra geç
            if [[ $response == "e" || $response == "E" ]]; then
                install_msf
            fi
        else
            echo "${GREEN}Metasploit mevcut.${NC}"
            echo "${YELLOW}Güncelleme kontrol ediliyor...${NC}"
            msf_update_output=$(msfupdate 2>&1)
            if [[ "$msf_update_output" == *"already up to date"* ]]; then
                echo -"${GREEN}Metasploit zaten güncel!${NC}"
            else
                echo  "${YELLOW}Metasploit güncelleniyor...${NC}"
                echo "$msf_update_output"
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
                    echo  "${RED}Nmap yüklü değil! Yüklemek ister misiniz? (e/h)${NC}"
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
                echo  "${RED}Geçersiz araç adı: $tool_name${NC}"
                return
                ;;
        esac

        if [ "$current_version" != "$latest_version" ]; then
            echo  "${YELLOW}$tool_name güncellemeleri mevcut: $latest_version (Mevcut: $current_version)${NC}"
            echo  "${YELLOW}Güncellemek ister misiniz? (e/h)${NC}"
            read -n 1 response
            echo # Yeni satıra geç
            if [[ $response == "e" || $response == "E" ]]; then
                if [[ "$package_manager" == "brew" ]]; then
                    brew upgrade "$tool_name"
                else
                    sudo apt-get update && sudo apt-get install -y "$tool_name"
                fi
                echo  "${GREEN}$tool_name güncellendi!${NC}"
            else
                echo "Güncelleme iptal edildi."
            fi
        else
            echo  "${GREEN}$tool_name zaten güncel!${NC}"
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
            echo  "${GREEN}SET başarıyla yüklendi: $HOME/setoolkit${NC}"
        else
            echo  "${GREEN}SET zaten yüklü: $HOME/setoolkit${NC}"
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

    #--------------------------------
    # İlk mesajlar

    echo  "${BLUE}
    ██╗  ██╗███╗   ██╗ █████╗ ████████╗    ████████╗ ██████╗  ██████╗ ██╗     
    ██║ ██╔╝████╗  ██║██╔══██╗╚══██╔══╝    ╚══██╔══╝██╔═══██╗██╔═══██╗██║     
    █████╔╝ ██╔██╗ ██║╚█████╔╝   ██║          ██║   ██║   ██║██║   ██║██║     
    ██╔═██╗ ██║╚██╗██║██╔══██╗   ██║          ██║   ██║   ██║██║   ██║██║     
    ██║  ██╗██║ ╚████║╚█████╔╝   ██║          ██║   ╚██████╔╝╚██████╔╝███████╗
    ╚═╝  ╚═╝╚═╝  ╚═══╝ ╚════╝    ╚═╝          ╚═╝    ╚═════╝  ╚═════╝ ╚══════╝${NC}
   ${BLUE} --------------------------------------------------------------------------${NC}
    ${YELLOW}Instagram${NC} --> ${BLUE}fberkbudag${NC}       ${YELLOW}Discord${NC} --> ${BLUE}https://discord.gg/kn8t${NC}
    ${YELLOW}Github${NC}    --> ${BLUE}BKN8T ${NC}           ${RED}Komutlara ulaşmak için ${WHITE}help${NC}              
   ${BLUE} --------------------------------------------------------------------------${NC}
    "
    #--------------------------------
    # Ana döngü
    #--------------------------------
    while true; do
        
        echo  "${BLUE}KN8T: ${NC}\c"  
        read girdi
        echo "$girdi" >> "$HISTORY_FILE"
        case $girdi in 
            help) 
                echo "${GREEN}${BOLD}Komutlar:${NC}"
                echo "${WHITE}${BOLD}🆘 help            : Bu yardım menüsünü gösterir.${NC}"
                echo "${WHITE}${BOLD}🔢 version         : Botun sürümünü gösterir.${NC}"
                echo "${WHITE}${BOLD}🔄 update          : Güncelleme kontrolü yapar.${NC}"
                echo "${WHITE}${BOLD}❌ quit            : Botu kapatır.${NC}"
                echo "${WHITE}${BOLD}🧹 clear           : Terminal ekranını temizler.${NC}"
                echo "${WHITE}${BOLD}🌐 nmap            : Nmap aracı kullanımı için.${NC}"
                echo "${WHITE}${BOLD}🎯 msf             : Metasploit kullanımı için.${NC}"
                echo "${WHITE}${BOLD}💻 sqlmap          : SQLMap aracı kullanımı için.${NC}"
                echo "${WHITE}${BOLD}🔧 set             : Social Engineering Toolkit kurulumu ve kullanımı.${NC}"
                echo "${WHITE}${BOLD}📜 gecmis          : Komut geçmişini gösterir.${NC}"
                echo "${WHITE}${BOLD}🗑️ gecmis_temizle  : Komut geçmişini temizler.${NC}" ;;


            version)
                echo  "${BLUE}$VERSION ${NC}: Versiyonundasınız";;
            update)
                VERSION="0.0.0.2"  # Mevcut sürüm
                LATEST_VERSION=$(curl -s https://github.com/BKN8T/KN8Tool/blob/master/KN8T_Ver_0.0.0.2.sh)  # Versiyon kontrolü yapan GitHub URL'si
                if [[ "$LATEST_VERSION" != "$VERSION" ]]; then
                    echo  "${YELLOW}Yeni bir sürüm mevcut: $LATEST_VERSION. Güncellemek ister misiniz? (e/h)${NC}"
                    read -n 1 cevap
                    echo # Yeni satıra geç
                    if [[ $cevap == "e" || $cevap == "E" ]]; then
                        echo "Güncelleniyor..."
                        git pull origin main  # Güncelleme işlemi
                    else
                        echo "Güncelleme iptal edildi."
                    fi
                else
                    echo  "${GREEN}Zaten en son sürümü kullanıyorsunuz!${NC}"
                fi
            ;;

            quit) 
                echo "Çıkılıyor..."; 
                break;;  # Döngüyü sonlandır
            gecmis)
                echo "${YELLOW}Komut Geçmişi:${NC}"
                if [[ -f "$HISTORY_FILE" ]]; then
                    cat "$HISTORY_FILE"
                else
                    echo "Geçmiş bulunamadı."
                fi;;
            gecmis_temizle)
                > "$HISTORY_FILE"  # Dosyayı boşalt
                echo  "${GREEN}Komut geçmişi temizlendi.${NC}";;
            clear) 
                clear  # Ekranı temizle
                echo  "${MAGENTA}Ekran temizlendi.";;

            nmap)
                check_update nmap
                # Nmap'in yüklü olup olmadığını kontrol et
                if ! command -v nmap &> /dev/null; then
                    echo "${RED}Nmap yüklü değil! Yüklemek ister misiniz? (e/h)${NC}"
                    read -n 1 cevap
                    echo # Yeni satıra geç
                    if [[ $cevap == "e" || $cevap == "E" ]]; then
                        # OS kontrolü
                        if [[ "$OSTYPE" == "darwin"* ]]; then
                            # macOS için Homebrew ile yükleme
                            echo "Nmap yükleniyor..."
                            if command -v brew &> /dev/null; then
                                brew install nmap
                            else
                                echo  "${RED}Homebrew yüklü değil. Önce Homebrew yükleyin.${NC}"
                            fi
                        else
                            # Diğer sistemler için apt-get kullanımı
                            echo "Nmap yükleniyor..."
                            sudo apt-get update && sudo apt-get install -y nmap
                        fi
                    else
                        echo "Nmap yüklenmedi."
                        continue
                    fi
                fi
                echo "${YELLOW}Nmap Tarama İçin Hedef IP veya Alan Adını Girin:${NC} \c"
                read hedef
                echo "${YELLOW}Ek Nmap Seçeneklerini Girin (örneğin, -Pn, -sV):${NC} \c"
                read ek_secenekler
                
                # Nmap komutunu çalıştır
                nmap $ek_secenekler "$hedef" ;;
            nmap_help) 
                echo  "${GREEN}${BOLD}Nmap Komutları :${NC}"
                echo  "${WHITE}${BOLD}-sS             : SYN taraması (stealth) yapar.${NC}"
                echo  "${WHITE}${BOLD}-sT             : TCP bağlantı taraması (full connect).${NC}"
                echo  "${WHITE}${BOLD}-sU             : UDP taraması yapar.${NC}"
                echo  "${WHITE}${BOLD}-sV             : Hizmet versiyonu tespiti yapar.${NC}"
                echo  "${WHITE}${BOLD}-O              : İşletim sistemi tespiti yapar.${NC}"
                echo  "${WHITE}${BOLD}-Pn             : Hostların canlı olup olmadığını atlar.${NC}"
                echo  "${WHITE}${BOLD}-p <port>       : Belirtilen port veya port aralığını tarar.${NC}"
                echo  "${WHITE}${BOLD}-A              : Detaylı tarama (OS, versiyon, script, traceroute).${NC}"
                echo  "${WHITE}${BOLD}-T<0-5>         : Tarama hızı ayarı (0: en yavaş, 5: en hızlı).${NC}"
                echo  "${WHITE}${BOLD}-oN <dosya>     : Normal formatta tarama çıktısını belirtilen dosyaya kaydeder.${NC}"
                echo  "${WHITE}${BOLD}-oG <dosya>     : Grepable formatta çıktı alır.${NC}"
                echo  "${WHITE}${BOLD}-oX <dosya>     : XML formatında çıktı alır.${NC}"
                echo  "${WHITE}${BOLD}-F              : Hızlı tarama yapar, yalnızca en yaygın portları tarar.${NC}"
                echo  "${WHITE}${BOLD}-sP             : Hedef ağdaki aktif cihazları tarar (ping taraması).${NC}"
                echo  "${WHITE}${BOLD}-iL <dosya>     : Belirtilen dosyadaki IP adreslerini veya hedefleri kullanarak tarama yapar.${NC}"
                echo  "${WHITE}${BOLD}-n              : DNS çözümlemesini atlayarak yalnızca IP adreslerini kullanır.${NC}"
                echo  "${WHITE}${BOLD}-6              : IPv6 adresleri ile tarama yapar.${NC}"
                echo  "${WHITE}${BOLD}-p-             : Tüm 65535 TCP portunu tarar.${NC}"
                echo  "${WHITE}${BOLD}-v              : Tarama sırasında daha fazla bilgi verir (verbose).${NC}"
                echo  "${WHITE}${BOLD}-R              : DNS çözümlemesi yapar.${NC}"
                echo  "${WHITE}${BOLD}-sL             : Hedeflerin listesini gösterir, tarama yapmaz.${NC}"
                echo  "${WHITE}${BOLD}-Pn             : Ping taramasını atlayarak doğrudan tarama yapar.${NC}"
                echo  "----------------------------------";;

            john) 
                check_update john
                # John the Ripper'ın yüklü olup olmadığını kontrol et
                if ! command -v john &> /dev/null; then
                    echo  "${RED}John the Ripper yüklü değil! Yüklemek ister misiniz? (e/h)${NC}"
                    read -n 1 cevap
                    echo # Yeni satıra geç
                    if [[ $cevap == "e" || $cevap == "E" ]]; then
                        # OS kontrolü
                        if [[ "$OSTYPE" == "darwin"* ]]; then
                            echo "John the Ripper yükleniyor..."
                            if command -v brew &> /dev/null; then
                                brew install john
                            else
                                echo  "${RED}Homebrew yüklü değil. Önce Homebrew yükleyin.${NC}"
                            fi
                        else
                            echo "John the Ripper yükleniyor..."
                            sudo apt-get update && sudo apt-get install -y john
                        fi
                        # RockYou wordlist'ini indirin
                        if [[ ! -f "/usr/share/wordlists/rockyou.txt" ]]; then
                            echo "RockYou wordlist'i indiriliyor..."
                            wget -O /usr/share/wordlists/rockyou.txt.gz https://github.com/PwnFunction/Passwords/raw/master/rockyou.txt.gz
                            gunzip /usr/share/wordlists/rockyou.txt.gz
                        else
                            echo "${GREEN}RockYou wordlist zaten mevcut.${NC}"
                        fi
                    else
                        echo "John the Ripper yüklenmedi."
                        continue
                    fi
                fi
                echo  "${YELLOW}John the Ripper ile kullanılacak şifre dosyasını girin:${NC} \c"
                read sifre_dosyasi
                echo  "${YELLOW}Ek John the Ripper Seçeneklerini Girin:${NC} \c"
                read ek_john_secenekler
                
                # John the Ripper komutunu çalıştır
                john $ek_john_secenekler "$sifre_dosyasi" ;;

            msf) 
                check_msf_update
                echo  "${YELLOW}Metasploit'i başlatmak için 'msfconsole' yazın.${NC}"
                # msfconsole'u arka planda başlat
                msfconsole   # Arka planda çalıştır
                continue;;  # Ana döngüye devam et


            
            sqlmap)
                if [ ! -d "$HOME/sqlmap" ]; then
                    echo  "${RED}SQLMap yüklü değil! Yüklemek ister misiniz? (e/h)${NC}"
                    read -n 1 cevap
                    echo
                    if [[ $cevap == "e" || $cevap == "E" ]]; then
                        install_sqlmap
                    fi
                else
                    echo  "${GREEN}SQLMap zaten yüklü: $HOME/sqlmap${NC}"
                fi
                ;;
            set)
                # SET'in yüklü olup olmadığını kontrol et
                if [ ! -d "$HOME/setoolkit" ]; then
                    echo  "${RED}SET yüklü değil! Yüklemek ister misiniz? (e/h)${NC}"
                    read -n 1 cevap
                    echo
                    if [[ $cevap == "e" || $cevap == "E" ]]; then
                        install_set
                    fi
                else
                    echo "${GREEN}SET zaten yüklü: $HOME/setoolkit${NC}"
                fi
                ;;



            * ) 
                echo "${RED}Yanlış Komut Girişi!! ${WHITE}help${RED} İle Komutlara Ulaşabilirsiniz${NC}";;
        esac
    done