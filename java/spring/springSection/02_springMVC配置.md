##springMVC 配置
###springMVC  servlet 配置
>applicationContext-springMVC.xml

~~~~
<!-- 告诉springmvc,springmvc相关的bean中使用注解来进行表示 -->
<context:annotation-config />
<!-- 告诉springmvc对指定包进行扫描，并创建其中的javaBean并注入到spring容器中 -->
<context:component-scan base-package="com.web.app.*" />
<!-- 启动springmvc的注解映射功能 -->
<bean class="org.springframework.web.servlet.mvc.annotation.DefaultAnnotationHandlerMapping"
	p:order="1">
</bean>
<!-- 启动Spring JAVA BEAN的注解功能的映射,对标注@Autowired的Bean进行自动注入   -->
<bean class="org.springframework.beans.factory.annotation.AutowiredAnnotationBeanPostProcessor"/>
<!-- 启动Spring MVC的注解功能，完成请求和注解POJO -->
<bean class="org.springframework.web.servlet.mvc.annotation.AnnotationMethodHandlerAdapter">
	<property name="messageConverters">
		<list>
			<ref bean="stringHttpMessageConverter" />
			<ref bean="jsonHttpMessageConverter" />
			<ref bean="marshallingHttpMessageConverter" />
		</list>
	</property>
</bean>

<bean id="stringHttpMessageConverter" class="org.springframework.http.converter.StringHttpMessageConverter" /> 

<bean id="jsonHttpMessageConverter" class="org.springframework.http.converter.json.MappingJacksonHttpMessageConverter" />

<bean id="marshallingHttpMessageConverter" class="org.springframework.http.converter.xml.MarshallingHttpMessageConverter">
	<property name="supportedMediaTypes" value="application/xml"></property>
</bean>

<!-- 容器默认的DefaultServletHandler处理 所有静态内容与无RequestMapping处理的URL-->	
<mvc:default-servlet-handler/>

<!-- 静态资源映射 -->
<mvc:resources mapping="/images/**" location="/images/" cache-period="31536000"/>
<mvc:resources mapping="/css/**" location="/css/" cache-period="31536000"/>
<mvc:resources mapping="/js/jslib/**" location="/js/jslib/" cache-period="31536000"/>

<!-- 定义无需Controller的url<->view直接映射
<mvc:view-controller path="/" view-name="/system/index"/> -->

<!-- Spring国际化 -->  
<bean id="messageSource" class="com.web.app.core.common.context.AppMessage"
	p:cacheSeconds="1">
	<property name="basenames">  
		<list>  
			<value>classpath:properties/message</value>
		</list>  
	</property> 
	<property name="defaultEncoding" value="UTF-8"/>
</bean>

<!-- 使用spring multipartRequest 上传文件-->
<bean id="multipartResolver" class="org.springframework.web.multipart.commons.CommonsMultipartResolver" p:defaultEncoding="utf-8"/>

~~~~

###springMVC template 模板配置
>applicationContext-template.xml

~~~~~
<!--** *配置系统里面可能会用到的模板 *1.freemarker 2.velocity ****-->
<!--<bean id="velocityViewResolver"
	class="org.springframework.web.servlet.view.freemarker.FreeMarkerViewResolver"
	p:suffix=".html" 
	p:prefix="" 
	p:contentType="text/html;charset=utf-8"
	p:exposeRequestAttributes="true" 
	p:exposeSessionAttributes="true">
	<property name="viewClass" value="org.springframework.web.servlet.view.freemarker.FreeMarkerView" />
	<property name="requestContextAttribute" value="req" />
	<property name="exposeSpringMacroHelpers" value="true" />
</bean>-->
<!-- freemarker config -->
<!--<bean id="freeMarkerConfigurer"
		class="org.springframework.web.servlet.view.freemarker.FreeMarkerConfigurer">
		<property name="templateLoaderPath" value="/views/" />
		<property name="freemarkerSettings">
			<props>
				<prop key="template_update_delay">10</prop>
				<prop key="locale">zh_CN</prop>
				<prop key="default_encoding">UTF-8</prop>
				<prop key="datetime_format">yyyy-MM-dd HH:mm:ss</prop>
				<prop key="date_format">yyyy-MM-dd</prop>
				<prop key="number_format">#.##</prop>
			</props>
		</property>
	</bean>-->
<!-- velocity视图解析器 p:toolboxConfigLocation="classpath:velocity/velocity-toolbox.xml" -->
<bean id="velocityViewResolver"
	class="org.springframework.web.servlet.view.velocity.VelocityViewResolver"
	p:suffix=".html" 
	p:prefix="" 
	p:contentType="text/html;charset=utf-8"
	p:dateToolAttribute="dateTool" 
	p:numberToolAttribute="numberTool"
	p:exposeRequestAttributes="true" 
	p:exposeSessionAttributes="true">
	<property name="requestContextAttribute" value="req" />
	<property name="exposeSpringMacroHelpers" value="true" />
</bean>

<!-- Spring+Velocity集成配置 -->
<bean id="velocityConfigurer"
	class="org.springframework.web.servlet.view.velocity.VelocityConfigurer"
	p:resourceLoaderPath="/views/">
	<property name="velocityProperties">
		<props>
			<prop key="contentType">text/html; charset=utf-8</prop>
			<prop key="input.encoding">utf-8</prop>
			<prop key="output.encoding">utf-8</prop>
		</props>
	</property>
</bean>
~~~~~

