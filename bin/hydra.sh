
# Hydra aracını başlatmak için fonksiyon (dosya yolundan)
function run_hydra {
    HYDRA_PATH="$HOME/hydra"

    if [ ! -d "$HYDRA_PATH" ]; then
        echo -e "${RED}Hydra yüklü değil! Yüklemek ister misiniz? (e/h)${NC}"
        read -n 1 cevap
        echo -e
        if [[ $cevap == "e" || $cevap == "E" ]]; then
            echo "Hydra yükleniyor..."
            git clone https://github.com/vanhauser-thc/thc-hydra.git $HYDRA_PATH
            cd $HYDRA_PATH
            ./configure
            make
        else
            echo "Hydra yüklenmedi."
            return
        fi
    else
        echo -e "${GREEN}Hydra zaten yüklü. Hydra başlatılıyor...${NC}"
        cd $HYDRA_PATH
        .hydra-wizard.sh
    fi
}


function hydra_attack {
    echo -e "${YELLOW}Saldırı yapılacak hizmeti giriniz (örneğin: ftp, ssh, http-post-form): ${NC} \c"
    read hizmet

    echo -e "${YELLOW}Hedefi giriniz (IP adresi veya hedef dosya adı): ${NC} \c"
    read hedef

    echo -e "${YELLOW}Denemek için bir kullanıcı adı veya dosya adı giriniz: ${NC} \c"
    read kullanici_adi

    echo -e "${YELLOW}Denemek için bir şifre veya dosya adı giriniz: ${NC} \c"
    read sifre

    echo -e "${YELLOW}Şifre denemelerinde özel seçenekler eklemek istiyor musunuz? (Girişle aynı (s), boş (n), ters giriş (r)) - örn. \"sr\" veya boş bırakınız: ${NC} \c"
    read sifre_secenekleri

    echo -e "${YELLOW}Port numarasını girin (varsayılan için enter tuşuna basın): ${NC} \c"
    read port

    echo -e "${YELLOW}Ek modül seçenekleri varsa buraya girin (yoksa boş bırakın): ${NC} \c"
    read modul_secenekleri

    # Hydra komutunu oluşturma
    hydra_komutu="hydra -l $kullanici_adi -p $sifre"

    # Hedef IP veya alan adı ekle
    hydra_komutu="$hydra_komutu $hedef $hizmet"

    # Port numarası eklendi mi kontrol et
    if [[ ! -z "$port" ]]; then
        hydra_komutu="$hydra_komutu -s $port"
    fi

    # Ek modül seçenekleri ekle
    if [[ ! -z "$modul_secenekleri" ]]; then
        hydra_komutu="$hydra_komutu $modul_secenekleri"
    fi

    # Kullanıcıya oluşturulan komutu göster
    echo -e "${BLUE}Şu komut şimdi çalıştırılacak:${NC}"
    echo -e "$hydra_komutu"

    # Kullanıcıdan onay al
    echo -e "${YELLOW}Komutu şimdi çalıştırmak istiyor musunuz? [E/h]: ${NC} \c"
    read onay

    if [[ -z "$onay" || "$onay" == "E" || "$onay" == "e" ]]; then
        # Hydra komutunu çalıştır
        eval "$hydra_komutu"
    else
        echo -e "${RED}Komut çalıştırılmadı.${NC}"
    fi
}

