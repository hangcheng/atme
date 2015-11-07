# jdk 安装
##windows 安装jdk
>下载jdk安装包  
>配置环境变量：
~~~
JAVA_HOME  D:\Program Files\Java\jdk1.7.0_79
CLASSPATH  .;%JAVA_HOME%\lib\dt.jar;%JAVA_HOME%\lib\tools.jar
Path       %JAVA_HOME%\bin;%JAVA_HOME%\jre\bin;
~~~

##centos安装jdk
>1. 下载 jdk-7u80-linux-x64.rpm  
2. su 切换到 root 权限
3. rpm -ivh jdk-7u65-linux-x64.rpm，默认安装路径为 /usr/java/jdk1.7.0_65
4. vi /etc/profile
5. 在 profile 最后追加：
~~~
export JAVA_HOME=/usr/java/jdk1.7.0_65
export
CLASSPATH=.:$JAVA_HOME/jre/lib/rt.jar:$JAVA_HOME/lib/dt.jar:$JAVA_HOME/lib/tools.jar
export PATH=$PATH:$JAVA_HOME/bin
~~~
>注意中间的链接符号是冒号不是分号！   
6. source /etc/profile  
7. 安装 update-alternatives  
~~~
update-alternatives --install /usr/bin/java java /usr/java/jdk1.7.0_80/bin/java 60
~~~
>配置 jdk   
~~~
update-alternatives --config java
然后出现
共有 1 个程序提供“ java”。 
选择 命令
-----------------------------------------------
*+ 1 /usr/java/jdk1.7.0_80/bin/java
按 Enter 来保存当前选择[+]，或键入选择号码： 1
回车即可
java -version
输出
java version "1.7.80"
Java(TM) SE Runtime Environment (build 1.7.0-b147)
Java HotSpot(TM) 64-Bit Server VM (build 21.0-b17, mixed mode)

~~~