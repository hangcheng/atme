##Nodejs安装
###Windows
>下载mis 安装文件 直接安装
>
>配置环境变量
~~~~
NODE_PATH D:\Program Files\nodejs\node_global\node_modules
Path D:\Program Files\nodejs;D:\Program Files\nodejs\node_global;
~~~~
>需要重启系统 

>测试

~~~
node -v
~~~

###Centos 四种安装方式
>系统的介绍了Node.js这货在CentOS 7上的安装方法，其中涵盖了源码安装，已编译版本安装，EPEL（Extra Packages for Enterprise Linux）安装和通过NVM（Node version manager）安装这四种方法，其中，前两种方法基本上都是Linux通用的安装方式，特别是前者，其优点自然是可以安装最新的版本，至于后两者，因为安装简单且管理方便，非常适合我等新手小盆友使用~


####第一种 源码安装
~~~~~
1、下载源码（官网查看最新版本链接）
	wget http://nodejs.org/dist/v0.10.30/node-v0.10.30.tar.gz

2、解压源码
	tar xzvf node-v* && cd node-v*

3、安装必要的编译软件
	sudo yum install gcc gcc-c++

4、编译
	./configure
	make

5、编译&安装
	sudo make install

6、查看版本（测试安装是否成功）
	node --version
~~~~~

####第二种 使用已编译版本安装
~~~
1、下载已编译版本  最新版本可在官网获得：
	wget http://nodejs.org/dist/v0.10.30/node-v0.10.30-linux-x64.tar.gz

2、解压
	sudo tar --strip-components 1 -xzvf node-v* -C /usr/local

3、测试安装
	node --version
~~~

####第三种 使用EPEL安装
~~~
1、下载EPEL
	sudo rpm -i http://download.fedoraproject.org/pub/epel/beta/7/x86_64/epel-release-7-0.2.noarch.rpm

2、安装
	sudo yum install nodejs

3、老样子，测试安装
	node --version

4、（可选）安装npm管理包
	sudo yum install npm
~~~

####第四种 通过NVM安装
>NVM（Node version manager）顾名思义，就是Node.js的版本管理软件，可以轻松的在Node.js各个版本间切换，项目源码GitHub

~~~
1、下载并安装NVM脚本
	curl https://raw.githubusercontent.com/creationix/nvm/v0.13.1/install.sh | bash
	source ~/.bash_profile

2、列出所需要的版本
	nvm list-remote
	返回结果如下
		. . .
		v0.10.29
		v0.10.30
		 v0.11.0
		 v0.11.1
		 v0.11.2
		 v0.11.3
		 v0.11.4
		 v0.11.5
		 v0.11.6
		 v0.11.7
		 v0.11.8
		 v0.11.9
		v0.11.10
		v0.11.11
		v0.11.12
		v0.11.13

3、安装相应的版本
	nvm install v0.10.30
4、查看已安装的版本
	nvm list
	->  v0.10.30
        system

5、切换版本
	nvm use v0.10.30

6、设置默认版本
	nvm alias default v0.10.30
~~~

##Nodejs 环境配置
>vim /etc/profile

~~~~
	export NODE_HOME=/usr/local/node
	export PATH=$NODE_HOME/bin:$PATH
	export NODE_PATH=$NODE_HOME/lib/node_modules:$PATH
~~~~
>:wq!

>source /etc/profile

##Nodejs express 安装
>-g 全局安装
~~~
npm install express -g
~~~

##Nodejs Bower 安装
>-g 全局安装

~~~
npm install Bower -g
~~~

##注意事项
> centos 防火墙    
> systemctl stop firewalld.service //临时关闭
> systemctl disable firewalld.service  //禁止开机启动