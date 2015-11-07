##maven 命令
###基本命令
~~~~
mvn archetype:create -DgroupId=com.oreilly -DartifactId=my-app   创建mvn项目

mvn -version/-v        		显示版本信息
mvn archetype:generate 		使用Archetype生成项目骨架 即创建maven项目
mvn help:system 			自动在本用户下创建   ~/.m2/repository
mvn install					在本地Repository中安装jar

mvn eclipse:eclipse         将项目转化为 Eclipse 项目
mvn idea:idea				将项目转化为 Idea 项目

mvn eclipse:clean           清除Eclipse项目的配置信息(Web项目)
mvn package  				生成target目录，编译、测试代码，生成测试报告，生成jar/war文件
mvn jar:jar 				只打jar包
mvn compile              	编译
mvn test                 	编译并测试
mvn site                 	生成项目相关信息的网站

mvn jetty:run            	运行项目于 jetty  上
mvn tomcat:run				运行项目于 Tomcat 上

mvn clean                	清空生成的文件
mvn clean compile     		清理编译
mvn clean test  			清理测试
mvn clean package 			清理打包
mvn clean install  			清理将打包好的jar存入 本地仓库  注意是本地仓库
mvn clean deploy  			根据pom中的配置信息将项目发布到远程仓库中 
~~~~