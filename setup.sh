echo -e "${YELLOW}Kurulum başlatılıyor...${NC}"


sudo chmod 770 bin/main.sh
sudo chmod 770 bin/create_shortcuts
sudo chmod 770 config/colors.sh
sudo chmod 770 bin/install_update.sh
sudo chmod 440 version.txt



echo -e "${GREEN}Kurulum tamamlandı. İzinler verildi.${NC}"