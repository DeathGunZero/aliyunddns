#!/bin/sh
function ddns(){
	user_rr=$(echo $1 | tr -d "\n")
	user_dn=$(echo $2 | tr -d "\n")
	remote_dn_ip=$(aliyun alidns DescribeSubDomainRecords --SubDomain "$user_rr.$user_dn" | jq -r .DomainRecords.Record[0].Value)
	remote_dn_recordid=$(aliyun alidns DescribeSubDomainRecords --SubDomain "$user_rr.$user_dn" | jq -r .DomainRecords.Record[0].RecordId)
	local_ip=$(curl icanhazip.com)
	if [ -z $local_ip ]
	then
		echo "获取本地公网ip失败"
		exit 1
	elif [ -z $remote_dn_ip ] || [ $remote_dn_ip = null ]
	then
		exec echo -e $(date)"\n"$(aliyun alidns AddDomainRecord --DomainName $user_dn --RR $user_rr --Type A --Value $local_ip --Line default) >> ./aliyunddns.logs
		exit 0
	elif [ $remote_dn_ip = $local_ip ]
	then
		echo -e $(date)"\n解析IP无需改变" >> ./aliyunddns.logs
		exit 0
	else
		exec echo -e $(date)"\n"$(aliyun alidns UpdateDomainRecord --RecordId $remote_dn_recordid --RR $user_rr --Type A --Value $local_ip --Line default) >> ./aliyunddns.logs
		exit 0
		
	fi
}

COMMANDLINE="$*"
for COMMAND in $COMMANDLINE
do
	key=$(echo $COMMAND | awk -F"=" '{print $1}')
	val=$(echo $COMMAND | awk -F"=" '{print $2}')
	case $key in
		--rr)
			rr=$val
		;;
		--dn)
			dn=$val
		;;
		-help|-h)
			echo -e "--rr={your RR record}\n--dn={your domainname}"
			exit 0
		;;
	esac
done


if [ -z $rr ] || [ -z $dn ]
then
	echo "缺少输入或非法输入"
	echo "请运行./ddns.sh -h 查阅"
	exit 1
else
	ddns $rr $dn
fi 