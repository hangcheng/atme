##spring dataSource 配置

###配置c3p0属性
>c3p0.properties

~~~~
# datasource  oracle
#datasource.username=publicapp
#datasource.password=123456
#datasource.driverClassName=oracle.jdbc.driver.OracleDriver
#datasource.url=jdbc:oracle:thin:@127.0.0.1:1521:orcl

# datasource mysql
datasource.username=root
datasource.password=root
datasource.driverClassName=com.mysql.jdbc.Driver
datasource.url=jdbc:mysql://localhost:3306/publicapp?useUnicode=true&characterEncoding=utf-8

#cp30 spring#

#当连接池中的连接耗尽的时候c3p0一次同时获取的连接数。Default: 3
c3p0.acquireIncrement=5
#初始化时获取三个连接，取值应在minPoolSize与maxPoolSize之间。Default: 3
c3p0.initialPoolSize=3
#每60秒检查所有连接池中的空闲连接。Default: 0
c3p0.idleConnectionTestPeriod=60
#连接池中保留的最小连接数。Default: 15
c3p0.minPoolSize=2
#连接池中保留的最大连接数。Default: 15
c3p0.maxPoolSize=50
#JDBC的标准参数，用以控制数据源内加载的PreparedStatements数量。但由于预缓存的statements
# 属于单个connection而不是整个连接池。所以设置这个参数需要考虑到多方面的因素。 
#如果maxStatements与maxStatementsPerConnection均为0，则缓存被关闭。Default: 0
c3p0.maxStatements=0
#c3p0是异步操作的，缓慢的JDBC操作通过帮助进程完成。扩展这些操作可以有效的提升性能  通过多线程实现多个操作同时被执行。Default: 3
c3p0.numHelperThreads=10
#最大空闲时间,60秒内未使用则连接被丢弃。若为0则永不丢弃。Default: 0
c3p0.maxIdleTime=60
#两次连接中间隔时间，单位毫秒。Default: 1000 
c3p0.acquireRetryDelay=1000
#定义在从数据库获取新连接失败后重复尝试的次数。Default: 30
c3p0.acquireRetryAttempts=30
#获取连接失败将会引起所有等待连接池来获取连接的线程抛出异常。但是数据源仍有效  保留，并在下次调用getConnection()的时候继续尝试获取连接。
#如果设为true，那么在尝试  获取连接失败后该数据源将申明已断开并永久关闭。Default: false
c3p0.breakAfterAcquireFailure=false
#如果设为true那么在取得连接的同时将校验连接的有效性。Default: false
c3p0.testConnectionOnCheckout=false
#连接关闭时默认将所有未提交的操作回滚。Default: false
c3p0.autoCommitOnClose=false
#当连接池用完时客户端调用getConnection()后等待获取新连接的时间，超时后将抛出  SQLException,如设为0则无限期等待。单位毫秒。Default: 0
c3p0.checkoutTimeout=100

#[ibatis]
ibatis.maxRequests=3000
ibatis.maxSessions=1500
ibatis.maxTransactions=300
~~~~
###spring datasource 配置
> applicationContext-common.xml

####spring 读取属性文件 
~~~~
<bean id="propertyConfigurer" class="org.springframework.beans.factory.config.PropertyPlaceholderConfigurer">
	<property name="locations">
		<list>
			<!-- 数据库配置信息 -->
			<value>classpath:properties/c3p0.properties</value>
			<!-- 系统配置信息 -->
			<value>classpath:properties/config.properties</value>
		</list>
	</property>
</bean>
~~~~
####cp30数据源配置
~~~~
<bean id="dataSource" class="com.mchange.v2.c3p0.ComboPooledDataSource" destroy-method="close">
	<property name="driverClass">
		<value>${datasource.driverClassName}</value>
	</property>
	<property name="jdbcUrl">
		<value>${datasource.url}</value>
	</property>
	<property name="user">
		<value>${datasource.username}</value>
	</property>
	<property name="password">
		<value>${datasource.password}</value>
	</property>
	<!--初始化时获取的连接数，取值应在minPoolSize与maxPoolSize之间。Default: 3 -->
	<property name="initialPoolSize">
		<value>${c3p0.initialPoolSize}</value>
	</property>
	<!--连接池中保留的最小连接数。-->
	<property name="minPoolSize">
		<value>${c3p0.minPoolSize}</value>
	</property>
	<!--连接池中保留的最大连接数。Default: 15 -->
	<property name="maxPoolSize">
		<value>${c3p0.maxPoolSize}</value>
	</property>
	<!--最大空闲时间,60秒内未使用则连接被丢弃。若为0则永不丢弃。Default: 0 -->
	<property name="maxIdleTime">
		<value>${c3p0.maxIdleTime}</value>
	</property>
	<!--当连接池中的连接耗尽的时候c3p0一次同时获取的连接数。Default: 3 -->
	<property name="acquireIncrement">
		<value>${c3p0.acquireIncrement}</value>
	</property>		
	<!--
			JDBC的标准参数，用以控制数据源内加载的PreparedStatements数量。但由于预缓存的statements
			属于单个connection而不是整个连接池。所以设置这个参数需要考虑到多方面的因素。
			如果maxStatements与maxStatementsPerConnection均为0，则缓存被关闭。Default: 0
		-->
	<property name="maxStatements">
		<value>${c3p0.maxStatements}</value>
	</property>
	<!--每60秒检查所有连接池中的空闲连接。Default: 0 -->
	<property name="idleConnectionTestPeriod">
		<value>${c3p0.idleConnectionTestPeriod}</value>
	</property>
	<!--两次连接中间隔时间，单位毫秒，默认为1000 -->
	<property name="acquireRetryDelay">
		<value>${c3p0.acquireRetryDelay}</value>
	</property>
	<!--定义在从数据库获取新连接失败后重复尝试的次数。Default: 30 -->
	<property name="acquireRetryAttempts">
		<value>${c3p0.acquireRetryAttempts}</value>
	</property>
	<!--
			获取连接失败将会引起所有等待连接池来获取连接的线程抛出异常。但是数据源仍有效
			保留，并在下次调用getConnection()的时候继续尝试获取连接。如果设为true，那么在尝试
			获取连接失败后该数据源将申明已断开并永久关闭。Default: false
		-->
	<property name="breakAfterAcquireFailure">
		<value>${c3p0.breakAfterAcquireFailure}</value>
	</property>
	<!--
			因性能消耗大请只在需要的时候使用它。如果设为true那么在每个connection提交的
			时候都将校验其有效性。建议使用idleConnectionTestPeriod或automaticTestTable
			等方法来提升连接测试的性能。Default: false
		-->
	<property name="testConnectionOnCheckout">
		<value>${c3p0.testConnectionOnCheckout}</value>
	</property>
	<!--
			c3p0是异步操作的，缓慢的JDBC操作通过帮助进程完成。扩展这些操作可以有效的提升性能
			通过多线程实现多个操作同时被执行。Default: 3
		-->
	<property name="numHelperThreads">
		<value>${c3p0.numHelperThreads}</value>
	</property>
</bean>
~~~~