#!/usr/bin/env bash
#set -x
IFS=$'\n'

tracer=0
nick=""
long=""
mail=""
pic=0
for line in $(grep -Ev "^$|^#" "$1")
do
    if [ "$line" != "END:VCARD" ]
    then
      echo $line
    fi
    verb=$(echo $line|cut -d ':' -f 1|cut -d ';' -f 1| tr -d '\r')
    case $verb in
    BEGIN)
        tracer=$((tracer + 1))
        ;;
    FN)
        long=$(echo $line|cut -d ':' -f 2| tr -d '\r')
        ;;
    X-MS-CARDPICTURE)
        pic=1   
        ;;
    PHOTO)
        pic=1   
        ;;
    EMAIL)
        mail=$(echo $line|cut -d ':' -f 2| tr -d '\r')
        nick=$(echo $mail|cut -d '@' -f 1| tr -d '\r')
        ;;
    END)
        tracer=$((tracer + 1))
        ;;
    esac

    if [ $tracer -eq 2 ]
    then
        #echo "For : $nick / $long ($email) "
        if [ $pic -eq 0 ]
        then
          #echo "I didn't found a picture so I download it "
          wget -O temp "http://robohash.org/"$nick-$email-$long".jpg"
          echo "PHOTO;ENCODING=B:"$(base64 -w0 temp)
        fi
        echo "END:VCARD"
        tracer=0
        nick=""
        long=""
        mail=""
        pic=0
    fi
done
