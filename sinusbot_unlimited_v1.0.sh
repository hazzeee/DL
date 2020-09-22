#!/bin/bash
# Created By HAZZE

# variables

MACHINE=$(uname -m)
Version="v1.0"
IPADDR=$(ip route get 8.8.8.8 | awk {'print $7'} | tr -d '\n')
PW=$(cat /dev/urandom | tr -dc 'a-zA-Z0-9' | fold -w 8 | head -n 1)

# functs

function greenMessage() {
  echo -e "\\033[32;1m${*}\\033[0m"
}

function magentaMessage() {
  echo -e "\\033[35;1m${*}\\033[0m"
}

function cyanMessage() {
  echo -e "\\033[36;1m${*}\\033[0m"
}

function redMessage() {
  echo -e "\\033[31;1m${*}\\033[0m"
}

function yellowMessage() {
  echo -e "\\033[33;1m${*}\\033[0m"
}

function errorQuit() {
  errorExit 'Exit now!'
}

function errorExit() {
  redMessage "${@}"
  exit 1
}

function errorContinue() {
  redMessage "Invalid option."
  return
}

function makeDir() {
  if [ -n "$1" ] && [ ! -d "$1" ]; then
    mkdir -p "$1"
  fi
}

function heiz() {
  apt-get install sudo -y
  sudo apt-get install libxss1 -y
  sudo apt-get install screen -y 
  sudo apt-get update
  sudo apt-get upgrade -y
  apt-get -y -qq install libfontconfig libxtst6 screen xvfb libxcursor1 ca-certificates bzip2 psmisc libglib2.0-0 less cron-apt python iproute2 dbus libnss3 libegl1-mesa x11-xkb-utils libasound2 libxcomposite-dev libxi6 libpci3 libxslt1.1 libxkbcommon0 libxss1
  update-ca-certificates
}

function ytdl() {
  sudo curl -L https://yt-dl.org/downloads/latest/youtube-dl -o /usr/local/bin/youtube-dl
  sudo chmod a+rx /usr/local/bin/youtube-dl
}

# provera da li je root
if [ "$(id -u)" != "0" ]; then
  errorExit "Change to root account required!"
fi
clear
greenMessage "This is the automatic cracked SinusBot installer. USE AT YOUR OWN RISK"!
sleep 1
cyanMessage "You can choose between installing, upgrading and removing the SinusBot."
sleep 1
redMessage "Installer by HAZZE | RawCloud.me - Your game-/voiceserver hoster."
sleep 1
yellowMessage "You're using installer $Version"

# what we should do
redMessage "What should the installer do?"
OPTIONS=("Install" "Update" "Remove Instance" "PW Reset" "Start Instance" "Stop Instance" "YouTube-DL Install" "Quit")
select OPTION in "${OPTIONS[@]}"; do
  case "$REPLY" in
  1 | 2 | 3 | 4 | 5 | 6 | 7) break ;;
  5) errorQuit ;;
  *) errorContinue ;;
  esac
done

if [ "$OPTION" == "Install" ]; then
  INSTALL="Inst"
elif [ "$OPTION" == "Update" ]; then
  INSTALL="Updt"
elif [ "$OPTION" == "Remove Instance" ]; then
  INSTALL="Rem"
elif [ "$OPTION" == "PW Reset" ]; then
  INSTALL="Res"
elif [ "$OPTION" == "Start Instance" ]; then
  INSTALL="Start"
elif [ "$OPTION" == "Stop Instance" ]; then
  INSTALL="Stop"
elif [ "$OPTION" == "YouTube-DL Install" ]; then
  INSTALL="Ytdl"
elif [ "$OPTION" == "Quit" ]; then
  INSTALL="Quit"
fi

# update opt
if [ "$INSTALL" == "Updt" ]; then
   clear
   greenMessage "Not available in cracked script!"
fi
   
