#!/bin/sh
#####################################
#Created By MOHAMED_OS 13-07-2021  #
#####################################

VEROS=11.693-emu-r798
VERNC=V11.9-r2
Package=libcurl4
EMUOS=enigma2-plugin-softcams-oscam*
EMUNC=enigma2-plugin-softcams-ncam*



if [ -f /etc/apt/apt.conf ] ; then
    STATUS='/var/lib/dpkg/status'
    OS='DreamOS'
elif [ -f /etc/opkg/opkg.conf ] ; then
    STATUS='/var/lib/opkg/status'
    OS='Opensource'
fi

##################
# Check Oscam     #
function checkoscam {
    if grep -qs "Package: $EMUOS" $STATUS ; then
        echo ""
        echo "Remove old version..."
        if [ $OS = "Opensource" ]; then
            opkg remove $EMUOS
        else
            apt-get purge --auto-remove $EMUOS
        fi
    else
        echo ""
    fi
}

##################
# Check Ncam     #
function checkncam {
    if grep -qs "Package: $EMUNC" $STATUS ; then
        echo ""
        echo "Remove old version..."
        if [ $OS = "Opensource" ]; then
            opkg remove $EMUNC
        else
            apt-get purge --auto-remove $EMUNC
        fi
    else
        echo ""
    fi
}

if grep -qs "Package: $Package" $STATUS ; then
    echo ""
else
    echo "Need to install $Package"
    echo ""
    if [ $OS = "Opensource" ]; then
        echo ""
        echo "Opkg Update ..."
        opkg update
        echo ""
        echo " Downloading $Package ......"
        opkg install $Package
    elif [ $OS = "DreamOS" ]; then
        echo "apt Update ..."
        apt-get update
        echo " Downloading $Package ......"
        apt-get install $Package -y
    else
        echo "#########################################################"
        echo "#            libcurl4 Not found in feed                 #"
        echo "#    Notification Emu will not work without libcurl4    #"
        echo "#########################################################"
        sleep 3
        exit 0
    fi
fi


PS3='Please enter your choice: '
options=("Oscam" "Revcam" "SupTV" "Ncam" "Quit")
select opt in "${options[@]}"
do
    case $opt in
        "Oscam")
            checkoscam
            if [ $OS = "Opensource" ]; then
                wget "--no-check-certificate" https://github.com/MOHAMED19OS/Download/blob/main/enigma2-plugin-softcams-oscam_"$VEROS"_all.ipk?raw=true -O /tmp/enigma2-plugin-softcams-oscam_"$VEROS"_all.ipk;
                opkg install /tmp/enigma2-plugin-softcams-oscam_"$VEROS"_all.ipk
                rm -f /tmp/enigma2-plugin-softcams-oscam_"$VEROS"_all.ipk
            else
                wget "--no-check-certificate" https://github.com/MOHAMED19OS/Download/blob/main/enigma2-plugin-softcams-oscam_"$VEROS"_all.deb?raw=true -O /tmp/enigma2-plugin-softcams-oscam_"$VEROS"_all.deb;
                dpkg -i --force-overwrite /tmp/enigma2-plugin-softcams-oscam_"$VEROS"_all.deb; apt-get install -f -y
                rm -f /tmp/enigma2-plugin-softcams-oscam_"$VEROS"_all.deb
            fi
            exit 0
            ;;
        "Revcam")
            checkoscam
            wget "--no-check-certificate" https://github.com/MOHAMED19OS/Download/blob/main/enigma2-plugin-softcams-oscam-revcam_"$VEROS"_all.ipk?raw=true -O /tmp/enigma2-plugin-softcams-oscam-revcam_"$VEROS"_all.ipk;
            opkg install /tmp/enigma2-plugin-softcams-oscam-revcam_"$VEROS"_all.ipk
            rm -f /tmp/enigma2-plugin-softcams-oscam-revcam_"$VEROS"_all.ipk
            exit 0
            ;;
        "SupTV")
            checkoscam
            wget "--no-check-certificate" https://github.com/MOHAMED19OS/Download/blob/main/enigma2-plugin-softcams-oscam-supcam_"$VEROS"_all.ipk?raw=true -O /tmp/enigma2-plugin-softcams-oscam-supcam_"$VEROS"_all.ipk;
            opkg install /tmp/enigma2-plugin-softcams-oscam-supcam_"$VEROS"_all.ipk
            rm -f /tmp/enigma2-plugin-softcams-oscam-supcam_"$VEROS"_all.ipk
            exit 0
            ;;
        "Ncam")
            checkncam
            if [ $OS = "Opensource" ]; then
                wget "--no-check-certificate" https://github.com/MOHAMED19OS/Download/blob/main/enigma2-plugin-softcams-ncam_"$VERNC"_all.ipk?raw=true -O /tmp/enigma2-plugin-softcams-ncam_"$VERNC"_all.ipk;
                opkg install /tmp/enigma2-plugin-softcams-ncam_"$VERNC"_all.ipk
                rm -f /tmp/enigma2-plugin-softcams-ncam_"$VERNC"_all.ipk
            else
                wget "--no-check-certificate" https://github.com/MOHAMED19OS/Download/blob/main/enigma2-plugin-softcams-ncam_"$VERNC"_all.deb?raw=true -O /tmp/enigma2-plugin-softcams-ncam_"$VERNC"_all.deb;
                dpkg -i --force-overwrite /tmp/enigma2-plugin-softcams-ncam_"$VERNC"_all.deb; apt-get install -f -y
                rm -f /tmp/enigma2-plugin-softcams-ncam_"$VERNC"_all.deb
            fi
            exit 0
            ;;
        "Quit")
            break
            ;;
        *) echo "invalid option $REPLY" ;;
    esac
done
