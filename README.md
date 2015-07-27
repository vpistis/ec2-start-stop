# ec2-start-stop
Start and Stop AWS EC2 Instances from another always active Instance

Installate aws-cli su un’altra istanza EC2 che deve stare sempre accesa 24 ore su 24, preparatevi uno script come questo ec2-start-stop.sh
e mettetelo in cron, (crontab -e) su questa istanza sempre attiva, ad esempio usando il cron.txt
