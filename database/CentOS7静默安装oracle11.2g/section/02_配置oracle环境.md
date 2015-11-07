##配置 oracle 环境
###检查安装依赖环境
>检查依赖

~~~
rpm -q binutils  compat-libstdc++-33 compat-libstdc++-33.i686  elfutils-libelf elfutils-libelf-devel expat gcc gcc-c++ glibc glibc.i686 glibc-common glibc-devel glibc-headers libaio libaio.i686 libaio-devel libaio-devel.i686 libgcc libgcc.i686 libstdc++ libstdc++.i686 libstdc++-devel make numactl pdksh sysstat unixODBC unixODBC.i686 unixODBC-devel | grep 'not installed'
~~~
>安装oracle必须要的包,oracle 依赖环境 必须安装

~~~~
yum -y install binutils compat-libcap1 compat-libstdc++-33 compat-libstdc++-33*.i686 elfutilslibelf-devel gcc gcc-c++ glibc*.i686 glibc glibc-devel glibc-devel*.i686 ksh libgcc*.i686 libgcc libstdc++ libstdc++*.i686 libstdc++-devel libstdc++-devel*.i686 libaio libaio*.i686 libaio-devel libaio-devel*.i686 make sysstat unixODBC unixODBC*.i686 unixODBC-devel unixODBCdevel*.i686 libXp glibc-static.x86_64 glibc-static.i686
~~~~
###安装基本常用工具
>常用工具

~~~
yum install unzip zip
~~~


###建立用户、组、安装目录

####建立用户和组

~~~
groupadd oinstall
groupadd dba
groupadd oper
useradd -g oinstall -G dba,oper oracle
echo "oracle" | passwd --stdin oracle
注意：(前面”oracle”是密码，后面指定 oracle 用户 )
~~~
>查看一下

~~~
id oracle
结果：uid=1000(oracle) gid=1000(oinstall) 组=1000(oinstall),1001(dba),1002(oper)
~~~
####建立安装目录

~~~
mkdir -p /prust/app/oracle/product/11.2.0/db_1
chown -R oracle:oinstall /prust/app
chmod -R 775 / prust/app
~~~

###修改参数
####内核参数

~~~
vim /etc/sysctl.conf
fs.aio-max-nr = 1048576
fs.file-max = 6815744
kernel.shmall = 2097152
kernel.shmmax = 1200000000
kernel.shmmni = 4096
kernel.sem = 250 32000 100 128
net.ipv4.ip_local_port_range = 9000 65500
net.core.rmem_default = 262144
net.core.rmem_max = 4194304
net.core.wmem_default = 262144
net.core.wmem_max = 1048576
~~~
>改好后，使之生效

    sysctl -p

####改文件限制

~~~
vim /etc/security/limits.conf
oracle soft nproc 2047
oracle hard nproc 16384
oracle soft nofile 1024
oracle hard nofile 65536
oracle soft stack 10240
~~~
>注意：修改此文件是即时生效的，但可能要重登录后再看

~~~
vim /etc/pam.d/login
#session required /lib/security/pam_limits.so
session required pam_limits.so
~~~

####修改 ulimit

~~~
vim /etc/profile
if [ $USER = "oracle" ]; then
if [ $SHELL = "/bin/ksh" ]; then
	ulimit -p 16384
	ulimit -n 65536
else
	ulimit -u 16384 -n 65536
fi
fi
~~~
####修改 oracle 用户环境变量

~~~
vim ~oracle/.bash_profile
ORACLE_BASE=/prust/app/oracle
ORACLE_HOME=$ORACLE_BASE/product/11.2.0/db_1
ORACLE_SID=orcl
export ORACLE_BASE ORACLE_HOME ORACLE_SID
PATH=.:$ORACLE_HOME/bin:$ORACLE_HOME/OPatch:$ORACLE_HOME/jdk/bin:PATH
export PATH
export LC_ALL="en_US"
export LANG="en_US"
export NLS_LANG="AMERICAN_AMERICA.ZHS16GBK"
export NLS_DATE_FORMAT="YYYY-MM-DD HH24:MI:SS"
~~~
>注意：
（这个地方 ORACLE_SID 需要和之后安装界面的 Global database name 保持一致，也是
ORCL）
