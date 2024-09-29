    source ../bin/install_update.sh
    
   source ../bin/install_update.sh

function run_nmap {
    check_update nmap
    
    # Nmap'in yüklü olup olmadığını kontrol et
    if ! command -v nmap &> /dev/null; then
        echo -e "${RED}Nmap yüklü değil! Yüklemek ister misiniz? (e/h)${NC}"
        read -n 1 cevap
        echo # Yeni satıra geç
        
        if [[ $cevap == "e" || $cevap == "E" ]]; then
            echo "Nmap yükleniyor..."
            
            # OS kontrolü
            if [[ "$OSTYPE" == "darwin"* ]]; then
                # macOS için Homebrew ile yükleme
                if command -v brew &> /dev/null; then
                    brew install nmap
                else
                    echo -e "${RED}Homebrew yüklü değil. Önce Homebrew yükleyin.${NC}"
                    return
                fi
            else
                # Diğer sistemler için apt-get kullanımı
                sudo apt-get update && sudo apt-get install -y nmap
            fi
        else
            echo "Nmap yüklenmedi."
            return
        fi
    fi

    # Kullanıcıdan hedef IP veya alan adını al
    echo -e "${YELLOW}Nmap Tarama İçin Hedef IP veya Alan Adını Girin: \c ${NC}"
    read hedef

    # Ek Nmap seçenekleri
    echo -e "${YELLOW}Ek Nmap Seçeneklerini Girin (örneğin, -Pn, -sV): \c ${NC}"
    read ek_secenekler
    
    # Nmap komutunu çalıştır
    nmap $ek_secenekler "$hedef"
}