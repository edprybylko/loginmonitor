#!/bin/sh
# Login Monitor
# by Edward Prybylko
# Last update: October 1, 2019
#
# Instructions:
# 	run this script to install the  directories and scripts
#
# Notes:
#	/etc/lightdm/securityBreaches is the directory of all footage of malicious activity
#	/etc/ligthdm/securityLog is the directory of all date/time of malicious activity
#
# Requires:
#	lightdm
#	motion


mkdir /etc/lightdm/securityBreaches
mkdir /etc/lightdm/motionLog
touch /etc/lightdm/motionConf
touch /etc/lightdm/securityLog
touch /etc/lightdm/preLogin
touch /etc/lightdm/postLogin

echo "daemon on" > /etc/lightdm/motionConf
echo "videodevice /dev/video0" >> /etc/lightdm/motionConf
echo "target_dir /etc/lightdm/motionLog" >> /etc/lightdm/motionConf


echo "#!/bin/sh" > /etc/lightdm/preLogin
echo "date >> /etc/lightdm/securityLog" >> /etc/lightdm/preLogin
echo "cp -f /etc/lightdm/motionLog/* /etc/lightdm/securityBreaches" >> /etc/lightdm/preLogin 
echo "motion -c /etc/lightdm/motionConf" >> /etc/lightdm/preLogin


echo "#!/bin/sh" > /etc/lightdm/postLogin
echo "pkill preLogin" >> /etc/lightdm/postLogin
echo "pkill motion" >> /etc/ligthdm/postLogin
echo "sed -i '$ d' /lightdm/securityLog" >> /etc/lightdm/postLogin
echo "rm -f /etc/lightdm/motionLog/*" >> /etc/lightdm/postLogin

echo /etc/lightdm/lightdm.conf >> "greeter-setup-script=/etc/lightdm/preLogin"
echo /etc/lightdm/lightdm.conf >> "session-setup-script=/etc/lightdm/postLogin"
