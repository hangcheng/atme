##mybatis自动生成配置
###配置 generatorConfig.xml
~~~~
<?xml version="1.0" encoding="UTF-8" ?>
<!DOCTYPE generatorConfiguration PUBLIC "-//mybatis.org//DTD MyBatis Generator Configuration 1.0//EN" "http://mybatis.org/dtd/mybatis-generator-config_1_0.dtd" >
<generatorConfiguration>
	<classPathEntry location="E:\mysql-connector-java-5.1.34.jar" />
	<context id="context1" targetRuntime="MyBatis3">
		<commentGenerator>
			<!-- suppressAllComments false时打开注释，true时关闭注释   (关闭注释时xml内容会重复生成 而不是覆盖 如果生成一次可关闭否则打开)      suppressDate false时打开时间标志，true时关闭 -->
			<property name="suppressAllComments" value="true" />
			<!-- 关闭时间注释 -->
    		<property name="suppressDate" value="true"/>
		</commentGenerator>
		<jdbcConnection driverClass="com.mysql.jdbc.Driver" connectionURL="jdbc:mysql://localhost:3306/csl_db?useUnicode=true&amp;characterEncoding=UTF-8" userId="root" password="root" />
		<!-- 实体类生成配置 -->
		<javaModelGenerator targetPackage="com.csl.app.domain" targetProject="src/main/java">
			<property name="enableSubPackages" value="true" />
			<property name="trimStrings" value="false" />
		</javaModelGenerator>
		<!-- 生成sql语句的xml文件 -->
		<sqlMapGenerator targetPackage="mybatis" targetProject="src/main/resources">
			<property name="enableSubPackages" value="false" />
		</sqlMapGenerator>
		<!-- Mapper生成配置 type XMLMAPPER配置文件方式，ANNOTATEDMAPPER注解方式 -->
		<javaClientGenerator targetPackage="com.csl.app.persist" targetProject="src/main/java" type="XMLMAPPER">
			<property name="enableSubPackages" value="true" />
		</javaClientGenerator>
		<!-- mybatis里专门用来处理NUMERIC和DECIMAL类型的策略 -->
		<!-- <javaTypeResolver>
			<property name="forceBigDecimals" value="true" />
		</javaTypeResolver> -->
		<table tableName="user_info">
			<generatedKey column="ID" sqlStatement="mysql" identity="true" />
		<!-- 	忽略字段
			<generatedKey column="ID" sqlStatement="DB2" identity="true" /> <ignoreColumn column="FRED" /> -->
		</table>
		<table  tableName="offer_info" >
			<generatedKey column="ID" sqlStatement="mysql" identity="true" />
		</table>
		<table  tableName="key_word" >
			<generatedKey column="ID" sqlStatement="mysql" identity="true" />
		</table>
		<table  tableName="customer_info" >
			<!-- <generatedKey column="ID" sqlStatement="mysql" identity="true" /> -->
		</table>
	</context>
</generatorConfiguration>
~~~~
>mvn mybatis-generator:generate

