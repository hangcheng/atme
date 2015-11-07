##安装oracle
###上传oracle安装包并解压
>提示： (注销当前账号，用 oracle 账号登陆完成安装操作，否则会报错)

>上传采用 ftp   软件 荐：FileZilla

~~~
# su - oracle
$ cd /prust/app/oracle
$ unzip linux.x64_11gR2_database_1of2.zip
$ unzip linux.x64_11gR2_database_2of2.zip
~~~

###拷贝并编辑静默安装文件

~~~
$ cp /prust/app/oracle/database/response/*.* /prust/app/
$ vi db_install.rsp

修改下面的配置参数(具体可以根据网上信息修改)
oracle.install.option=INSTALL_DB_SWONLY//只安装oracle软件，不安装实例
ORACLE_HOSTNAME=oracleserver//honstname命令获得的主机名
UNIX_GROUP_NAME=oinstall
INVENTORY_LOCATION=/prust/app/oracle/oraInventory
SELECTED_LANGUAGES=en,zh_CN//安装时的语言，其实en就够了，看中文反而麻烦
ORACLE_HOME=/prust/app/oracle/product/11.2.0/db_1
ORACLE_BASE=/prust/app/oracle
oracle.install.db.InstallEdition=EE
oracle.install.db.isCustomInstall=false
oracle.install.db.DBA_GROUP=dba
oracle.install.db.OPER_GROUP=oinstall
DECLINE_SECURITY_UPDATES=true //一定设置为true，网上都这么说，我也没试，就设置成true吧
~~~

###开始安装数据库软件

~~~
$ cd /prust/app/oracle/database
$ ./runInstaller -silent -force -responseFile /prust/app/db_install.rsp
 // -silent静默安装 -force文件夹不存在强制创建 -responseFile静默安装响应文件
~~~

>另开一个窗口，查看安装日志

    # tail -f /prust/app/oracle/oraInventory/logs/installActions*.log
>安装比较慢，耐心等待下
>安装完成，这次出来的是中文，提示如下：
 
>要执行配置脚本, 请执行以下操作:   
         1. 打开一个终端窗口   
         2. 以 "root" 身份登录   
         3. 运行脚本   
         4. 返回此窗口并按 "Enter" 键继续   
 
>按回车继续。  
>在另外一个窗口使用root用户执行

~~~
# /prust/app/oracle/oraInventory/orainstRoot.sh
# /prust/app/oracle/product/11.2.0/db_1/root.sh
~~~
>Oracle软件安装完成。