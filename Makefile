
targets:
	@echo "    ec2-twitter"
	@echo "    jupyter"
	@echo "    ogcitrix"
	@echo "    ping-subnet"
	@echo "    powersave"
	@echo "    redshift"

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
	ssh -i .ssh/rcy_amazon_ec2_kp.pem ec2-user@ec2-54-86-177-73.compute-1.amazonaws.com

streisand-start:
	aws ec2 start-instances --instance-id i-047699cde036aaa45

streisand-stop:
	aws ec2 stop-instances --instance-id i-047699cde036aaa45

