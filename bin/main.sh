#! /bin/bash 


#? Source 
    
source ../config/colors.sh
source ./create_shortcuts.sh
source ./install_update.sh
#? İşletim sistemini tespit et
OS=$(uname)

#? Script'in tam yolunu bul (boşlukları desteklemek için)
SCRIPT_PATH="$(pwd)/$(basename "$0")"

    


#--------------------------------
VERSION="0.0.0.2"

# History dizin ve dosya oluşturma kontrolü
HISTORY_DIR="history"
HISTORY_FILE="../history/command.txt"

# Dizin yoksa oluştur
if [ ! -d "$HISTORY_DIR" ]; then
  mkdir -p "$HISTORY_DIR"
fi

# Dosya yoksa oluştur
if [ ! -f "$HISTORY_FILE" ]; then
  touch "$HISTORY_FILE"
fi


HISTORY_FILE="history/command.txt" 

#--------------------------------

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
    ${WHITE}Version${NC}   --> ${RED}$VERSION${NC}       
   ${BLUE} --------------------------------------------------------------------------${NC}
    "
    #--------------------------------
    # Ana döngü
    #--------------------------------
    while true; do
        
        echo  -e "${BLUE}KN8T: ${NC}\c"  
        read girdi
        echo "$girdi" >> "$HISTORY_FILE"
        case $girdi in 
            help|--h|-h) 
                echo -e "${GREEN}${BOLD}Komutlar:${NC}"
                echo -e "${WHITE}${BOLD}🆘 help            : Bu yardım menüsünü gösterir.${NC}"
                echo -e "${WHITE}${BOLD}🔢 version         : Botun sürümünü gösterir.${NC}"
                echo -e "${WHITE}${BOLD}🔄 update          : Güncelleme kontrolü yapar.${NC}"
                echo -e "${WHITE}${BOLD}❌ quit            : Botu kapatır.${NC}"
                echo -e "${WHITE}${BOLD}🧹 clear           : Terminal ekranını temizler.${NC}"
                echo -e "${WHITE}${BOLD}🌐 nmap            : Nmap aracı kullanımı için.${NC}"
                echo -e "${WHITE}${BOLD}🆘 nmap_help       : Yaygın Nmap komutları için detaylı yardım gösterir.${NC}"
                echo -e "${WHITE}${BOLD}🎯 msf             : Metasploit kullanımı için.${NC}"
                echo -e "${WHITE}${BOLD}💻 sqlmap          : SQLMap aracı kullanımı için.${NC}"
                echo -e "${WHITE}${BOLD}🔧 set             : Social Engineering Toolkit kurulumu ve kullanımı.${NC}"
                echo -e "${WHITE}${BOLD}📜 gecmis          : Komut geçmişini gösterir.${NC}"
                echo -e "${WHITE}${BOLD}🗑️ gecmis_temizle  : Komut geçmişini temizler.${NC}" ;;


            version)
                echo -e "${BLUE}$VERSION ${NC}: Versiyonundasınız";;
            update)
                VERSION="0.0.0.2"  # Mevcut sürüm
                LATEST_VERSION=$(curl -s https://raw.githubusercontent.com/BKN8T/KN8Tool/master/version.txt)  # Versiyon kontrolü yapan GitHub URL'si
                if [[ "$LATEST_VERSION" != "$VERSION" ]]; then
                    echo -e "${YELLOW}Yeni bir sürüm mevcut: $LATEST_VERSION. Güncellemek ister misiniz? (e/h)${NC}"
                    read -n 1 cevap
                    echo # Yeni satıra geç
                    if [[ $cevap == "e" || $cevap == "E" ]]; then
                        echo "Güncelleniyor..."
                        git pull origin main  # Güncelleme işlemi
                    else
                        echo "Güncelleme iptal edildi."
                    fi
                else
                    echo -e "${GREEN}Zaten en son sürümü kullanıyorsunuz!${NC}"
                fi
            ;;

            quit|q|exit) 
                echo "Çıkılıyor..."; 
                break;;  # Döngüyü sonlandır
            gecmis)
                echo -e "${YELLOW}Komut Geçmişi:${NC}"
                if [[ -f "$HISTORY_FILE" ]]; then
                    cat "$HISTORY_FILE"
                else
                    echo "Geçmiş bulunamadı."
                fi;;
            gecmis_temizle)
                > "$HISTORY_FILE"  # Dosyayı boşalt
                echo -e "${GREEN}Komut geçmişi temizlendi.${NC}";;
            clear|temizle) 
                clear  # Ekranı temizle
                echo  -e "${MAGENTA}Ekran temizlendi.${NC}";;

            nmap)
                check_update nmap
                # Nmap'in yüklü olup olmadığını kontrol et
                if ! command -v nmap &> /dev/null; then
                    echo -e "${RED}Nmap yüklü değil! Yüklemek ister misiniz? (e/h)${NC}"
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
                                echo -e "${RED}Homebrew yüklü değil. Önce Homebrew yükleyin.${NC}"
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
                echo -e "${YELLOW}Nmap Tarama İçin Hedef IP veya Alan Adını Girin:${NC} \c"
                read hedef
                echo -e "${YELLOW}Ek Nmap Seçeneklerini Girin (örneğin, -Pn, -sV):${NC} \c"
                read ek_secenekler
                
                # Nmap komutunu çalıştır
                nmap $ek_secenekler "$hedef" ;;
            nmap_help) 
                echo -e "${GREEN}${BOLD}Nmap Komutları :${NC}"
                echo -e "${WHITE}${BOLD}-sS             : SYN taraması (stealth) yapar.${NC}"
                echo -e "${WHITE}${BOLD}-sT             : TCP bağlantı taraması (full connect).${NC}"
                echo -e "${WHITE}${BOLD}-sU             : UDP taraması yapar.${NC}"
                echo -e "${WHITE}${BOLD}-sV             : Hizmet versiyonu tespiti yapar.${NC}"
                echo -e "${WHITE}${BOLD}-O              : İşletim sistemi tespiti yapar.${NC}"
                echo -e "${WHITE}${BOLD}-Pn             : Hostların canlı olup olmadığını atlar.${NC}"
                echo -e "${WHITE}${BOLD}-p <port>       : Belirtilen port veya port aralığını tarar.${NC}"
                echo -e "${WHITE}${BOLD}-A              : Detaylı tarama (OS, versiyon, script, traceroute).${NC}"
                echo -e "${WHITE}${BOLD}-T<0-5>         : Tarama hızı ayarı (0: en yavaş, 5: en hızlı).${NC}"
                echo -e "${WHITE}${BOLD}-oN <dosya>     : Normal formatta tarama çıktısını belirtilen dosyaya kaydeder.${NC}"
                echo -e "${WHITE}${BOLD}-oG <dosya>     : Grepable formatta çıktı alır.${NC}"
                echo -e "${WHITE}${BOLD}-oX <dosya>     : XML formatında çıktı alır.${NC}"
                echo -e "${WHITE}${BOLD}-F              : Hızlı tarama yapar, yalnızca en yaygın portları tarar.${NC}"
                echo -e "${WHITE}${BOLD}-sP             : Hedef ağdaki aktif cihazları tarar (ping taraması).${NC}"
                echo -e "${WHITE}${BOLD}-iL <dosya>     : Belirtilen dosyadaki IP adreslerini veya hedefleri kullanarak tarama yapar.${NC}"
                echo -e "${WHITE}${BOLD}-n              : DNS çözümlemesini atlayarak yalnızca IP adreslerini kullanır.${NC}"
                echo -e "${WHITE}${BOLD}-6              : IPv6 adresleri ile tarama yapar.${NC}"
                echo -e "${WHITE}${BOLD}-p-             : Tüm 65535 TCP portunu tarar.${NC}"
                echo -e "${WHITE}${BOLD}-v              : Tarama sırasında daha fazla bilgi verir (verbose).${NC}"
                echo -e "${WHITE}${BOLD}-R              : DNS çözümlemesi yapar.${NC}"
                echo -e "${WHITE}${BOLD}-sL             : Hedeflerin listesini gösterir, tarama yapmaz.${NC}"
                echo -e "${WHITE}${BOLD}-Pn             : Ping taramasını atlayarak doğrudan tarama yapar.${NC}"
                echo -e "----------------------------------";;

            john) 
                check_update john
                # John the Ripper'ın yüklü olup olmadığını kontrol et
                if ! command -v john &> /dev/null; then
                    echo -e "${RED}John the Ripper yüklü değil! Yüklemek ister misiniz? (e/h)${NC}"
                    read -n 1 cevap
                    echo # Yeni satıra geç
                    if [[ $cevap == "e" || $cevap == "E" ]]; then
                        # OS kontrolü
                        if [[ "$OSTYPE" == "darwin"* ]]; then
                            echo "John the Ripper yükleniyor..."
                            if command -v brew &> /dev/null; then
                                brew install john
                            else
                                echo -e "${RED}Homebrew yüklü değil. Önce Homebrew yükleyin.${NC}"
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
                            echo  -e "${GREEN}RockYou wordlist zaten mevcut.${NC}"
                        fi
                    else
                        echo "John the Ripper yüklenmedi."
                        continue
                    fi
                fi
                echo -e "${YELLOW}John the Ripper ile kullanılacak şifre dosyasını girin:${NC} \c"
                read sifre_dosyasi
                echo -e "${YELLOW}Ek John the Ripper Seçeneklerini Girin:${NC} \c"
                read ek_john_secenekler
                
                # John the Ripper komutunu çalıştır
                john $ek_john_secenekler "$sifre_dosyasi" ;;

            msf) 
                check_msf_update
                echo -e  "${YELLOW}Metasploit'i başlatmak için 'msfconsole' yazın.${NC}"
                # msfconsole'u arka planda başlat
                msfconsole   # Arka planda çalıştır
                continue;;  # Ana döngüye devam et


            
            sqlmap)
                if [ ! -d "$HOME/sqlmap" ]; then
                    echo -e  "${RED}SQLMap yüklü değil! Yüklemek ister misiniz? (e/h)${NC}"
                    read -n 1 cevap
                    echo -e
                    if [[ $cevap == "e" || $cevap == "E" ]]; then
                        install_sqlmap
                    fi
                else
                    echo -e  "${GREEN}SQLMap zaten yüklü: $HOME/sqlmap${NC}"
                fi
                ;;
            set)
                # SET'in yüklü olup olmadığını kontrol et
                if [ ! -d "$HOME/setoolkit" ]; then
                    echo -e "${RED}SET yüklü değil! Yüklemek ister misiniz? (e/h)${NC}"
                    read -n 1 cevap
                    echo
                    if [[ $cevap == "e" || $cevap == "E" ]]; then
                        install_set
                    fi
                else
                    echo -e "${GREEN}SET zaten yüklü: $HOME/setoolkit${NC}"
                fi
                ;;



            * ) 
                echo -e "${RED}Yanlış Komut Girişi!! ${WHITE}help${RED} İle Komutlara Ulaşabilirsiniz${NC}";;
        esac
    done