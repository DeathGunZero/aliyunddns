# 阿里云动态解析
## 这个镜像用作与对阿里云域名的动态解析，同时也是学习shell  
这是dev分支，用于对项目的开发。  
```
如何使用?:  
  配置环境：  
*项目测试环境在centos8.3/8.2中  
	> 安装阿里云环境：  
	> 1. 将分支中的文件aliyun 移动到/bin/ 目录下  
	> 2. aliyun configure 填如你的相关信息  
配置完成后. chmod 777 ddns.sh
```
```
运行方法:  
你可以将此.sh文件移动到bin目录下以更便捷的方式运行，您也可以直接./ddns.sh运行  
sudo mv ddns.sh /bin/ddns  
使用 ddns -h 或 ddns -help 可以获得参数帮助  
使用 ddns --rr={您的域名RR值} --dn={您的主域名}  
```
'''
范例:  
ddns --rr=test --dn=example.com
运行上述命令将自动添加解析，将test.example.com解析到您的本机公网IP地址
'''
```
日志：  
运行日志: /var/log/aliyunddns.logs  
```
