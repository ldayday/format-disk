#!/bin/bash
PATH=/bin:/sbin:/usr/bin:/usr/sbin:/usr/local/bin:/usr/local/sbin:~/bin
export PATH
LANG=en_US.UTF-8
#if [ $1 != "" ];then
	#setup_path=$1;
#fi

#检测磁盘数量
sysDisk=`cat /proc/partitions|grep -v name|grep -v ram|awk '{print $4}'|grep -v '^$'|grep -v '[0-9]$'|grep -v 'vda'|grep -v 'xvda'|grep -v 'sda'|grep -e 'vd' -e 'sd' -e 'xvd'`
if [ "${sysDisk}" == "" ]; then
	echo -e "ERROR!This server has only one hard drive,exit"
	echo -e "此服务器只有一块磁盘,无法挂载"
	echo -e "Bye-bye"
	exit;
fi


echo "
+----------------------------------------------------------------------
| Welcome to 数据盘格式清理工具 
+----------------------------------------------------------------------
| 请您在执行脚本前务必先重装系统保证系统内无分区或挂载数据盘的残留程序占用！
+----------------------------------------------------------------------
| 更新于 2022/02/08
+----------------------------------------------------------------------
"

while [ "$go" != 'y' ] && [ "$go" != 'n' ]
do
	read -p "Finally, are you sure you want to format the data disk?(y/n): " go;
done

if [ "$go" = 'n' ];then
	echo -e "Bye-bye"
	exit;
fi


		#格式化数据盘
		mkfs -t ext4 /dev/vdb1
				#开始删除分区
				fdisk /dev/vdb << EOF
d


wq
EOF
#刷新数据盘
partx -a /dev/vdb
         sleep 5
echo -e "格式化数据盘成功！"
echo -e "感谢您的使用"