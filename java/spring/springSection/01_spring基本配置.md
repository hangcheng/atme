##spring JAR简介
>
　　spring.jar是包含有完整发布的单个jar包，spring.jar中包含除了 spring-mock.jar里所包含的内容外其它所有jar包的内容，因为只有在开发环境下才会用到spring-mock.jar来进行辅助测试，正式应用系统中是用不得这些类的。  
>
　　除了spring.jar文件，Spring还包括有其它13个独立的jar包，各自包含着对应的Spring组件，用户可以根据自己的需要来选择组合自己的jar包，而不必引入整个spring.jar的所有类文件。   


**注：spring3开始jar包不再包含全能的spring.jar了，而是分成20多个jar包了，配置可以按需引入了**
###Spring下jar包介绍
#### spring-core.jar
>  
　　这个jar文件包含Spring框架基本的核心工具类，Spring其它组件要都要使用到这个包里的类，是其它组件的基本核心，当然你也可以在自己的应用系统中使用这些工具类。
#### spring-beans.jar
>  
　　这个jar文件是所有应用都要用到的，它包含访问配置文件、创建和管理bean以及进行Inversion of Control / Dependency Injection（IoC/DI）操作相关的所有类。如果应用只需基本的IoC/DI支持，引入spring-core.jar及spring- beans.jar文件就可以了。
#### spring-aop.jar
>  
　　这个jar文件包含在应用中使用Spring的 AOP特性时所需的类。使用基于AOP的Spring特性，如声明型事务管理（Declarative Transaction Management），也要在应用里包含这个jar包。
#### spring-context.jar
>  
　　这个jar文件为Spring核心提供了大量扩展。可以找到使用Spring ApplicationContext特性时所需的全部类，JDNI所需的全部类，UI方面的用来与模板（Templating）引擎如 Velocity、FreeMarker、JasperReports集成的类，以及校验Validation方面的相关类。
#### spring-dao.jar
>  
　　这个jar文件包含Spring DAO、Spring Transaction进行数据访问的所有类。为了使用声明型事务支持，还需在自己的应用里包含spring-aop.jar。
#### spring-hibernate.jar
>　　这个jar文件包含Spring对Hibernate 2及Hibernate 3进行封装的所有类。
#### spring-jdbc.jar
>　　这个jar文件包含对Spring对 JDBC数据访问进行封装的所有类。
#### spring-orm.jar
>  
　　这个jar文件包含Spring对 DAO特性集进行了扩展，使其支持 iBATIS、JDO、OJB、TopLink，因为Hibernate已经独立成包了，现在不包含在这个包里了。这个jar文件里大部分的类都要依赖 spring-dao.jar里的类，用这个包时你需要同时包含spring-dao.jar包。
#### spring-remoting.jar
>  
　　这个jar文件包含支持EJB、JMS、远程调用Remoting（RMI、 Hessian、Burlap、Http Invoker、JAX-RPC）方面的类。
#### spring-support.jar
>  
　　这个jar文件包含支持缓存Cache（ehcache）、JCA、JMX、邮件服务（Java Mail、COS Mail）、任务计划Scheduling（Timer、Quartz）方面的类。
#### spring-web.jar
>  
　　这个jar文件包含Web应用开发时，用到Spring框架时所需的核心类，包括自动载入WebApplicationContext特性的类、 Struts与JSF集成类、文件上传的支持类、Filter类和大量工具辅助类。
#### spring-webmvc.jar
>  
　　这个jar文件包含Spring MVC框架相关的所有类。包含国际化、标签、Theme、视图展现的FreeMarker、JasperReports、Tiles、Velocity、 XSLT相关类。当然，如果你的应用使用了独立的MVC框架，则无需这个JAR文件里的任何类。
#### spring-mock.jar
>  
　　这个jar文件包含Spring一整套mock类来辅助应用的测试。Spring测试套件使用了其中大量mock类，这样测试就更加简单。模拟HttpServletRequest和HttpServletResponse类在Web应用单元测试是很方便的。
#### spring-aspects.jar
>　　Spring提供的对AspectJ框架的整合
#### spring-context-support.jar
>　　Spring context的扩展支持，用于MVC方面
#### Spring-Transaction.jar
>　　为JDBC,HIBERNATE,JDO和JPA提供的一致性的声明式和简单编程式事务管理
#### Spring-expression.jar
>　　Spring表达式语言
#### Spring-tx.jar
>　　为JDBC、Hibernate、JDO、JPA等提供的一致的声明式和编程式事务管理。
#### Spring-jms.jar
>　　为简化jms api的使用而做的简单封装
#### Spring-oxm.jar
>　　pring对于object/xml映射的支持，可以让JAVA与XML之间来回切换
#### Spring-webmvc-portlet.jar
>　　Spring MVC的增强
#### Spring-messaging.jar
>　　集成messaging api和消息协议提供支持
#### Spring-instrument.jar
>　　Spring对服务器的代理接口


##spring dataSource 配置

###配置c3p0属性
>c3p0.properties

~~~~
# datasource  oracle
#datasource.username=oracleuser
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