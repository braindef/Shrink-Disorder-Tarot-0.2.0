#!/bin/bash

sudo ls

xdg-open ../../../website/images/PrinterSettings.png
sudo system-config-printer

echo -n "Press [ENTER] if you changed the settings."
read answer

#unfortunately inkscape -p has a bug in debian jessie => Workarround

echo "


"

echo -n "install required debian jessie packages (y/n)? "
read answer
if echo "$answer" | grep -iq "^y" ;then
sudo apt-get install xdotool figlet inkscape
else
    echo not installing packages
fi

echo "

"
figlet -f banner Printing all A4 Sheets


echo -e "\e[34m"

figlet -f banner WARNING!!!
echo -e "\e[31mmy printer-firmware seems to hate this cards, even it has no route to the internet. eg if you printed 10 Cards the printer is electrostatically loaded, so the cards stick together you the printer takes 2-5 cards at the same time, so in this case it's the easiest to remove all paper from all trays and put the cards single into the printer

\e[0mplease press [enter] to continue
"
read answer


find . -name "*-*.svg" >./print.txt


echo -e "\e[34mPlease put $(cat ./print.txt |wc -l) A4 Sheets \e[31m
"
figlet -w 120 -f banner $(cat ./print.txt |wc -l) A4-Sheets
echo -e "into your default printer\e[0m some printers have issues with that much cards so\e[34m this script will wait after 10 cards \e[0m "

echo -e "
=> in the manual paper tray, edit this file for this problem
=> we also suggest to test it first manually, some printers turn the card, some turn them twice, after that the file for the backside
   of the card opens, in that case you have to choose $(cat ./print.txt|wc -l) copies manually after you have
   put the cards the other direction into the printe
=> after pressing enter, dont touch your computer until the cards are all printed
"

echo -n "continue (y/n)? "
read answer
if echo "$answer" | grep -iq "^y" 
then

 /usr/bin/inkscape &

counter=0

 for i in $(cat ./print.txt)
  do
 

   /usr/bin/inkscape $i &

   sleep 5
   xdotool key ctrl+p
   sleep 2
   xdotool key KP_Enter
   sleep 15
   xdotool key alt+F4

   echo printed $i

   let counter=counter+1 
   if (( $counter % 10 == 0 )) 
   then
     echo -e "\e[34mPlease put the next 10 A4 Sheets (250g/m²) \e[31m into your DEFAULT PRINTER  \e[0m"

     figlet -f banner 10 A4-Sheets

     echo "
then press enter" 

     read

   else
     echo "printing next card"
   fi
  done

else
    echo not not printing
fi

echo -n warning there is an offset of 2mm in this for my mfc9460cdn, use the template A4 if your printer has no offset, continue" (y/n)? "
read answer
if echo "$answer" | grep -iq "^y"
then

  # there is already an offset form 2mm
  /usr/bin/inkscape ./backA4.svg &
  sleep 5
  xdotool key ctrl+p

else

  /usr/bin/inkscape ./templateA4.svg &
  sleep 5
  xdotool key ctrl+p

fi