# install opt
if [ "$INSTALL" == "Inst" ]; then
  greenMessage "Installing depencies..."
  sudo dpkg --force-all -r atftpd
  sudo dpkg --add-architecture i3860 
  sudo apt-get -y update  
  sudo apt-get -y dist-upgrade 
  sudo apt-get install screen -y
  sudo apt-get -y -qq install screen x11vnc xvfb libpci* libxcursor1 libpulse0 libpulse0:i386 pulseaudio ca-certificates bzip2 psmisc libglib2.0-0 less cron-apt ntp python iproute2 dbus libnss3 libegl1-mesa x11-xkb-utils libasound2 libxcomposite-dev libxi6 unzip update-ca-certificates 
  sudo apt-get -qq -y install ca-certificates bzip2 python wget -y update-ca-certificates
  clear
  greenMessage "Now enter port to install."
  read -p "Port [eg. 8087]: " portinst
  clear
  greenMessage "Now enter password for instance."
  read -p "Password [eg. hazze1337]: " passinst
  greenMessage "Allright, installing that port :P"
  adduser --disabled-login --home /opt/SinusPort-$portinst --gecos "" SinusPort-$portinst --force-badname
  clear
  greenMessage "Added user: SinusPort-$portinst in /opt/SinusPort-$portinst"
  sleep 0.5
  clear
  apt-get update
  apt-get upgrade -y
  update-ca-certificates
  clear
  rm -rf /tmp/.X11-unix
  rm -rf /tmp/.sinusbot.lock
  cd SinusPort-$portinst
  su -c "cd; wget http://update.rawnetworks.eu/FILES/sinusbot-phpmulti/phpmulti-sinusbot.zip" SinusPort-$portinst
  su -c "cd; wget http://update.rawnetworks.eu/FILES/sinusbot-phpmulti/ts3php.zip" SinusPort-$portinst
  su -c "cd; wget https://cookiemc.tk/sinusbot/config.zip" SinusPort-$portinst
  su -c "cd; unzip phpmulti-sinusbot.zip" SinusPort-$portinst
  su -c "cd; unzip ts3php.zip" SinusPort-$portinst
  su -c "cd; unzip config.zip" SinusPort-$portinst
  su -c "cd; mkdir -p TeamSpeak3-Client-linux_amd64/plugins; cp plugin/libsoundbot_plugin.so TeamSpeak3-Client-linux_amd64/plugins/" SinusPort-$portinst
  clear
  sudo ln -sf /usr/lib/x86_64-linux-gnu/qt5/plugins/platforms/ /usr/bin/
  clear
  sed -i s/8087/$portinst/g /opt/SinusPort-$portinst/config.ini
  sed -i s/password/$passinst/g /opt/SinusPort-$portinst/password.txt
  sed -i s/sinusbot/SinusPort-$portinst/g /opt/SinusPort-$portinst/config.ini
  rm -rf /tmp/.X11-unix
  rm -rf /tmp/.sinusbot.lock
  rm -rf /opt/SinusPort-$portinst/config.ini.dist
  rm -rf /opt/SinusPort-$portinst/config.zip
  rm -rf /opt/SinusPort-$portinst/ts3php.zip
  su -c "cd; chmod 777 *" SinusPort-$portinst 
  clear
  greenMessage "Giving permissions to user..."
  chown -R SinusPort-$portinst /opt/SinusPort-$portinst
  clear
  greenMessage "Starting Bot..."
  sleep 0.5
  clear
  su -c "cd && screen -AmdS SinusPort-$portinst ./sinusbot -override-password $passinst >/dev/null" SinusPort-$portinst
  clear
  greenMessage "Bot started!!!"
  greenMessage "Credentials are bellow:"
  echo "  > Control Panel: $IPADDR:$portinst"
  echo "  > Username: admin"
  echo "  > Password: $passinst"
  echo ""
  greenMessage "Thanks for using!!!"
fi

#remove opt
if [ "$INSTALL" == "Rem" ]; then
   clear
   greenMessage "Enter port of instance to remove."
   read -p "Port [eg. 8087]: " portrem
   clear
   greenMessage "Okay, deleting instance :)"
   sleep 0.5
   clear
   su -c "cd; pkill screen" SinusPort-$portrem
   userdel SinusPort-$portrem
   rm -rf /opt/SinusPort-$portrem
   clear
   greenMessage "Successfully deleted instance at port: $portrem!"
fi

if [ "$INSTALL" == "Res" ]; then
   clear
   greenMessage "On which instance you want to reset password?"
   read -p "Port of instance [eg. 8087]: " portres
   clear
   greenMessage "Okay, now we will reset your password :)"
   read -p "New password [eg. hazze1337]: " newpw
   clear
   greenMessage "Stopping instance at port $portres"
   sleep 0.5
   clear
   su -c "cd; pkill screen" SinusPort-$portres
   clear
   greenMessage "Changing password..."
   sleep 0.5
   sed -i s/password/$newpw/g /opt/SinusPort-$portres/password.txt
   clear
   greenMessage "Starting instance again..."
   sleep 0.5
   clear
   su -c "cd && screen -AmdS SinusPort-$portres ./sinusbot -override-password $newpw >/dev/null" SinusPort-$portres
   clear
   greenMessage "Bot started!!!"
   greenMessage "Credentials are bellow:"
   echo "  > Control Panel: $IPADDR:$portres"
   echo "  > Username: admin"
   echo "  > New Password: $newpw"
   echo ""
   greenMessage "Thanks for using!!!"
fi

if [ "$INSTALL" == "Start" ]; then
   clear
   greenMessage "Enter instance port to start."
   read -p "Port [eg. 8087]: " portstart
   clear
   greenMessage "Stopping old instance (if online)..."
   su -c "cd; pkill screen" SinusPort-$portstart
   clear
   greenMessage "Starting instance at port: $portstart"
   sleep 0.5
   clear
   echo hazze > /tmp/.sinusbot.lock
   clear
   su -c "cd && screen -AmdS SinusPort-$portstart ./sinusbot >/dev/null" SinusPort-$portstart
   clear
   rm -rf /tmp/.sinusbot.lock
   clear
   PASSWORDSTART=$(cat /opt/SinusPort-$portstart/password.txt)
   clear
   greenMessage "Bot started!!!"
   greenMessage "Credentials are bellow:"
   echo "  > Control Panel: $IPADDR:$portstart"
   echo "  > Username: admin"
   echo "  > New Password: $PASSWORDSTART"
   echo ""
   greenMessage "Thanks for using!!!"
fi
   
if [ "$INSTALL" == "Stop" ]; then
   clear
   greenMessage "Enter instance port to stop."
   read -p "Port [eg. 8087]: " portstop
   clear
   greenMessage "Stopping instance..."
   su -c "cd; pkill screen" SinusPort-$portstop
   clear
   greenMessage "Starting instance at port: $portstop"
   sleep 0.5
   clear
   greenMessage "Instance at port $portstop is stopped!!!"
fi

if [ "$INSTALL" == "Ytdl" ]; then
   clear
   greenMessage "Installing YouTube-DL..."
   sleep 0.5
   clear
   ytdl
   clear
   greenMessage "YouTube-DL is installed!"
fi

if [ "$INSTALL" == "Quit" ]; then
   clear
   greenMessage "Thanks for using the script :)"
fi