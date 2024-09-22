KN8Tool - Yeni Başlayanlar İçin Siber Güvenlik Aracı
Sürüm: 0.0.0.1

Genel Bakış:

KN8Tool, yeni başlayanlar için tasarlanmış, kullanımı kolay bir Bash tabanlı siber güvenlik aracıdır. Nmap ile ağ taramaları ve John the Ripper ile şifre kırma işlemlerini içeren temel komutları, diğer kullanışlı yardımcı programlarla birlikte sunar. Araç, renk kodlu çıktı ve gerekli bağımlılıkların otomatik kontrolü gibi özellikler sunarak deneyimsiz kullanıcılar için de erişilebilir hale getirir.

Özellikler:

Yardım Menüsü:
Kullanılabilir komutların listesini ve açıklamalarını gösterir.
Sürüm Kontrolü:
KN8Tool'un mevcut sürümünü gösterir ve güncelleme olup olmadığını kontrol eder.
Komut Geçmişi:
Tüm kullanıcı komutlarını Command_history.txt dosyasına kaydeder.
Kullanıcılar komut geçmişini görüntüleyebilir veya temizleyebilir.
Sistem Yardımcıları:
clear: Terminal ekranını temizler.
quit: Araçtan çıkış yapar.
Nmap Entegrasyonu:
Nmap yüklü değilse, yükleme yapılması için kullanıcıya uyarı verir.
Kullanıcılara ağ taramaları yapma ve özelleştirilebilir seçenekler sunar.
Yaygın Nmap komutları ve tarama teknikleri için yardım sağlar.
John the Ripper Entegrasyonu:
John the Ripper yüklü değilse, yükleme yapılması için kullanıcıya uyarı verir.
RockYou şifre listesini otomatik olarak indirir (eğer mevcut değilse).
Kullanıcılara ek seçeneklerle şifre kırma işlemi yapma olanağı sunar.
Kurulum:

Depoyu Klonlayın:
bash
Kodu kopyala
git clone https://github.com/yourusername/KN8Tool.git
cd KN8Tool
Scripti Çalıştırılabilir Yapın:
bash
Kodu kopyala
chmod +x KN8T_Ver_0.0.0.2.sh
Scripti Çalıştırın:
Kodu kopyala
./KN8T_Ver_0.0.0.2.sh
Komutlar:

help: Yardım menüsünü görüntüler.
version: Aracın mevcut sürümünü gösterir.
update: KN8Tool’un yeni sürümünü kontrol eder.
gecmis: Komut geçmişini görüntüler.
gecmis_temizle: Komut geçmişini temizler.
clear: Terminal ekranını temizler.
quit: Araçtan çıkış yapar.
nmap: Nmap taramaları için hedef ve seçenekleri aldıktan sonra işlemi başlatır.
nmap_help: Yaygın Nmap komutları için detaylı yardım gösterir.
john: Şifre kırma işlemi için bir şifre dosyası ve ek seçenekler aldıktan sonra John the Ripper'ı çalıştırır.
Bağımlılıklar:

Nmap: Ağ taramaları için kullanılır. KN8Tool, Nmap yüklü değilse kullanıcıya yükleme yapması için uyarı verir.
John the Ripper: Şifre kırma işlemleri için kullanılır. KN8Tool, yüklü değilse yükleme yapılmasını sağlar ve RockYou wordlist dosyasını indirir.





KN8Tool - Cybersecurity Tool for Beginners
Version: 0.0.0.2

Overview:

KN8Tool is an easy-to-use Bash-based cybersecurity tool designed for beginners. It includes basic commands for network scanning with Nmap and password cracking with John the Ripper, along with other useful utilities. The tool is interactive, with color-coded outputs and automatic checks for necessary dependencies, making it accessible even to those with minimal experience.

Features:

Help Menu:
Displays a list of available commands and their descriptions.
Version Check:
Displays the current version of KN8Tool and checks for updates if available.
Command History:
Saves all user commands to a Command_history.txt file.
Users can view or clear their command history.
System Utilities:
clear: Clears the terminal screen.
quit: Exits the tool.
Nmap Integration:
Checks if Nmap is installed and prompts the user to install it if missing.
Allows users to perform network scans with customizable options.
Provides help for common Nmap commands and scanning techniques.
John the Ripper Integration:
Checks if John the Ripper is installed and prompts the user to install it if missing.
Downloads the RockYou wordlist automatically if not present.
Allows users to perform password cracking with additional John options.
Installation:

Clone the Repository:
bash
Clone
git clone https://github.com/yourusername/KN8Tool.git
cd KN8Tool
Make the Script Executable:
bash

chmod +x KN8T_Ver_0.0.0.1.sh
Run the Script:

./KN8T_Ver_0.0.0.1.sh

Commands:
help: Displays the help menu.
version: Shows the current version of the tool.
update: Checks for new versions of KN8Tool.
gecmis: Displays command history.
gecmis_temizle: Clears the command history.
clear: Clears the terminal screen.
quit: Exits the tool.
nmap: Runs Nmap scans after prompting for target and options.
nmap_help: Displays detailed help for common Nmap commands.
john: Runs John the Ripper for password cracking after prompting for a password file and options.
Dependencies:

Nmap: Used for network scanning. KN8Tool will prompt for installation if it’s not found.
John the Ripper: Used for password cracking. KN8Tool will prompt for installation and download the RockYou wordlist if needed.


