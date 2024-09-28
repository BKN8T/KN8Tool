
# 🌐 KN8Tool - Yeni Başlayanlar İçin Siber Güvenlik Aracı
**Sürüm:** 0.0.0.3

## Genel Bakış 🌟
KN8Tool, yeni başlayanlar için tasarlanmış, kullanımı kolay bir Bash tabanlı siber güvenlik aracıdır. Nmap ile ağ taramaları ve John the Ripper ile şifre kırma işlemlerini içeren temel komutları sunar. Araç, renk kodlu çıktı ve gerekli bağımlılıkların otomatik kontrolü gibi özelliklerle deneyimsiz kullanıcılar için erişilebilir hale getirilmiştir.

## Özellikler ✨
- **🆘 Yardım Menüsü:** Kullanılabilir komutların listesi ve açıklamaları.
- **🔍 Sürüm Kontrolü:** KN8Tool'un mevcut sürümü ve güncellemeler için kontrol.
- **📜 Komut Geçmişi:** Kullanıcı komutlarını `Command_history.txt` dosyasına kaydeder; geçmişi görüntüleme veya temizleme imkanı.
- **⚙️ Sistem Yardımcıları:** 
  - `clear`: Terminal ekranını temizler.
  - `quit`: Araçtan çıkış yapar.
- **🌐 Nmap Entegrasyonu:** Nmap’ın yüklü olup olmadığını kontrol eder, yoksa yükleme için uyarı verir; özelleştirilebilir ağ taramaları yapma imkanı sunar.
- **🔑 John the Ripper Entegrasyonu:** John the Ripper’ın yüklü olup olmadığını kontrol eder, yoksa yükleme için uyarı verir; RockYou şifre listesini otomatik indirir.

## Kurulum 🚀
1. **Depoyu Klonlayın:**
   ```bash
   git clone https://github.com/yourusername/KN8Tool.git
   cd KN8Tool
   ```

2. **Scripti Çalıştırılabilir Yapın:**
   ```bash
   chmod +x KN8T_Ver_0.0.0.2.sh
   ```

3. **Scripti Çalıştırın:**
   ```bash
   ./KN8T_Ver_0.0.0.2.sh
   ```

## Komutlar 🛠️
- `help`: Yardım menüsünü görüntüler.
- `version`: Aracın mevcut sürümünü gösterir.
- `update`: KN8Tool’un yeni sürümünü kontrol eder.
- `gecmis`: Komut geçmişini görüntüler.
- `gecmis_temizle`: Komut geçmişini temizler.
- `clear`: Terminal ekranını temizler.
- `quit`: Araçtan çıkış yapar.
- `nmap`: Nmap taramaları için hedef ve seçenekleri aldıktan sonra işlemi başlatır.
- `nmap_help`: Yaygın Nmap komutları için detaylı yardım gösterir.
- `john`: Şifre kırma işlemi için bir şifre dosyası ve ek seçenekler aldıktan sonra John the Ripper'ı çalıştırır.
- `sqlmap`: SQLmap çalıştırarak bir web uygulamasındaki SQL enjeksiyon testlerini gerçekleştirir. Kullanıcıya hedef URL ve diğer seçenekler için sorular sorar.
- `msf`: Metasploit Framework'ü çalıştırarak güvenlik açıklarını bulma ve istismar etme işlemlerini gerçekleştirir. Kullanıcıya hedef ve istismar seçenekleri için sorular sorar.

## Bağımlılıklar 📦
- **Nmap:** Ağ taramaları için kullanılır. Yüklenmediği takdirde kullanıcıya yükleme yapması için uyarı verilir.
- **John the Ripper:** Şifre kırma işlemleri için kullanılır. Yüklenmediği takdirde kullanıcıya yükleme yapması için uyarı verilir ve RockYou wordlist dosyasını indirir.
- **SQLmap:** SQL enjeksiyon testleri için kullanılır. Yüklenmediği takdirde kullanıcıya yükleme yapması için uyarı verilir.
- **Metasploit Framework (msf):** Güvenlik açıkları bulma ve istismar etme işlemleri için kullanılır. Yüklenmediği takdirde kullanıcıya yükleme yapması için uyarı verilir.

---

## 🌐 KN8Tool - Cybersecurity Tool for Beginners
**Version:** 0.0.0.3

### Overview 🌟
KN8Tool is an easy-to-use Bash-based cybersecurity tool designed for beginners. It includes basic commands for network scanning with Nmap and password cracking with John the Ripper, along with other useful utilities. The tool features interactive, color-coded outputs and automatic checks for necessary dependencies, making it accessible even to those with minimal experience.

### Features ✨
- **🆘 Help Menu:** Displays a list of available commands and their descriptions.
- **🔍 Version Check:** Displays the current version of KN8Tool and checks for updates.
- **📜 Command History:** Saves all user commands to a `Command_history.txt` file; users can view or clear their history.
- **⚙️ System Utilities:** 
  - `clear`: Clears the terminal screen.
  - `quit`: Exits the tool.
- **🌐 Nmap Integration:** Checks if Nmap is installed and prompts the user to install it if missing; allows for customizable network scans.
- **🔑 John the Ripper Integration:** Checks if John the Ripper is installed and prompts for installation if not; automatically downloads the RockYou wordlist.

### Installation 🚀
1. **Clone the Repository:**
   ```bash
   git clone https://github.com/yourusername/KN8Tool.git
   cd KN8Tool
   ```

2. **Make the Script Executable:**
   ```bash
   chmod +x KN8T_Ver_0.0.0.2.sh
   ```

3. **Run the Script:**
   ```bash
   ./KN8T_Ver_0.0.0.2.sh
   ```

### Commands 🛠️
- `help`: Displays the help menu.
- `version`: Shows the current version of the tool.
- `update`: Checks for new versions of KN8Tool.
- `gecmis`: Displays command history.
- `gecmis_temizle`: Clears the command history.
- `clear`: Clears the terminal screen.
- `quit`: Exits the tool.
- `nmap`: Runs Nmap scans after prompting for target and options.
- `nmap_help`: Displays detailed help for common Nmap commands.
- `john`: Runs John the Ripper for password cracking after prompting for a password file and options.
- `sqlmap`: Runs SQLmap to perform SQL injection tests on a web application. Prompts the user for the target URL and additional options.
- `msf`: Runs the Metasploit Framework to find and exploit security vulnerabilities. Prompts the user for the target and exploit options.

### Dependencies 📦
- **Nmap:** Used for network scanning; KN8Tool prompts for installation if not found.
- **John the Ripper:** Used for password cracking; KN8Tool prompts for installation and downloads the RockYou wordlist if needed.
- **SQLmap:** Used for SQL injection tests. If not installed, the user is prompted to install it.
- **Metasploit Framework (msf):** Used for finding and exploiting security vulnerabilities. If not installed, the user is prompted to install it.
---
