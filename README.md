# aliyunddns
## 这个镜像用作与对阿里云域名的动态解析，同时也是学习shell  
这是dev分支，用于对项目的开发。  
```
如何使用?:  
  配置环境：  
*项目测试环境在centos8.3/8.2中  
	> 安装阿里云环境：  
	> 1. 将分支中的文件aliyun 移动到/bin/ 目录下  
	> 2. aliyun configure 填如你的阿里云信息  
配置完成后. chmod 777 ddns.sh
```
```
运行方法:  
./ddns.sh [你的域名rr值] [你的主域名]  
*将[]去掉  
```
日志：  
运行日志在ddns.sh同目录下的aliyunddns.logs  
