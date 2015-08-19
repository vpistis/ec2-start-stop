# ec2-start-stop
Start and Stop AWS EC2 Instances from another always active Instance

Use it for server development / test / stage that should not always be running.

1. Install [aws-cli](https://aws.amazon.com/it/cli/) into another EC2 instance that is always running 24 hours on 24, write a script like this ec2-start-stop.sh.
2. Put the script into cron (crontab -e) on this instance always active, for example using the [cron.txt](https://github.com/vpistis/ec2-start-stop/blob/master/cron.txt) provided.

**ATTENTION**: always make a backup and test first using it!
