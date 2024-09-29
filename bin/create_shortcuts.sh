OS=$(uname)

if [[ "$OS" == "Darwin" ]]; then
    echo "          macOS tespit edildi. Kısayol oluşturuluyor..."

    # Eğer masaüstünde 'KN8Tool' klasörü zaten varsa kurulu mesajı ver
    if [[ -d ~/Desktop/KN8Tool ]]; then
        echo "          KN8Tool zaten kurulu!"
    else
        # AppleScript komutunu içeren bir geçici dosya oluştur
        APPLESCRIPT="
        tell application \"Terminal\"
            do script \"/bin/bash ${SCRIPT_PATH}\"
        end tell
        "
        
        # AppleScript dosyasını geçici bir yere yaz
        echo "$APPLESCRIPT" > /tmp/temp_script.applescript

        # AppleScript'i uygulama olarak masaüstüne kaydet
        osascript -e 'tell application "Finder" to make new folder at desktop with properties {name:"KN8Tool"}'
        osascript -e 'tell application "Finder" to open folder "KN8Tool" of desktop'
        osacompile -o ~/Desktop/KN8Tool/KN8Tool.app /tmp/temp_script.applescript

        echo "          macOS'ta masaüstüne kısayol oluşturuldu!"
    fi

elif [[ "$OS" == "Linux" ]]; then
    echo "          Linux tespit edildi. Kısayol oluşturuluyor..."

    # Masaüstüne kısayol dosyası oluştur
    DESKTOP_FILE="$HOME/Desktop/KN8Tool.desktop"

    # Eğer masaüstünde kısayol zaten varsa kurulu mesajı ver
    if [[ -f "$DESKTOP_FILE" ]]; then
        echo "        KN8Tool zaten kurulu!"
    else
        # .desktop dosyası oluştur ve içine kısayol bilgilerini yaz
        echo "[Desktop Entry]
        Version=0.0.0.2
        Name=KN8Tool
        Comment=KN8T Tool Kısa Yolu
        Exec=\"$SCRIPT_PATH\"
        Icon=utilities-terminal
        Terminal=true
        Type=Application" > "$DESKTOP_FILE"

        # Kısayolu çalıştırılabilir yap
        chmod +x "$DESKTOP_FILE"

        echo "        Linux'ta masaüstüne kısayol oluşturuldu!"
    fi
else
    echo "        Bu işletim sistemi desteklenmiyor."
fi