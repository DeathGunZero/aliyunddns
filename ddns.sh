#!/bin/sh
user_rr=$1
user_dn=$2
local_ip=$(curl -s icanhazip.com)
remote_dn_ip=$(aliyun alidns DescribeSubDomainRecords --SubDomain "$user_rr.$user_dn" | jq -r .DomainRecords.Record[0].Value)
remote_dn_recordid=$(aliyun alidns DescribeSubDomainRecords --SubDomain "$user_rr.$user_dn" | jq -r .DomainRecords.Record[0].RecordId)

if [ $remote_dn_ip == null ];then
	exec echo -e $(date)"\n"$(aliyun alidns AddDomainRecord --DomainName $user_dn --RR $user_rr --Type A --Value $local_ip --Line default) >> ./aliyunddns.logs
	exit 0
else
	if [ $remote_dn_ip == $local_ip ];then
		echo -e $(date)"\nLocal IP not changed" >> ./aliyunddns.logs
		exit 0
	else
		exec echo -e $(date)"\n"$(aliyun alidns UpdateDomainRecord --RecordId $remote_dn_recordid --RR $user_rr --Type A --Value $local_ip --Line default) >> ./aliyunddns.logs
		exit 0
	fi
fi
