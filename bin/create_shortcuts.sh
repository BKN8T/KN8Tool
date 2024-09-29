#? macOS için otomatik kısayol oluşturma
    if [[ "$OS" == "Darwin" ]]; then
        echo "macOS tespit edildi. Kısayol oluşturuluyor..."

    # AppleScript komutunu içeren bir geçici dosya oluştur
        APPLESCRIPT="
        do shell script \"/bin/bash '$SCRIPT_PATH'\"
        "
    
    # AppleScript dosyasını geçici bir yere yaz
        echo "$APPLESCRIPT" > /tmp/temp_script.applescript

    # AppleScript'i uygulama olarak masaüstüne kaydet
        osascript -e 'tell application "Finder" to make new folder at desktop with properties {name:"KN8Tool"}'
        osascript -e 'tell application "Finder" to open folder "KN8Tool" of desktop'
        osacompile -o ~/Desktop/KN8Tool/KN8Tool.app /tmp/temp_script.applescript

        echo "macOS'ta masaüstüne kısayol oluşturuldu!"

    # Linux için otomatik kısayol oluşturma
    elif [[ "$OS" == "Linux" ]]; then
        echo "Linux tespit edildi. Kısayol oluşturuluyor..."

    # Masaüstüne kısayol dosyası oluştur
        DESKTOP_FILE="$HOME/Desktop/KN8Tool.desktop"

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

        echo "Linux'ta masaüstüne kısayol oluşturuldu!"
    else
        echo "Bu işletim sistemi desteklenmiyor."
    fi
