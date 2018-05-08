
targets:
	@echo "    ec2-twitter"
	@echo "    jupyter"
	@echo "    ogcitrix"
	@echo "    ping-subnet"
	@echo "    powersave"
	@echo "    redshift"
	@echo "    rsync-{get,put}[-delete]"
	@echo "    streisand-start / streisand-stop"
	@echo "    sms"

ogcitrix:
	perl -i -p -e 's/CPMAllowed=On/CPMAllowed=Off/; s/VSLAllowed=On/VSLAllowed=Off/; s/DesiredHRES=1024/DesiredHRES=4294967295/; s/DesiredVRES=768/DesiredVRES=4294967295/; s/TWIMode=On/TWIMode=Off/;' ~/Downloads/launch.ica
	/opt/Citrix/ICAClient/wfica.sh ~/Downloads/launch.ica &

redshift:
	killall redshift 2> /dev/null ; redshift -l 40.71:-74.01 -t 6500:4500 > /dev/null &
# killall redshift 2> /dev/null ; redshift -l 34.71:-118.01 -t 6500:3700 > /dev/null &

jupyter:
	jupyter &

ping-subnet:
	seq 1 255 | parallel -j 64 "ping -c 1 -q -W 1 192.168.88.{} > /dev/null 2> /dev/null && echo {} || true"

powersave:
	sudo cpupower frequency-set -g powersave

ec2-twitter:
	ssh -i .ssh/rcy_amazon_ec2_kp.pem ec2-user@ec2-54-86-92-241.compute-1.amazonaws.com

rsync-get:
	rsync -avub --exclude "*~" --exclude=".cache" --exclude=".config" --exclude=".dbus" --exclude=".git" --exclude="log" --exclude=".thumbnails" root@192.168.88.200::NetBackup/r /home/.

rsync-put:
	rsync -Cavub --exclude=".cache" --exclude=".config" --exclude=".dbus" --exclude=".git" --exclude="log" --exclude=".thumbnails" /home/r root@192.168.88.200::NetBackup/.

rsync-get-delete:
	rsync -avub --del --exclude "*~" --exclude=".cache" --exclude=".config" --exclude=".dbus" --exclude=".git" --exclude="log" --exclude=".thumbnails" root@192.168.88.200::NetBackup/r /home/.

rsync-put-delete:
	rsync -Cavub --del --exclude=".cache" --exclude=".config" --exclude=".dbus" --exclude=".git" --exclude="log" --exclude=".thumbnails" /home/r root@192.168.88.200::NetBackup/.

streisand-start:
	aws ec2 start-instances --instance-id i-047699cde036aaa45 && date

streisand-stop:
	aws ec2 stop-instances --instance-id i-047699cde036aaa45 && date

streisand-ssh:
	ssh -i .ssh/streisand_rsa ubuntu@ec2-34-202-201-130.compute-1.amazonaws.com

sms:
	echo 'aws sns publish --topic-arn "arn:aws:sns:us-east-1:780170686194:rcyeh-sms" --message "blahblah"'
