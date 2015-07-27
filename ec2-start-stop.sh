#!/bin/bash
#
# Amazon EC2 instance start stop script
#
# Lo script deve essere eseguito da una macchina diversa da quelle da spegnere/avviare,
# in genere puo' essere un server di produzione che sta sempre acceso 24/7.
#
#

AWS_CLI=/usr/local/bin/aws
# Array degli id delle istance da gestire, esempio INSTANCE_IDS=(i-12345678 i-00000000 i-11111111)
INSTANCE_IDS=(i-12345678 i-00000000)
# Array degli Elastic IP da collegare alle istanze, rispettare l'ordine dell'array INSTANCE_IDS.
# Esempio: PUBBLIC_IP=(123.456.789.000 000.222.444.122).
#
# L'ip nella poosizione 0 viene collegato all'id della posizione 0.
PUBBLIC_IPS=(123.456.789.000)
AWS_CLI_LOG=~/aws-cli.log
DRY_RUN=

usage()
{
echo " Aprire lo script e configurare id e ip delle istanze nelle variabili array."
echo $" Usage: $0 {stop-instances|start-instances|associate-eip|stop-instances-dry|start-instances-dry|associate-eip-dry}"
echo " -dry commands aggiungono l'opzione --dry-run, ovvero non eseguono veramente il comando."
}

stop-instances()
{
echo stop-instances - START DATE: `date` >> $AWS_CLI_LOG
$AWS_CLI ec2 stop-instances $DRY_RUN --instance-ids ${INSTANCE_IDS[@]} >> $AWS_CLI_LOG 2>&1
echo stop-instances - END DATE: `date` >> $AWS_CLI_LOG
#aws ec2 stop-instances --instance-ids=$INSTANCE_IDS
}

start-instances()
{
echo start-instances - START DATE: `date` >> aws-cli.log
$AWS_CLI ec2 start-instances $DRY_RUN --instance-ids ${INSTANCE_IDS[@]} >> $AWS_CLI_LOG 2>&1
echo start-instances - END DATE: `date` >> aws-cli.log
}

associate-eip()
{
echo associate-eip - START DATE: `date` >> aws-cli.log
sleep 20
count=0
for ip in ${PUBBLIC_IPS[@]}; do
$AWS_CLI ec2 associate-address $DRY_RUN --instance-id=${INSTANCE_IDS[$count]} --public-ip=${ip} >> $AWS_CLI_LOG 2>&1
count=$(( $count + 1 ))
done
echo associate-eip - END DATE: `date` >> aws-cli.log
}

case "$1" in
start-instances)
start-instances
;;
stop-instances)
stop-instances
;;
associate-eip)
associate-eip
;;
start-instances-dry)
DRY_RUN=--dry-run
start-instances
;;
stop-instances-dry)
DRY_RUN=--dry-run
stop-instances
;;
associate-eip-dry)
DRY_RUN=--dry-run
associate-eip
;;
help)
usage
;;
*)
usage
;;
esac
