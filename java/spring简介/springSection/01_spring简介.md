##认识spring
>Spring的核心是轻量级(Lightweigt)的容器，它是实现IOC(Inversion of Control)容器和非侵入式(No intrusive)的框架，它提供AOP(Aspect-orientedprogramming)概念的实现方式；提供对持久层(Persistence)，事务(Transaction)的支持，提供MVC WEB框架的实现，并对一些常用的企业级API提供一致的模型封装，是一个全方面的应用程序框架，除此之外，对于现存的各种框架(Struts,Hibernate等)，Spring也提供了与它们相整合的方案。也就是说它不仅仅专注于某一层的解决方案，可以说Spring是企业级应用开发的“一站式”选择，Spring贯穿表现层，业务层，持久层，Spring并不是想取代这些已有的框架，而是对它们进行无缝整合。

###术语介绍
>Spring的目标之一，是作为一个全方位的应用程序框架，由于各个应用在各个领悟中的应用越来越复杂，因此这里牵涉到专业术语比较多，下面逐个介绍一下。

####轻量级(Lightweight)
>轻量级是相对于一些重量级的容器(EJB)来说的，Spring的核心包不是很大，大概那么2,3M,使用Spring的核心功能需要的资源也不是很大。  
>另一方面说spring框架在系统初始化的时候不用加载所有的服务，为系统节约了资源！而EJB框架就是重量级的，每次初始化都必须加载所有的服务！   
>此外，所谓Spring是轻量级是相对的，当Spring所以的服务都开启的情况下Spring也是重量级的框架。

####容器(Container)
>容器可以管理对象的生成，资源取得，销毁等生命周期，甚至建立对象与对象之间的依赖关系，Spring提供容器功能，您可以使用一个配置文件（通常是XML）在当中确定对象名称，确定如何产生对象，哪个对象产生之后必须设定成为某个对象的属性等。在启动容器之后，所有的对象都可以直接取用，不用编写任何一行程序代码产生对象，或者建立对象与对象直接的依赖。

####Inversion of Control与Dependency Injection
>Spring最重要的核心概念是Inversionof Control，中文翻译“控制反转”，简称IOC。在Spring中，“依赖关系的转移”，“依赖于抽象而非实现”是重要的概念，从对象角度来说，可以避免对象之间的耦合；从容器的角度来说，可以避免应用程序依赖于容器的功能，而从容器脱离。

>Spring另一个重要核心概念为DependencyInjection，中文翻译“依赖注入”简称DI，使用Spring，不必自己在程序代码中对象的依赖关系。只需要在配置文件中加以配置，Spring核心容器会自动根据配置，将依赖注入到指定的对象。

#### AOP(Aspect-oriented programming)
>Spring最被人重视的功能之一是支持AOP的实现，然而AOP框架只是Spring支持的一个子框架，说Spring框架式AOP框架并不是一个适当的描述。

>举例来说AOP的应用，假设在应用程序有个日志的需求，就可以爱无须修改任何代码的情况下，就将这个需求加入到原先的应用程序中，而若您愿意，可以在不修改任何代码的情况下，讲日志功能移除。

####持久层
>Spring提供对持久层的整合，如对JDBC的使用加以封装与简化，提供编程式事务，与声明是事务管理功能。对应OR Mapping工具(Hibernate, MyBatis)的整合以及使用上的简化，Spring与提供了对应的解决方案。

####其它企业服务的封装
>对于一些服务，例如JNDI， Mail， 任务计划，远程等，Spring不直接提供实现，而是采取抽象方式对这些服务进行封装，让这些服务有一致的使用模型。

###spring环境搭建
>针对一般的java工程。
>到http://www.springsource.org/download下载spring，然后进行解压缩。

 

拷贝到classpath下：
~~~
dist\spring.jar

lib\jakarta-commons\commons-logging.jar
~~~
 

如果使用AOP,还需要下列jar文件
~~~
lib/aspectj/aspectjweaver.jar和aspectjrt.jar

lib/cglib/cglib-nodep-2.1_3.jar
~~~
 

如果使用的注解需要下面的jar 包
~~~
lib\j2ee\common-annotations.jar
~~~
 

##控制反转
>Spring的核心概念是IOC，IOC的抽象概念是“依赖关系的转移”。转移是相对于过去不良的应用程序设计来说的，像“高层模块不应该依赖底层的模块，而模块都必须依赖于抽象，”对IOC来说“实现必须依赖抽象，而不抽象依赖实现”或者说“应用程序不依赖于容器，而是容器服务于应用程序”。

**IOC原理实例  **

>应用程序在需要存储时候直接运行保存到软盘的话，导致高层应用程序依赖于底层的API，假设今天需要将应用程序移植到另一个平台上，如果该平台使用USB磁盘作为存储介质的话，则这个应用程序无法直接重用，必须加以修改才行。在这个例子中，由于底层模块介质的变化，造成搞错模块与必须跟着变化，这不是一个良好的设计方案，在设计上希望模块都依赖于模块的抽象，这样才可以重用高层的应用程序。

 

设计Business类，它不依赖于任何实现类，而是抽象。
~~~~
public class Business {

private IDeviceWriter writer;

public void setWriter(IDeviceWriter writer) {

    this.writer = writer;

}

public void save() {

    writer.saveToDevice();

}

}
~~~~
 

针对USB存储的实现。
~~~
public class UsbDiskWriter implements IDeviceWriter {

    public void saveToDevice() {

        System.out.println("usb disk wirter......");

    }

}
~~~
 

针对DVD存储的实现。
~~~
public class DvdDiskWriter implements IDeviceWriter {

    public void saveToDevice() {

        System.out.println("dvd disk wirter......");

    }

}
~~~
 

具体业务实现类，无论底层的存储实现如何变化，对于Business类来说都无须做任何修改。
~~~
public class Business {

    private IDeviceWriter writer;

    public void setWriter(IDeviceWriter writer) {

        this.writer = writer;

    }

    public void save() {

        writer.saveToDevice();

    }

}
~~~
 

编写一个配置管理程序，通过简单的XML或者properties文件来更改配置，如此，连上面的配置程序都不必编写。
~~~
public class BusinessFactory {

    private static BusinessFactory factory;

    private Business business;

    private IDeviceWriter writer;

    private Properties props;

 

    private BusinessFactory() throws Exception {

        props = new Properties();

        props.load(new FileInputStream("config.properties"));

        String businessClass = props.getProperty("business.class");

        String writerClass = props.getProperty("writer.class");

    business = (Business) Class.forName(businessClass).newInstance();

    writer = (IDeviceWriter) Class.forName(writerClass).newInstance();

        business.setWriter(writer);

    }

    public static BusinessFactory getInstance() throws Exception {

        if (factory == null) {

            factory = new BusinessFactory();

        }

        return factory;

    }

    public Business getBusiness() {

        return business;

    }

    public IDeviceWriter getWriter() {

        return writer;

    }

}
~~~
 

config.properties
~~~
business.class=com.spring2.ioc.Business

writer.class=com.spring2.ioc.UsbDiskWriter
~~~ 

通过BusinessFactory获得Business实例，并执行save()方法。
~~~
public class Main {

    public static void main(String[] args) {

        Business business;

        try {

            business = BusinessFactory.getInstance().getBusiness();

            business.save();

        } catch (Exception e) {

            e.printStackTrace();

        }

    }

}
~~~
**IOC实例分析**

>以上的实例来看，DependencyInversion的意思是“程序不依赖于实现，程序与实现都要依赖于抽象。”

>IOC中的Control是控制意思，其实背后的意义是一种依赖关系的转移，如果A依赖于B，其意思是B拥有控制权，如果转移这种关系（依赖关系的反转即控制关系的反转）将控制权由实现的一方转移到抽象的一方，让抽象拥有控制权，可以获得组件的可重用性。在上面的Business程序中，整个控制权由实现类转移到IDeviceWriter接口，让Business依赖这个接口，关键在于我们的两个实现类都依赖于IDeviceWriter。

>IOC的要求是容器不应该（或劲量不要）侵入应用程序，也就是不应该出现于容器相依赖的API，应用程序本身可以依赖于抽象的接口，容器可以通过这些抽象接口讲所需的资源注入值应用程序。应用程序不向容器要求资源，故而不会依赖于容器特定的API，应用程序本身不会意识到正被容器使用，故而可以随时从容器系统中脱离，转移到其它的容器或者框架而不需要作任何的修改。

###Bean的管理
>org.springframework.beans包，与org.springframework.context包是Spring IOC容器的基础。BeanFactory负责Bean的配置，管理Bean的加载，生成，维护，以及Bean对象之间的依赖关系，总的来说它负责Bean的生命周期，ApplicationContext是BeanFactory的扩展，功能得到进一步的增强，比如：更方便与AOP的集成，资源处理，事件传递，支持国际化，以及不同应用层的Context实现（针对web应用的WebApplicationContext）。

>总体来说，BeanFactory提供了基本功能，而ApplicationContext则增强了更多对企业级的功能，ApplicationContext完全由BeanFactory扩展而来，因此BeanFactory所具备的能力和行为也适用于ApplicationContext。Spring的创建者Rod Johnson也建议使用ApplicationContext。

 

Spring 配置文件

~~~
<?xml version="1.0" encoding="UTF-8"?>

<beans xmlns="http://www.springframework.org/schema/beans"

xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"

xsi:schemaLocation="http://www.springframework.org/schema/beans http://www.springframework.org/schema/beans/spring-beans-2.5.xsd">

</beans>
~~~
 

####BeanFactory
>org.springframework.beans.factory.BeanFactory负责Bean的加载，生成，维护Bean与Bean之间的依赖关系，它负责Bean的整个生命周期，BeanFactory有下面五个方法可以调用。

方法|说明
-----|------
boolean containsBean(String name)|是否包含名为name的bean
Object getBean(String name) |按照指定的name获取Bean的实例
Object getBean(String name, Class)|按照指定的name获取Bean的实例，并转化成Class类型。 
Class getType(String name)|按照指定name，获取改bean的类型。
boolean isSingleton(String name)|判断指定的bean是否为单列模式。

##### 实例
~~~
import org.springframework.beans.factory.BeanFactory;

import org.springframework.beans.factory.xml.XmlBeanFactory;

import org.springframework.core.io.ClassPathResource;

import org.springframework.core.io.Resource;

import com.spring2.ioc.DvdDiskWriter;

public class TestBeanFactory {

    public static void main(String[] args) {

    Resource resouce = new ClassPathResource("applicationContext.xml");

        BeanFactory factory = new XmlBeanFactory(resouce);

        DvdDiskWriter dvd = (DvdDiskWriter) factory.getBean("dvd");

        dvd.saveToDevice();

    }

}
~~~
 

>Spring 开发团队在设计Spring时，考虑到一些受限资源的应用场合，如移动设备，故特意将BeanFactory 容器尽可能地精简，以减少资源的消耗。但对于那些需要国际化支持、Bean 事件发布与监听的应用来讲，BeanFactory 显然有点力不从心了。于是通过继承BeanFactory 接口，又创建了ApplicationContext 和其它子接口，用以满足Java EE 应用的开发。

#### ApplicationContext
>ApplicationContext是BeanFactory的扩展，功能得到进一步的增强，比如：更方便与AOP的集成，资源处理，事件传递，支持国际化，以及不同应用层的Context实现。

org.springframework.context.ApplicationContext有下面三个最常用的实现类：
~~~
org.springframework.context.support.FileSystemXmlApplicationContext
org.springframework.context.support.ClassPathXmlApplicationContext
org.springframework.web.context.support.XmlWebApplicationContext
~~~

在实际情况中ClassPathXmlApplicationContext用的最多，所以这里我们就以ClassPathXmlApplicationContext为例，来实体它来实例化bean对象，看能否调用。

~~~
import org.springframework.context.ApplicationContext;

import org.springframework.context.support.ClassPathXmlApplicationContext;

public class TestApplicationContext {

    public static void main(String[] args) {

        ApplicationContext context = new ClassPathXmlApplicationContext("applicationContext.xml");

        HelloBean hello = (HelloBean) context.getBean("hello");

        hello.hello();

    }

}
~~~
 

FileSystemXmlApplicationContext实例
~~~
ApplicationContextctx= new FileSystemXmlApplicationContext(newString[]{“d:\\beans.xml“});
~~~
 

##### 使用数组引入多个配置文件
>ApplicationContext可以读取多个配置文件，它可以使用如下方式读取多个配置文件。

~~~
ApplicationContext context1 = new ClassPathXmlApplicationContext(new String[] { "bean1.xml", "bean2.xml" });

HelloBean hello1 = (HelloBean) context1.getBean("hello1");

HelloBean hello2 = (HelloBean) context1.getBean("hello2");

hello1.hello();

hello2.hello();
~~~
 

#####使用*通配符引入多个配置文件
>也可以使用*这种通配符来读取配置文件。

 
~~~
ApplicationContext context2 = new ClassPathXmlApplicationContext(new String[] { "bean*.xml" });

HelloBean hello1 = (HelloBean) context2.getBean("hello1");

HelloBean hello2 = (HelloBean) context2.getBean("hello2");

hello1.hello();

hello2.hello();
~~~
##### 使用<import>引入多个配置文件
>在struts中，我们可以使用<import>标签来引入多个struts2的配置文件，spring也一样，我们可以将各个模块的bean定义放置在不同的spring配置文件中。

~~~
<?xml version="1.0" encoding="UTF-8"?>

<beans xmlns="http://www.springframework.org/schema/beans"

    xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"

    xsi:schemaLocation="http://www.springframework.org/schema/beans http://www.springframework.org/schema/beans/spring-beans-2.5.xsd">

    <import resource="bean1.xml" />

    <import resource="bean2.xml" />

</beans>

ApplicationContext context3 = new ClassPathXmlApplicationContext(new String[] { "applicationContext.xml" });

HelloBean hello1 = (HelloBean) context3.getBean("hello1");

HelloBean hello2 = (HelloBean) context3.getBean("hello2");

hello1.hello();

hello2.hello();
~~~
 

注意：使用<import>的时候，<import>标签必须放在<bean>标签之前，配置文件必须在同一个目录下，或者classpath下。

##### WEB工程对spring配置文件的引用
>以上不针对WEB工程，如果是WEB工程的话

~~~
<!-- 指定SPRING的配置文件 -->

<context-param>

    <param-name>contextConfigLocation</param-name>

    <param-value>classpath:beans.xml</param-value>

</context-param>

<context-param>

<param-name>contextConfigLocation</param-name>

<param-value>/WEB-INF/applicationContext.xml</param-value>

</context-param>

<!-- 配置spring整合STRUTS2的监听器 -->

<listener>

    <listener-class>

        org.springframework.web.context.ContextLoaderListener

    </listener-class>

</listener>
~~~
 

####bean的别名
>有时候bean的别名很有用，比如让应用的每个组件更好的对公共组件进行引用。

~~~
<bean id="hello" class="com.spring2.beans.HelloBean" />

<alias name="hello" alias="helloAlias" />

ApplicationContext context = new ClassPathXmlApplicationContext("applicationContext.xml");

HelloBean hello = (HelloBean) context.getBean("helloAlias");

hello.hello();
~~~
 

####bean的实例化
>在Spring中实例化bean有三种方式，分别是：构造方法实例化，静态工厂方法实例化，实例工厂方法实例化。虽然有3种方式但是构造方法实例化的是使用“最多最多”的。

>默认情况下，spring使用的是构造方法实例化bean，也就是调用默认的无参构造方法来实例化bean对象。

#####构造方法实例化
>使用这种方式来实例化bean，spring对class没有特殊的要求，只要求提供“无参构造方法”。

~~~
<bean id="dvd" class="com.spring2.ioc.DvdDiskWriter" />

<bean id="usb" class="com.spring2.ioc.UsbDiskWriter" />

<bean id="hello" class="com.spring2.beans.HelloBean" />
~~~
#####静态工厂方法实例化
>这个要求在要实例化bean的class提供一个静态的方法，下面的实例是newInstance()。

######要实例化bean
~~~
public class StaticFactoryMethodBean {

    public void method1() {

        System.out.println("method1()......");

    }

    public static StaticFactoryMethodBean newInstance() {

       return new StaticFactoryMethodBean();

    }

}
~~~
 
######配置文件
~~~
<bean id="sfmb" class="com.spring2.beans.StaticFactoryMethodBean"

factory-method="newInstance" />
~~~
 
######测试代码
~~~
ApplicationContext context = new ClassPathXmlApplicationContext("applicationContext.xml");

StaticFactoryMethodBean sfmb = (StaticFactoryMethodBean) context.getBean("sfmb");

        sfmb.method1();
~~~
#####实例工厂方法实例化（不讲）
######要实例化的bean
~~~
public class MyBean {

    public void method() {

        System.out.println("method()......");

    }

}
~~~
 

######Bean工厂
~~~
public class MyBeanFactory {

    public MyBean newInstance() {

        return new MyBean();

    }

}
~~~
 
######配置文件
~~~
<bean id="beanFactory" class="com.spring2.beans.MyBeanFactory" />

<bean id="myBean" class="com.spring2.beans.MyBean" factory-bean="beanFactory"factory-method="newInstance" />
~~~
 
######测试代码
~~~
ApplicationContext context = new ClassPathXmlApplicationContext("applicationContext.xml");

MyBean bean = (MyBean) context.getBean("myBean");

bean.method();
~~~
####bean的scope
>在spring中，从BeanFactory与ApplicationContext中获取的bean实例默认为singleton，也就是默认每一个bean只维持一个实例。即使我们多次运行getBean()获取的也是同一个bean实例。

>这种情况在单线程的时候不会有问题，但是如果是多线程的时候，必须考虑线程安全，防止多个线程同时存取共有资源，这时候可以设置scope=”prototype”使得每个获取bean的时候都产生一个新的实例。

 
~~~
<beanid="beanScope"class="com.spring2.beans.BeanScope"scope="singleton" />

<bean id="beanScope" class="com.spring2.beans.BeanScope"scope="prototype" />


BeanScope beanScope1 = (BeanScope) context.getBean("beanScope");

BeanScope beanScope2 = (BeanScope) context.getBean("beanScope");

System.out.println(beanScope1 == beanScope2);
~~~
 

>通过配置scope属性配置为singleton的时候上面打印的是true，prototype的时候是false。

>以下的3种scope都使用的较少，类似于J2EE里面的request和session。在使用SpringMVC是可能会用到。

**request**
>表示该针对每一次HTTP请求都会产生一个新的bean，同时该bean仅在当前HTTP request内有效

**session**
>表示该针对每一次HTTP请求都会产生一个新的bean，同时该bean仅在当前HTTP session内有效

**globalSession**
>不过它仅仅在基于portlet的web应用中才有意义。Portlet规范定义了全局Session的概念，它被所有构成某个portletweb应用的各种不同的portlet所共享。

 

####bean的生命周期
#####bean的生命周期详解
![](springSection/03.jpg)
1.  使用默认构造方法或指定构造参数进行Bean实例化。

2.  根据property 标签的配置调用Bean实例中的相关set 方法完成属性的赋值。

3.  如果Bean 实现了BeanNameAware接口，则调用setBeanName()方法传入当前Bean的ID。

4.  如果Bean 实现了BeanFactoryAware接口，则调用setBeanFactory()方法传入当前工厂实例的引用。

5.  如果Bean 实现了ApplicationContextAware接口，则调用setApplicationContext()方法传入当前ApplicationContext 实例的引用。

6.  如果有BeanPostProcessor 与当前Bean 关联，则与之关联的对象的postProcessBeforeInitialzation()方法将被调用。

7.  如果在配置文件中配置Bean 时设置了init-method属性，则调用该属性指定的初始化方法。

8.  如果有BeanPostProcessor 与当前Bean 关联，则与之关联的对象的postProcessAfterInitialzation()方法将被调用。

9.  Bean 实例化完成，处于待用状态，可以被正常使用了。

10.  当Spring 容器关闭时，如果Bean 实现了DisposableBean 接口，则destroy()方法将被调用。

11.  如果在配置文件中配置Bean时设置了destroy-method 属性，则调用该属性指定的方法进行销毁前的一些处理。

12.  Bean 实例被正常销毁。

~~~
package com.ioc;

import org.springframework.beans.BeansException;

import org.springframework.beans.factory.BeanFactory;

import org.springframework.beans.factory.BeanFactoryAware;

import org.springframework.beans.factory.BeanNameAware;

import org.springframework.beans.factory.DisposableBean;

import org.springframework.context.ApplicationContext;

import org.springframework.context.ApplicationContextAware;

 

public class BeanLife implements BeanNameAware, BeanFactoryAware, ApplicationContextAware,

        DisposableBean {

    @Override

    public void setBeanName(String beanName) {

        System.out.println("beanName=" + beanName);

    }

    @Override

    public void setBeanFactory(BeanFactory bf) throws BeansException {

        System.out.println("setBeanFactory()......");

    }

    @Override

    public void setApplicationContext(ApplicationContext ac) throws BeansException {

        System.out.println("setApplicationContext()......");

    }

    @Override

    public void destroy() throws Exception {

        System.out.println("destroy()......");

    }

    public void initBean() {

        System.out.println("initBean()......");

    }

    public void destroyBean() {

        System.out.println("destroyBean()......");

    }

    public void test() {

        System.out.println("test().............");

    }

}

 

package com.ioc;

 

import org.springframework.beans.BeansException;

import org.springframework.beans.factory.config.BeanPostProcessor;

/**

 * BeanPostProcessor用于对Bean的修正

 */

public class MyBeanPostProcessor implements BeanPostProcessor {

    @Override

    public Object postProcessBeforeInitialization(Object bean, String beanName) throws BeansException {

        System.out.println("postProcessBeforeInitialization(" + beanName + ")...... ");

        return bean;

    }

    @Override

    public Object postProcessAfterInitialization(Object bean, String beanName) throws BeansException {

        System.out.println("postProcessAfterInitialization(" + beanName + ")...... ");

        return bean;

    }

}

 

<bean id="mbpp" class="com.ioc.MyBeanPostProcessor" />

<bean id="beanLife" class="com.ioc.BeanLife" init-method="initBean"

        destroy-method="destroyBean" />

 

private AbstractApplicationContext context;

    @Before

    public void init() {

        context = new ClassPathXmlApplicationContext("beans.xml");

    }

    @Test

    public void test() {

        BeanLife beanLife = (BeanLife) context.getBean("beanLife");

        beanLife.test();

    }

    @After

    public void destroy() {

        context.close();

    }
~~~
 

##### bean生命周期简单讲解
>spring容器会管理bean的生命周期，这时候就有个问题，bean是什么时候被实例化的，到底是spring容器初始化的时候，还是getBean()的时候被初始化。


~~~
public class BeanLife {

    public BeanLife() {

        System.out.println("BeanLife()......");

    }

}

 

<bean id="beanLife" class="com.spring2.beans.BeanLife" scope="singleton" />

 

ApplicationContext context = new ClassPathXmlApplicationContext("applicationContext.xml");

System.out.println("************************************");

BeanLife beanLife = (BeanLife) context.getBean("beanLife");
~~~
 

>从上面的测试代码发现，如果是singleton的时候，bean是在容器初始化的时候被实例化的，但是如果是prototype的时候是在getBean()的时候被实例化，这个应该比较好理解。

>如果想让singleton类型的时候，也和prototype一样，在getBean()的时候被实例化的时候考虑下面的配置。

 
~~~
<bean id="beanLife" class="com.spring2.beans.BeanLife" scope="singleton" lazy-init="true" />
~~~
>也就是使用lazy-init="true"属性来设置，延迟初始化bean。如果要把所有的bean设置延迟初始化的时候考虑这种配置。


~~~
<beans default-lazy-init="false">
~~~
 
>如果bean要进行一些初始化的时候，可以设置init-method属性，来设置bean初始化的时候调用的方法。


~~~
<bean id="beanLife" class="com.spring2.beans.BeanLife"init-method="init" />
~~~
 
>如此同时，如果要销毁对象的话，也会有一个属性destroy-method，在spring容器销毁的时候会回调这个方法。

 
~~~
<bean id="beanLife" class="com.spring2.beans.BeanLife"

init-method="init"destroy-method="destory" />
~~~

>要测试的话使用以前的ApplicationContext是无法测试的，得用另一个类org.springframework.context.support.AbstractApplicationContext，这个类里面有一个close()方法，表示正常关闭spring容器。


~~~
AbstractApplicationContext context = new ClassPathXmlApplicationContext("applicationContext.xml");

System.out.println("************************************");

BeanLife beanLife = (BeanLife) context.getBean("beanLife");

context.close();
~~~
 

####bean的继承
如果bean的定义文件的内容不断的增长，这个时候也许会发现bean的定义有重复，且这些值都有相同的值，只有其中几个的值不同，这时候可以考虑继承bean。

##### bean的定义
~~~
public class SomeBean {

    private String name;

    private int age;

    getter(), setter()……

}
~~~
 

#####配置文件
>abstract="true"表明这个bean是抽象bean，spring不会去实例化它，在someBean中设置了parent="parentBean"，表示它将继承parentBean，在someBean中重新设置name属性的值。


~~~
<bean id="parentBean"abstract="true">

    <property name="name">

        <value>test</value>

    </property>

    <property name="age">

        <value>21</value>

    </property>

</bean>

<bean id="someBean" class="com.spring2.beans.SomeBean"parent="parentBean">

    <property name="name">

        <value>sinoyang</value>

    </property>

</bean>
~~~
 

#####测试代码
~~~
SomeBean someBean = (SomeBean) context.getBean("someBean");

System.out.println("name=" + someBean.getName() + ", age=" + someBean.getAge());
~~~
 

####bean的依赖设置
>在spring中两种基本的依赖注入方式是Setter Injection及Constructor Injection另外针对非singleton的依赖注入，还提供Method Injection，也就是Type 1 Ioc, Type 2 Ioc, Type 3 Ioc。

#####构造方法注入
>第三种Ioc就是我们所说的Constructor Injection（构造方法注入）
>在定义bean的时候，可以定义一个无参的构造方法。
>使用<constructor-arg>来指定参数，通过这个标签的index属性来设置参数的位置。

######实例

>下面的实例中，构造方法有两个参数一个String一个是StudentDao，通过这个实例来探讨。

测试bean

~~~
public class StudentServiceImpl implements StudentService {

    private StudentDao studentDao;

    private String name;

    public StudentServiceImpl(StudentDao studentDao, String name) {

        this.studentDao = studentDao;

        this.name = name;

    }

    public void saveStudent() {

        studentDao.saveStudent();

        System.out.println("name=" + name);

    }

}
~~~
 

配置文件
~~~
<!-- 使用构造方法注入 -->

<beanid="studentService" class="com.spring2.service.impl.StudentServiceImpl">

    <constructor-arg index="0" type="com.spring2.dao.StudentDao"

            ref="studentDao" />

    <constructor-arg index="1" value="test" />

</bean>
~~~
 

#####setter注入
>使用setter方法来进行注入，这种方式用的最多。考虑下面的需求，Service层，与Dao层，以前的设计中，总是在Service中实例化Dao的实例，然后在调用Dao的方法，这种情况就造成了Service对Dao的依赖，没有解耦，如果Dao的实现发生了变化，如果由Jdbc的实现，变成了Hibernate，或者Mybatis这些ORM框架是来实现，我们Service层的代码会大改，这从设计层面上来说是不行的。

>解决方案：Service层不在依赖于Dao的实现类，也是依赖于抽象，具体的实现类有Spring 来注入。

#####注入实例

Service层
~~~
public interface StudentService {

    public void saveStudent();

}

 

public class StudentServiceImpl implements StudentService {

    private StudentDao studentDao;

    public void setStudentDao(StudentDao studentDao) {

        this.studentDao = studentDao;

    }

    public void saveStudent() {

        studentDao.saveStudent();

    }

}
~~~
 

Dao层
~~~
public interface StudentDao {

    public void saveStudent();

}

 

public class StudentDaoImpl implements StudentDao {

    public void saveStudent() {

        System.out.println("保存学生信息。。。。。。");

    }

}
~~~
 

配置文件
~~~
<bean id="studentService" class="com.spring2.service.impl.StudentServiceImpl">

    <property name="studentDao" ref="studentDao" />

</bean>

<bean id="studentDao" class="com.spring2.dao.impl.StudentDaoImpl" />
~~~

或者使用“内部bean的方式实现”，这种方式与使用ref的方式相比，没有那么灵活。

~~~
<bean id="studentService" class="com.spring2.service.impl.StudentServiceImpl">

    <property name="studentDao">

        <bean class="com.spring2.dao.impl.StudentDaoImpl" />

    </property>

</bean>
~~~
测试代码，这里使用了Junit来进行测试。
~~~
public class TestSetterInjection {

    @Test

    public void testSetterInjection() {

        ApplicationContext context = new ClassPathXmlApplicationContext("student_bean.xml");

StudentService ss = (StudentService) context.getBean("studentService");

        ss.saveStudent();

    }

}
~~~
######注入基本类型
~~~
SetterInjectionBean

/**

 * 测试原生数据类型的注入，分别注入，String， int， date

 * @author sinoyang

 */

public class SetterInjectionBean {

    private String name;

    private int age;

    private Date hireDate;

    public void show() {

        System.out.println("name=" + name);

        System.out.println("age=" + age);

        System.out.println("hireDate=" + hireDate);

    }

}
~~~
 

配置文件
~~~
<bean id="hireDate" class="java.util.Date" />

<bean id="setterInjectionBean" class="com.spring2.beans.SetterInjectionBean">

    <property name="name">

        <value>sinoyang</value>

    </property>

    <property name="age" value="28" />

    <property name="hireDate" ref="hireDate" />

</bean>
~~~
 

Junit测试代码
~~~
static ApplicationContext context = null;

@BeforeClass

public static void init() {

context = new ClassPathXmlApplicationContext("applicationContext.xml");

}

@Test

public void testSetterInjectionBean() {

    SetterInjectionBean bean = (SetterInjectionBean) context.getBean("setterInjectionBean");

    bean.show();

}
~~~
######集合类型注入
>这里讨论Set,List, Map, Properties 的注入。这些集合的注入在spring总都有相对应的标签支持。
>这里要强调的是<refbean="引用其它的bean" />来引用其它的bean。

测试bean
~~~
/**

 * 测试集合的注入

 * @author sinoyang

 */

public class SetterInjectionCollectionBean {

    private Set<String> set = null;

    private List<String> list = null;

    private Map<String, String> map = null;

private Properties pro = null;

}

 

<bean id="sicb" class="com.spring2.beans.SetterInjectionCollectionBean">

        <property name="set">

            <set>

                <value>set1</value>

                <value>set2</value>

                <!-- <ref bean="引用其它的bean" /> -->

            </set>

        </property>

        <property name="list">

            <list>

                <value>list1</value>

                <value>list2</value>

                <!-- <ref bean="引用其它的bean" /> -->

            </list>

        </property>

        <property name="map">

            <map>

                <entry key="key1">

                    <value>value1</value>

                    <!-- <ref bean="引用其它的bean" /> -->

                </entry>

                <entry key="key2" value="value2" />        

</map>

        </property>

        <property name="pro">

            <props>

                <prop key="prop1">value1</prop>

                <prop key="prop2">value2</prop>

            </props>

        </property>

    </bean>
~~~
 

Junit测试
~~~
@Test

public void testSetterInjectionCollectionBean() {

    SetterInjectionCollectionBean sicb = (SetterInjectionCollectionBean) context.getBean("sicb");

    Set<String> set = sicb.getSet();

    // 通过断言来测试是否正确注入

    Assert.assertEquals(3, set.size());

    List<String> list = sicb.getList();

    // 通过断言来测试是否正确注入

    Assert.assertEquals(3, list.size());

    Map<String, String> map = sicb.getMap();

    // 通过断言来测试是否正确注入

    Assert.assertEquals(3, map.size());

    Properties pro = sicb.getPro();

    Assert.assertEquals(3, pro.size());

 

    Assert.assertEquals("set1", set.iterator().next());

    Assert.assertEquals("list1", list.get(0));

    Assert.assertEquals("value3", map.get("key3"));

    Assert.assertEquals("value1", pro.get("prop1"));

}
~~~
#####自动绑定
>Bean可以使用<value>和<ref>指定bean的实例，spring支持隐射的自动的绑定，可以通过类型(byType)，或者名称(byName)，将某个bean实例绑定到其它bean的属性上。

######byType
>AutoWireBean中有两个属性一个是String，一个是Date，这里把Date进行注入。这里就使用byType来进行注入。


~~~
public class AutoWireBean {

    private String name;

    private Date date;

    public void show() {

        System.out.println("name=" + name);

        System.out.println("date=" + date);

    }

}

 

<bean id="date1" class="java.util.Date" />

<bean id="autoWire" class="com.spring2.beans.AutoWireBean"

        autowire="byType">

    <property name="name" value="test" />

</bean>

 

@Test

public void testAutoWireBean() {

    AutoWireBean awb = (AutoWireBean) context.getBean("autoWire");

    awb.show();

}
~~~
######byName
>Bean与byType一样，测试代码页一样，只是配置文件不同，这里是通过名称来配置的，所以配置文件里面配置的与bean的里面的属性要一样。

~~~
<bean id="date" class="java.util.Date" />

<bean id="autoWire" class="com.spring2.beans.AutoWireBean"

        autowire="byName">

    <property name="name" value="test" />

</bean>
~~~
#####使用注解注入
>如果系统比较复杂的话，会导致spring的配置文件会比较臃肿，这时候可以考虑：java代码中使用@Autowired或@Resource注解方式进行注入。如果要使用注解得需要在xml中引入scheme。


~~~
<?xml version="1.0" encoding="UTF-8"?>

<beans xmlns="http://www.springframework.org/schema/beans"

    xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"

    xmlns:context="http://www.springframework.org/schema/context"

    xsi:schemaLocation="http://www.springframework.org/schema/beans http://www.springframework.org/schema/beans/spring-beans-2.5.xsd

    http://www.springframework.org/schema/context

    http://www.springframework.org/schema/context/spring-context-2.5.xsd"

    >

    <context:annotation-config />

</beans>
~~~
使用@Autowired或@Resource注解方式进行装配，这两个注解的区别是：@Autowired默认按类型装配，@Resource默认按名称装配，当找不到与名称匹配的bean才会按类型装配。

~~~
@Autowired

org.springframework.beans.factory.annotation.Autowired

@Resource

javax.annotation.Resource
~~~
此外从这两个注解的出处可以发现，一个是Spring提供的，一个是java所提供，所以推荐使用@Resource，使用它不会与spring进行耦合。

######@Autowired
~~~
import org.springframework.beans.factory.annotation.Autowired;

import com.spring2.dao.StudentDao;

import com.spring2.service.StudentService;

public class StudentServiceImpl implements StudentService {

    @Autowired

    private StudentDao studentDao;

    public void saveStudent() {

        studentDao.saveStudent();

    }

}

 

public class StudentDaoImpl implements StudentDao {

    public void saveStudent() {

        System.out.println("保存学生信息。。。。。。");

    }

}

 

<bean id="studentDao" class="com.spring2.dao.impl.StudentDaoImpl" />

<bean id="studentService" class="com.spring2.service.impl.StudentServiceImpl" />
~~~
######@Resource
~~~
import javax.annotation.Resource;

import com.spring2.dao.StudentDao;

import com.spring2.service.StudentService;

public class StudentServiceImpl implements StudentService {

    @Resource

    private StudentDao studentDao;

    public void saveStudent() {

        studentDao.saveStudent();

    }

}
~~~
@Resource首先按名称来查找，如果找不到的话，才按类型来查找，也就是说配置文件配置的名称可以与service不同。

@Resource也可以配置名称，如果配置了名称就按名称来匹配，如果匹配不到会注入失败。
~~~
@Resource(name = "studentDao")

private StudentDao studentDao;
~~~

此外注解可以使用在对应的set方法上面。

#####自动扫描bean
前面的例子我们都是使用XML的bean定义来配置组件。在一个稍大的项目中，通常会有上百个组件，如果都采用xml的bean定义来配置，显然会增加配置文件的体积，查找及维护起来也不太方便。spring2.5为我们引入了组件自动扫描机制，他可以在类路径底下寻找标注了@Component、@Service、@Controller、@Repository注解的类，并把这些类纳入进spring容器中管理。它的作用和在xml文件中使用bean节点配置组件是一样的。要使用自动扫描机制，我们需要打开以下配置信息:

~~~
<?xml version="1.0" encoding="UTF-8"?>

<beans xmlns="http://www.springframework.org/schema/beans"

    xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:context="http://www.springframework.org/schema/context"

    xsi:schemaLocation="http://www.springframework.org/schema/beans http://www.springframework.org/schema/beans/spring-beans-2.5.xsd

    http://www.springframework.org/schema/context

    http://www.springframework.org/schema/context/spring-context-2.5.xsd">

    <context:component-scan base-package="com.spring2" />

</beans>
~~~
 

其中base-package为需要扫描的包(含子包)。

@Service用于标注业务层组件、

@Controller用于标注控制层组件（如struts中的action）、

@Repository用于标注数据访问组件，即DAO组件。

@Component泛指组件，当组件不好归类的时候，我们可以使用这个注解进行标注。

@Scope用于指定scope作用域的（用在类上）

@PostConstruct用于指定初始化方法（用在方法上）

@PreDestory用于指定销毁方法（用在方法上）

注意scope一定要写singleton，不然close不会运行。

 
~~~~
package com.spring2.service.impl;

 

import javax.annotation.PostConstruct;

import javax.annotation.PreDestroy;

import javax.annotation.Resource;

 

import org.springframework.context.annotation.Scope;

import org.springframework.stereotype.Service;

 

import com.spring2.dao.StudentDao;

import com.spring2.service.StudentService;

 

@Service("studentService")

@Scope("singleton")

public class StudentServiceImpl implements StudentService {

 

    @PostConstruct

    public void init() {

        System.out.println("init......");

    }

 

    @PreDestroy

    public void close() {

        System.out.println("close.....");

    }

 

    @Resource

    private StudentDao studentDao;

 

    public void saveStudent() {

        studentDao.saveStudent();

    }

}

 
~~~~
~~~~
package com.spring2.dao.impl;

 

import org.springframework.stereotype.Repository;

 

import com.spring2.dao.StudentDao;

 

@Repository

public class StudentDaoImpl implements StudentDao {

    public void saveStudent() {

        System.out.println("保存学生信息。。。。。。");

    }

}

 
~~~~
~~~~
package com.spring2.test;

 

import org.junit.AfterClass;

import org.junit.BeforeClass;

import org.junit.Test;

import org.springframework.context.support.AbstractApplicationContext;

import org.springframework.context.support.ClassPathXmlApplicationContext;

 

import com.spring2.service.StudentService;

 

public class TestAutoScan {

 

    public static AbstractApplicationContext context = null;

 

    @BeforeClass

    public static void init() {

        context = new ClassPathXmlApplicationContext("auto_scan.xml");

    }

 

    @Test

    public void testAutowired() {

        StudentService studentService = (StudentService) context.getBean("studentService");

        studentService.saveStudent();

    }

 

    @AfterClass

    public static void close() {

        context.close();

    }

}

 

<?xml version="1.0" encoding="UTF-8"?>

<beans xmlns="http://www.springframework.org/schema/beans"

    xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:context="http://www.springframework.org/schema/context"

    xsi:schemaLocation="http://www.springframework.org/schema/beans http://www.springframework.org/schema/beans/spring-beans-2.5.xsd

    http://www.springframework.org/schema/context

    http://www.springframework.org/schema/context/spring-context-2.5.xsd">

    <context:component-scan base-package="com.spring2" />

</beans>
~~~~
###bean 的高级管理
>对于应用程序来说，最理想的状态是不需要意识到spring容器的存在，具体来说就是不使用spring的相关API，然而您可以为应用程序组件编写一些spring服务程序，让这些程序得知spring容器的一些消息，以活动spring所提供的一些功能。

#### Aware接口
>有时候必须让Bean指定Spring容器管理它的一些细节，例如或者让它指定BeanFactory，ApplicationContext的存在，也就是让bean获取目前运行中的BeanFactory与ApplicationContext的实例。

Spring中提供一些Aware相关接口：

~~~
org.springframework.beans.factory.BeanFactoryAware

org.springframework.context.ApplicationContextAware
~~~
#####实例
~~~
package com.spring2.beans;

 

import org.springframework.beans.BeansException;

import org.springframework.beans.factory.BeanFactory;

import org.springframework.beans.factory.BeanFactoryAware;

import org.springframework.context.ApplicationContext;

import org.springframework.context.ApplicationContextAware;

 

public class MyAware implements ApplicationContextAware, BeanFactoryAware {

 

    private BeanFactory factory;

 

    private ApplicationContext context;

 

    @Override

    public void setBeanFactory(BeanFactory factory) throws BeansException {

        this.factory = factory;

    }

 

    @Override

    public void setApplicationContext(ApplicationContext context) throws BeansException {

        this.context = context;

    }

 

    public boolean show() {

        MyAware aware1 = (MyAware) context.getBean("myAware");

        MyAware aware2 = (MyAware) factory.getBean("myAware");

        return aware1.getClass().getName() == aware2.getClass().getName();

    }

}
~~~
 
~~~
package com.spring2.test;

 

import org.junit.Assert;

import org.junit.BeforeClass;

import org.junit.Test;

import org.springframework.context.ApplicationContext;

import org.springframework.context.support.ClassPathXmlApplicationContext;

 

import com.spring2.beans.MyAware;

 

public class TestFactoryManager {

 

    private static ApplicationContext context = null;

 

    @BeforeClass

    public static void init() {

        context = new ClassPathXmlApplicationContext("bean_manager.xml");

    }

 

    @Test

    public void test() {

        MyAware aware = (MyAware) context.getBean("myAware");

        Assert.assertEquals(true, aware.show());

    }

}
~~~
 

####BeanPostProcessor
~~~
　　org.springframework.beans.factory.config.BeanPostProcessor;
~~~
 
实现这个接口可以使得我们可以在bean初始化话后还能够对bean的数据进行操作。

#####实例
>下面的实例实现对MyBean里面的数据进行更改，把名字改掉，把年龄也改掉，这个实例不具备实际作用，只是为了说明问题。

~~~
package com.ioc;

import org.springframework.beans.factory.config.BeanPostProcessor;

public class MyPostProcessor implements BeanPostProcessor {

    @Override

    public Object postProcessBeforeInitialization(Object object, String beanName) throws BeansException {

        System.out.println("beforeInitialization() beanName=" + beanName);

        return object;

    }

 

    @Override

    public Object postProcessAfterInitialization(Object object, String beanName) throws BeansException {

        System.out.println("afterInitialization() beanName=" + beanName);

 

        Field[] fields = object.getClass().getDeclaredFields();

        for (Field field : fields) {

            String fieldName = field.getName();

            System.out.println("fieldName=" + fieldName);

            String getterMethodName = "get" + fieldName.substring(0, 1).toUpperCase() + fieldName.substring(1);

            String setterMethodName = "set" + fieldName.substring(0, 1).toUpperCase() + fieldName.substring(1);

            try {

                Method getterMethod = object.getClass().getDeclaredMethod(getterMethodName, new Class[] {});

                Method setterMethod = object.getClass().getDeclaredMethod(setterMethodName,

                        new Class[] { field.getType() });

                Object result = getterMethod.invoke(object, new Object[] {});

 

                if (field.getType() == String.class) {

                    setterMethod.invoke(object, new Object[] { (String) result + "修改了" });

                }

 

                if (field.getType() == int.class) {

                    setterMethod.invoke(object, new Object[] { ((Integer) result) * 2 });

                }

            } catch (Exception e) {

                e.printStackTrace();

            }

        }

 

        return object;

    }

}
~~~ 
~~~
package com.ioc;
public class MyBean {

 

    public MyBean() {

        System.out.println("构造方法执行。。。。。。");

    }

 

    private String name;

 

    private int age;

 

    getter() setter()……

}

 

<bean id="mpp" class="com.ioc.MyPostProcessor" />

    <bean id="myBean" class="com.ioc.MyBean">

        <property name="name" value="test" />

        <property name="age" value="18" />

    </bean>

 

public class TestMyBean {

 

    @Test

    public void test1() {

        ApplicationContext context = new ClassPathXmlApplicationContext("beans.xml");

        MyBean myBean = (MyBean) context.getBean("myBean");

        System.out.println("修改后的值 name=" + myBean.getName() + ", age=" + myBean.getAge());

    }

}
~~~
 

##AOP
###动态代理
####JDK动态代理
~~~
package com.proxy.service;

public interface IBookService {

 

    public void delBookById(int bookId);

 

    public void getBookById(int bookId);

}
~~~
 
~~~
package com.proxy.service.impl;

 

import com.proxy.service.IBookService;

 

public class BookServiceImpl implements IBookService {

 

    private String user;

 

    public BookServiceImpl() {

    }

 

    public BookServiceImpl(String user) {

        this.user = user;

    }

 

    public String getUser() {

        return user;

    }

 

    public void setUser(String user) {

        this.user = user;

    }

 

    @Override

    public void delBookById(int bookId) {

        System.out.println("根据ID删除书本信息。。。。。。");

    }

 

    @Override

    public void getBookById(int bookId) {

        System.out.println("根据ID查询书本信息。。。。。。");

    }

}
~~~
 
~~~
package com.proxy.util;

 

import java.lang.reflect.InvocationHandler;

import java.lang.reflect.Method;

import java.lang.reflect.Proxy;

 

import com.proxy.service.impl.BookServiceImpl;

 

public class MyProxyFactroy implements InvocationHandler {

 

    private Object targetObject;

 

    public Object newProxyInstance(Object targetObject) {

        this.targetObject = targetObject;

        return Proxy.newProxyInstance(this.targetObject.getClass().getClassLoader(), this.targetObject.getClass()

                .getInterfaces(), this);

    }

 

    @Override

    public Object invoke(Object proxy, Method method, Object[] args) throws Throwable {

 

        Object result = null;

        BookServiceImpl service = (BookServiceImpl) targetObject;

 

        System.out.print("调用:" + this.targetObject.getClass().getName() + "." + method.getName() + "(");

        for (int i = 0; i < args.length; i++) {

            if (i == args.length - 1) {

                System.out.print(args[i]);

            } else {

                System.out.print(args[i] + ",");

            }

        }

        System.out.print(")");

        System.out.println();

 

        if (service.getUser() != null) {

            result = method.invoke(this.targetObject, args);

        } else {

            System.out.println("没权限调用");

        }

 

        return result;

    }

}
~~~
 
~~~
package com.proxy.util;

 

import org.junit.Test;

 

import com.proxy.service.IBookService;

import com.proxy.service.impl.BookServiceImpl;

 

public class TestMyProxyFactroyTest {

 

    @Test

    public void test() {

 

        IBookService service = new BookServiceImpl("test");

        // IBookService service = new BookServiceImpl();

        MyProxyFactroy proxy = new MyProxyFactroy();

        IBookService proxyService = (IBookService) proxy.newProxyInstance(service);

        proxyService.delBookById(1111);

        proxyService.getBookById(22);

    }

}
~~~
 

####CGLIB动态代理
~~~
package com.proxy.service.impl;

 

public class BookService {

 

    private String user;

 

    public BookService() {

    }

 

    public BookService(String user) {

        this.user = user;

    }

 

    public String getUser() {

        return user;

    }

 

    public void setUser(String user) {

        this.user = user;

    }

 

    public void delBookById(int bookId) {

        System.out.println("根据ID删除书本信息。。。。。。");

    }

 

    public void getBookById(int bookId) {

        System.out.println("根据ID查询书本信息。。。。。。");

    }

}
~~~
 
~~~ 

package com.proxy.util;

 

import java.lang.reflect.Method;

 

import net.sf.cglib.proxy.Enhancer;

import net.sf.cglib.proxy.MethodInterceptor;

import net.sf.cglib.proxy.MethodProxy;

 

import com.proxy.service.impl.BookService;

 

public class MyCglibProxyFactory implements MethodInterceptor {

 

    private Object targetObject;

 

    public Object newProxyInstance(Object targetObject) {

        this.targetObject = targetObject;

 

        Enhancer enhancer = new Enhancer();

        enhancer.setSuperclass(this.targetObject.getClass());

        enhancer.setCallback(this);

 

        return enhancer.create();

    }

 

    @Override

    public Object intercept(Object proxy, Method method, Object[] args, MethodProxy methodProxy) throws Throwable {

 

        Object result = null;

        BookService service = (BookService) targetObject;

        System.out.print("调用:" + service.getClass().getName() + "." + method.getName() + "(");

        for (int i = 0; i < args.length; i++) {

            if (i == args.length - 1) {

                System.out.print(args[i]);

            } else {

                System.out.print(args[i] + ",");

            }

        }

        System.out.print(")");

        System.out.println();

       

        if (service.getUser() != null) {

            result = method.invoke(this.targetObject, args);

        } else {

            System.out.println("没权限调用");

        }

 

        return result;

    }

}
~~~
 
~~~
package com.proxy.util;

 

import org.junit.Test;

 

import com.proxy.service.impl.BookService;

 

public class TestMyCglibProxyFactory {

 

    @Test

    public void test() {

 

        // BookService service = new BookService("test");

        BookService service = new BookService();

        MyCglibProxyFactory proxy = new MyCglibProxyFactory();

        BookService proxyService = (BookService) proxy.newProxyInstance(service);

        proxyService.delBookById(1111);

        proxyService.getBookById(22);

    }

}
~~~
 
###AOP专业术语
>AOP里面的许多术语都过于抽象，单从字面上不容易理解其意义，我们对照以前的实例来讲解。

####Cross-cutting-concern
>在我们日志的实例中，日志动作作为横切入我们的Service本身所负责的业务流程中，此外，还有，事务，权限，等系统级的服务，在一些应用程序中常被安插到各个对象的处理流程中，这些动作在AOP中就叫”Cross-cutting-concern”。

####Aspect
>将散落在业务逻辑中的”Cross-cutting-concern”收集起来，设计成各个可以独立重用的对象。这些对象就叫Aspect，前面的实例中：MyProxyFactory，MyCglibProxyFactory就是一个AOP实例。使用它会使之从具体的业务流程中独立出来，在需要的时候织入(Weave)应用程序，不需要的时候立即从应用程序中脱离。且可以重用还不用做任何修改，我们的Service层代码就是可重用组件，它需要日志服务的时候不需要修改代码。

####Advice
>中文翻译“通知”，Aspect中对Cross-cutting-concern的具体实现称之为：Advice。以前面的日志而言，Advice中包括日志是如何实现的。它分为：前置通知，后置通知，异常通知，最终通知，环绕通知。

####JoinPoint
>所谓的“连接点”就是指：通知在应用程序执行时加入到业务流程的点或者时机称之为JoinPoint。具体来说就是通知在应用程序中被执行的时机。Spring只支持方法连接点。

####Pointcut
>中文翻译“切入点”，它定义了感兴趣的连接点，当调用的方法，符合Pointcut表示的时候，会将Advice织如到应用程序上，在spring中可以通过XML，annotation来编写Pointcut。

####Target
>一个Advice被应用的对象或者目标对象，上面的实例中我们的service层的代码就是Target。

####Introduction
>对于一个现存的类，Introduction可以增加其行为，且不用修改类的代码，具体来说，可以为某个已编写的类，在执行的时期动态的添加一些方法，不用修改任何代码。

####Weave
>Advice被应用于对象之上的过程称之为织入(weave)，AOP的织如方式有几个时间点：编译时期，类加载时期，执行时期。

####Spring AOP介绍
>不同的AOP框架会有对AOP概念的不同的实现，主要的差别在于所提供的pointcuts，Aspects的丰富程度，以及它们如何“被织入”到应用程序里面去，或者代理的实现方式。

>Spring的Advice使用java来编写，它不使用特定的AOP语言，在定义pointcuts可以使用XML，或者注解实现。

>Spring的advices在执行时期导入到Targets，这个时候spring就会JDK的动态代理来实现，如果没有实现接口就使用CGLIB来实现。这里要注意的是，应该优先才用接口方式，这可以让应用程序组件彼此的耦合度降低。若使用CGLIB由于必须产生子类，就会导致如果对于被声明为final的类无法代理。

>Spring只支持方法的joinpoints，也就是说advice将在方法执行前后被应用，spring不支持field成员的joinpoints，原因在于支持field成员的joinpoints会破坏对象的封装性。

###AOP XML配置实现
>AOP配置文件头信息


~~~
<?xml version="1.0" encoding="UTF-8"?>

<beans xmlns="http://www.springframework.org/schema/beans"

    xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"

    xmlns:context="http://www.springframework.org/schema/context"

    xmlns:aop="http://www.springframework.org/schema/aop"

    xsi:schemaLocation="http://www.springframework.org/schema/beans

    http://www.springframework.org/schema/beans/spring-beans-2.5.xsd

    http://www.springframework.org/schema/context

    http://www.springframework.org/schema/context/spring-context-2.5.xsd

   http://www.springframework.org/schema/aop http://www.springframework.org/schema/aop/spring-aop-2.5.xsd">

    <context:component-scan base-package="com.aop" />

    <aop:aspectj-autoproxy />

</beans>
~~~
####切面类
~~~
package com.aop.aspect;

import org.aspectj.lang.JoinPoint;

import org.aspectj.lang.ProceedingJoinPoint;

import org.slf4j.Logger;

import org.slf4j.LoggerFactory;

 

/**

 * 日志切面

 *

 * @author Administrator

 */

@SuppressWarnings("unused")

public class LoggerAspect {

 

    private Logger logger = LoggerFactory.getLogger(LoggerAspect.class);

 

    /**

     * 前置通知

     */

    public void beforeAdvice(JoinPoint jp) {

        // 获得类名与方法名

        String log = jp.getSignature().getDeclaringTypeName() + "." + jp.getSignature().getName() + "()";

        // 获得参数

        Object args[] = jp.getArgs();

        logger.info("开始运行: {}", log);

    }

 

    /**

     * 后置通知

     */

    public void afterAdvice(JoinPoint jp) {

        // 获得类名与方法名

        String log = jp.getSignature().getDeclaringTypeName() + "." + jp.getSignature().getName() + "()";

        logger.info("正常结束：{}", log);

    }

 

    /**

     * 异常通知

     */

    public void exceptionAdvice(JoinPoint jp, Throwable throwing) {

        String log = jp.getSignature().getDeclaringTypeName() + "." + jp.getSignature().getName() + "()";

        logger.info("发生异常：{} 异常是{}", log, throwing.getMessage());

    }

 

    /**

     * 最终通知

     */

    public void finalAdvice(JoinPoint jp) {

        String log = jp.getSignature().getDeclaringTypeName() + "." + jp.getSignature().getName() + "()";

        logger.info("结束运行：{}", log);

    }

 

    /**

     * 环绕通知，适合做权限

     */

    public Object roundAdvice(ProceedingJoinPoint pjp) {

 

        Object result = null;

        String log = pjp.getSignature().getDeclaringTypeName() + "." + pjp.getSignature().getName() + "()";

        try {

            logger.info("开始运行：{}", log);

            result = pjp.proceed();

            logger.info("运行完毕：{}", log);

        } catch (Throwable e) {

            logger.info("运行：{}发生异常：{}", log, e.getMessage());

        } finally {

            logger.info("结束运行 {}", log);

        }

 

        return result;

    }

}
~~~
####配置文件
~~~
<!-- 打开AOP使用的开关 -->

<aop:aspectj-autoproxy />

<bean id="logAspect" class="com.aop.aspect.LoggerAspect" />

<bean id="bookService" class="com.aop.service.impl.BookServiceImpl" />

<aop:config>

    <!-- 定义切面 -->

    <aop:aspect id="myAop" ref="logAspect">

        <!-- 定义切入点 -->

        <!-- expression表示切入点的规则 -->

        <!-- 拦截com.aop.service包下面，以及所有的子包下面的所有的类，所有的方法 -->

<aop:pointcut expression="execution(* com.aop.service..*.*(..))"

                id="myPc" />

        <!-- 定义通知 -->

        <!-- method:表示切面类里面的哪个方法是对于的advice -->

        <aop:before method="beforeAdvice" pointcut-ref="myPc" />

        <aop:after-returning method="afterAdvice" pointcut-ref="myPc" />

        <!-- 定义异常 -->

        <aop:after-throwing method="exceptionAdvice" pointcut-ref="myPc" throwing="throwing" />

        <aop:after method="finalAdvice" pointcut-ref="myPc" />

        <aop:around method="roundAdvice" pointcut-ref="myPc" />

    </aop:aspect>

</aop:config>
~~~
####业务方法
~~~
package com.aop.service.impl;

import org.springframework.stereotype.Service;

import com.aop.service.IBookService;

public class BookServiceImpl implements IBookService {

    // private Logger logger = LoggerFactory.getLogger(BookServiceImpl.class);

    @Override

    public void addBook() {

        // logger.info("............................");

        System.out.println("添加书本信息");

    }


    @Override

    public boolean delBook(int bookId) {

        System.out.println("删除书本信息");

        //int a = 10 / 0;

        return false;

    }

 

    @Override

    public void modBook(int bookId) {

        System.out.println("修改书本信息");

    }

 

    @Override

    public void queryBook(int bookId) {

        System.out.println("查询书本信息");

    }

}

~~~ 

####业务方法测试类
~~~
package com.aop.proxy;

import org.junit.BeforeClass;

import org.junit.Test;

import org.springframework.context.ApplicationContext;

import org.springframework.context.support.ClassPathXmlApplicationContext;

 

import com.aop.listener.SystemListener;

import com.aop.service.IBookService;

 

/**

 * 测试AOP

 *

 * @author Administrator

 */

public class TestLogAspect {

 

    private static ApplicationContext context;

 

    @BeforeClass

    public static void init() {

        context = new ClassPathXmlApplicationContext("aop.xml");

        SystemListener.init();

    }

 

    @Test

    public void test() {

        IBookService service = (IBookService) context.getBean("bookService");

        service.delBook(10);

    }

}
~~~
 

### AOP 注解实现
>使用注解来实现AOP在实际应用中会使用的比较多， Spring 2.5 中AOP 装配的常用Annotation 注解说明


![](springSection/02.jpg)

#### 切面类
~~~
package com.aop.aspect;

import org.aspectj.lang.JoinPoint;

import org.aspectj.lang.ProceedingJoinPoint;

import org.aspectj.lang.annotation.After;

import org.aspectj.lang.annotation.AfterReturning;

import org.aspectj.lang.annotation.AfterThrowing;

import org.aspectj.lang.annotation.Around;

import org.aspectj.lang.annotation.Aspect;

import org.aspectj.lang.annotation.Before;

import org.aspectj.lang.annotation.Pointcut;

import org.slf4j.Logger;

import org.slf4j.LoggerFactory;

import org.springframework.stereotype.Component;

 

/**

 * 日志切面

 * @author Administrator

 */

@Aspect

@Component

public class LoggerAspect1 {

 

    private Logger logger = LoggerFactory.getLogger(LoggerAspect1.class);

 

    @Pointcut("execution(* com.aop.service..*.*(..))")

    public void allMethod() {

    }

 

    // 前置通知

    @Before("allMethod() && args(bookId)")

    public void beforeAdvice(JoinPoint jp, int bookId) {

        String log = jp.getSignature().getDeclaringTypeName() + "." + jp.getSignature().getName() + "()";

        logger.info("{} 前置通知！ bookId={}", log, bookId);

    }

 

// 前置通知 多个参数

    @Before("allMethod() && args(pageSize, page)")

    public void beforeAdvice1(JoinPoint jp, int pageSize, int page) {

        String log = jp.getSignature().getDeclaringTypeName() + "." + jp.getSignature().getName() + "()";

        Object args[] = { log, pageSize, page };

        logger.info("{} 前置通知！ pageSize={} page={}", args);

    }

 

    // 后置通知

    @AfterReturning(pointcut = "allMethod()", returning = "result")

    public void afterAdvice(JoinPoint jp, boolean result) {

        String log = jp.getSignature().getDeclaringTypeName() + "." + jp.getSignature().getName() + "()";

        logger.info("{} 后置通知！ result={}", log, result);

    }

 

    // 异常通知

    @AfterThrowing(pointcut = "allMethod()", throwing = "e")

    public void exceptionAdvice(JoinPoint jp, Exception e) {

        String log = jp.getSignature().getDeclaringTypeName() + "." + jp.getSignature().getName() + "()";

        logger.info("{} 异常通知！ Exception={}", log, e.getMessage());

    }

 

    // 最终通知

    @After("allMethod()")

    public void finalAdvice(JoinPoint jp) {

        String log = jp.getSignature().getDeclaringTypeName() + "." + jp.getSignature().getName() + "()";

        logger.info("{} 最終通知！", log);

    }

 

    // 测试环绕通知

    @Around("allMethod()")

    public Object aroundAdvice(ProceedingJoinPoint pjp) throws Throwable {

        String log = pjp.getSignature().getDeclaringTypeName() + "." + pjp.getSignature().getName() + "()";

        Object result = null;

        logger.info("{} 方法执行前！", log);

        result = pjp.proceed();

        logger.info("{} 方法执行后！", log);

        return result;

    }

}
~~~
#####切面表达式的解析
~~~
@Pointcut("execution(* com.aop.service..*.*(..))")
~~~
>execution表示执行业务方法的时候需要拦截。

>括号里面的第一个星号代码返回值类型。

>com.aop.service表示代码要拦截的包名，它后面的两个点代表的是子包。

>*.*代表的是所以的类和类里面的所以的方法。

>括号两个点：表示方法的参数，两个点表示方法的参数是任意个。

 

####业务类
~~~~
package com.aop.service.impl;

 

import org.springframework.stereotype.Service;

 

import com.aop.service.IBookService;

import com.aop.vo.BookVo;

 

@Service("bookService")

public class BookServiceImpl implements IBookService {

 

    @Override

    public void addBook(BookVo book) throws Exception {

        System.out.println("添加书本信息。。。。。。");

        if (book.getBookName() == null) {

            throw new Exception("書名為空，不能添加！");

        }

    }

 

    @Override

    public int delBookById(int bookId) {

        System.out.println("根据ID删除书本信息。。。。。。");

        return 1;

    }

 

    @Override

    public void modBookById(int bookId, BookVo book) {

        System.out.println("根据ID修改书本信息。。。。。。");

    }

 

    @Override

    public BookVo getBookById(int bookId) {

        System.out.println("根据ID查询书本信息。。。。。。");

        return null;

    }

}
~~~~
####测试类
~~~~
package com.aop.proxy;

 

import org.junit.BeforeClass;

import org.junit.Test;

import org.springframework.context.ApplicationContext;

import org.springframework.context.support.ClassPathXmlApplicationContext;

 

import com.aop.service.IBookService;

import com.aop.vo.BookVo;

 

public class TestMyAop {

 

    private static ApplicationContext context;

 

    @BeforeClass

    public static void init() {

        context = new ClassPathXmlApplicationContext("aop.xml");

    }

 

    /**

     * 测试：前置，后置，最终 通知

     */

    @Test

    public void testAdrice1() {

        IBookService bookService = (IBookService) context.getBean("bookService");

        bookService.delBookById(0);

    }

 

    /**

     * 测试：异常通知

     * @throws Exception

     */

    @Test(expected = Exception.class)

    public void testAdrice2() throws Exception {

        IBookService bookService = (IBookService) context.getBean("bookService");

        bookService.addBook(new BookVo());

    }

}
~~~~
####其它配置形式
#####获取输入参数
>前置通知会可能要获取到方法的参数，可以使用下面的方式来获取到参数。


~~~
@Before("allMethod() && args(bookId)")

public void beforeAdvice(int bookId) {

    System.out.println("前置通知！ bookId=" + bookId);

}

@Before("allMethod() && args(bookId)")
~~~

上面的写法拦截表示：前置通知且方法有一个参数为int型的参数。如果调用其它的参数不匹配的时候，这个前置通知不会被调用。

#####获取返回值
>后置通知的话可能要获取到方法的返回值，这个删除的方法与返回值，表示是否删除成功。


~~~
@Override

public int delBookById(int bookId) {

    System.out.println("根据ID删除书本信息。。。。。。");

    return 1;

}

 

@AfterReturning(pointcut = "allMethod()", returning = "result")

public void afterAdvice(int result) {

    System.out.println("后置通知！ result=" + result);

}

 

@AfterReturning(pointcut = "allMethod()", returning = "result")

~~~
使用returning来表示返回值。

#####获取程序的异常
~~~
@AfterThrowing(pointcut = "allMethod()", throwing = "e")

public void exceptionAdvice(Exception e) {

    System.out.println("异常通知！ Exception=" + e.getMessage());

}
~~~
####所谓切入点的定义
>所谓切入点的定义就是通过编写一个AOP 正则表达式，指明欲拦截与插入通知的连接点。由于Spring 的连接点仅支持方法级别，因此，本节中所讲的连接点实指目标对象中的某个方法。在定义AOP 切入点时，通常使用execution 切入点指示符设置连接点正则表达式，具体语法如下：


~~~
execution(modifiers-pattern? ret-type-pattern

 declaring-type-pattern? name-pattern(para m-pattern)

 throws-pattern?)
~~~
>除了返回值类型模式（ret-type-pattern ），名字模式（name-pattern）和参数模式（param-pattern）以外，其他部分都是可选的。访问类型模式（modifierspattern）决定了方法的访问类型，如public 表示匹配所有公用方法，此模式通常可省略不写，除非有特定的需求。返回值类型模式（ret-type-pattern ）决定了方法的返回值类型，当所有返回值类型均予以匹配的话，可直接设置为*，表示匹配任意的返回值类型。类型名称模式（declaring-type-pattern）表示匹配的包或类的名称规则，"包路径.*"表示指定包下的所有类均予以匹配，"包路径..*"则表示指定包及其子包下的所有类均予以匹配，"包路径.类名"表示指定的类予以匹配。名字模式name-pattern 匹配的是方法名，*表示匹配所有方法，set*表示所有方法名以set 开头的方法。参数模式param-pattern稍微有点复杂：()表示匹配不接受任何参数的方法，(..)表示匹配接受任意数量参数的方法，不论参数有无或多少，(*)表示匹配接受一个任何类型的参数的方法，而(*,String)则表示匹配接受两个参数的方法，第一个参数可以是任意类型，而第二个参数必须是String 类型。异常模式（throws-pattern）决定了抛出何种类型的异常，如RuntimeException 表示匹配抛出RuntimeException 异常的方法，此模式通常可省略不写，除非有特定的需求。

###Spring 2.5 中常用的AOP 正则表达式说明
![](springSection/01.jpg)

## Spring jdbc
>Spring集成JDBC在现实项目中使用比较多，我们可以使用spring与JDBC的集成给开发带来很大的便利。

###集成配置
>集成配置主要分为以下几个步骤：

1. 选定jar包。

2. 配置配置文件。

3. 使用JdbcTemplate类完成开发。

####声明事务的tx命名空间
~~~
<?xml version="1.0" encoding="UTF-8"?>

<beans xmlns="http://www.springframework.org/schema/beans"

xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:context="http://www.springframework.org/schema/context"

xmlns:aop="http://www.springframework.org/schema/aop"xmlns:tx="http://www.springframework.org/schema/tx"

xsi:schemaLocation="http://www.springframework.org/schema/beans

    http://www.springframework.org/schema/beans/spring-beans-2.5.xsd

    http://www.springframework.org/schema/context

http://www.springframework.org/schema/context/spring-context-2.5.xsd

    http://www.springframework.org/schema/aop http://www.springframework.org/schema/aop/spring-aop-2.5.xsd

    http://www.springframework.org/schema/tx http://www.springframework.org/schema/tx/spring-tx-2.5.xsd">

</beans>
~~~
####配置文件
#####配置数据源
>配置文件主要包括，数据源的声明，配置事务管理类，这里的数据源使用C3P0。

NAME|说明
-----|------
driverClass|驱动类
jdbcUrl|数据库url
user|数据库用户名
password|数据库密码
minPoolSize|连接池中保留的最小连接数
maxPoolSize|连接池中保留的最大连接数，Default: 15
initialPoolSize|初始化时获取的连接数，取值应在minPoolSize与maxPoolSize之间。Default: 3
maxIdleTime|最大空闲时间,60秒内未使用则连接被丢弃。若为0则永不丢弃。Default: 0
acquireIncrement|当连接池中的连接耗尽的时候c3p0一次同时获取的连接数。Default: 3

~~~
<beanid="ds" class="com.mchange.v2.c3p0.ComboPooledDataSource">

    <property name="driverClass" value="com.mysql.jdbc.Driver" />

<property name="jdbcUrl"        value="jdbc:mysql://127.0.0.1:3306/test?useUnicode=true&amp;characterEncoding=utf8" />

    <property name="user" value="root" />

    <property name="password" value="mysql" />

    <property name="minPoolSize" value="5" />

    <property name="maxPoolSize" value="10" />

    <property name="initialPoolSize" value="3" />

    <property name="maxIdleTime" value="60" />

    <property name="acquireIncrement" value="5" />

</bean>
~~~
也可以在properties文件中定义数据库的相关信息，可以是使用下面的配置。
~~~
<context:property-placeholder location="classpath:jdbc.properties" />

<bean id="ds" class="com.mchange.v2.c3p0.ComboPooledDataSource">

    <property name="driverClass" value="${driverClass}" />

    <property name="jdbcUrl" value="${jdbcUrl}" />

    <property name="user" value="${user}" />

    <property name="password" value="${password}" />

    <property name="minPoolSize" value="${minPoolSize}" />

    <property name="maxPoolSize" value="${maxPoolSize}" />

    <property name="initialPoolSize" value="${initialPoolSize}" />

    <property name="maxIdleTime" value="${maxIdleTime}" />

    <property name="acquireIncrement" value="${acquireIncrement}" />

</bean>
~~~
jdbc.properties
~~~
driverClass=com.mysql.jdbc.Driver

jdbcUrl=jdbc\:mysql\://127.0.0.1\:3306/test?useUnicode\=true&characterEncoding\=utf8

user=root

password=mysql

minPoolSize=5

maxPoolSize=10

initialPoolSize=3

maxIdleTime=60

acquireIncrement=5
~~~
#####配置事务管理类
~~~~
<!-- 配置事务管理类 -->

<bean id="transactionManager"

    class="org.springframework.jdbc.datasource.DataSourceTransactionManager">

    <property name="dataSource" ref="ds" />

</bean>

 

<!-- 打开事务的命名空间 -->

<tx:annotation-driven transaction-manager="transactionManager" />

 

<bean id="userDao" class="com.jdbc.dao.impl.UserDaoImpl">

    <property name="dataSource" ref="ds" />

</bean>
~~~~
#####配置spring对事物的支持
~~~
<aop:config>

    <!-- 配置事物切入点 -->

    <aop:pointcut id="tp" expression="execution(* com.spring.jdbc..*.*(..))" />

    <aop:advisor advice-ref="txAdvice" pointcut-ref="tp" />

</aop:config>
~~~
#####定义通知
~~~
<tx:advice id="txAdvice" transaction-manager="transactionManager">

    <tx:attributes>

        <!-- 配置哪些方法需要事物，哪些方法不需要事物 -->

        <!-- 以select开头的方法不要事物 -->

        <tx:method name="select*" propagation="NOT_SUPPORTED" />

        <!-- 除了以select开头的方法其余都都要事物 -->

        <tx:method name="*" propagation="REQUIRED" />

    </tx:attributes>

</tx:advice>
~~~
####使用JdbcTemplate完成开发
>这个基于原有的JDBC的开发，也就是是通过获取Connection，打开事务，预编译SQL语句，等步骤来实现，然后说明这样的开发与以前没有区别，而引出JdbcTemplate类，由这个类来帮助我们开发。


~~~
public class UserDaoImpl implements IUserDao {

    private JdbcTemplate jdbcTemplate;

    public void setDataSource(DataSource dataSource) {

        jdbcTemplate = new JdbcTemplate(dataSource);

    }

}
~~~
~~~
package com.spring.jdbc.vo;

import java.sql.ResultSet;

import java.sql.SQLException;

 

import org.springframework.jdbc.core.RowMapper;

 

public class UserVoRowMapper implements RowMapper {

 

    @Override

    public Object mapRow(ResultSet rs, int index) throws SQLException {

        System.out.println("index============" + index);

        UserVo vo = new UserVo();

        vo.setUserId(rs.getInt("u_id"));

        vo.setUserName(rs.getString("u_name"));

        vo.setPassword(rs.getString("u_pwd"));

        vo.setEmail(rs.getString("u_email"));

 

        return vo;

    }

}
~~~
#####添加操作
~~~
public void insertUser(UserVo vo) throws Exception {

        jdbcTemplate.update("INSERT INTO t_user (user_name, age) VALUES (?, ?)",new Object[] { vo.getUserName(), vo.getAge() }, new int[] { Types.VARCHAR, Types.INTEGER });throw new Exception("抛异常！");

}
~~~
#####删除操作
~~~
public void deleteUser(int userId) {

    jdbcTemplate.update("DELETE FROM t_user WHERE user_id=?", new Object[] { userId }, new int[] { Types.INTEGER });

}
~~~
#####修改操作
~~~
public void updateUser(UserVo vo) {

    jdbcTemplate.update("UPDATE t_user SET user_name=?, age=? WHERE user_id=?",new Object[] { vo.getUserName(), vo.getAge(), vo.getUserId() }, new int[] { Types.VARCHAR,Types.INTEGER, Types.INTEGER });

}
~~~
#####查询操作
~~~
public UserVo selectUserById(int userId) {

    return (UserVo) jdbcTemplate.queryForObject("SELECT user_id, user_name, age FROM t_user WHERE user_id=?",new Object[] { userId }, new UserVoRowMapper());

}

public List<UserVo> selectAllUser() {

    return (List<UserVo>) jdbcTemplate.query("SELECT user_id, user_name, age FROM t_user", new UserVoRowMapper());

}
~~~
###### RowMapper开发
>spring请你帮个忙：“我不知道把这一条记录变成一个怎样的对象，你帮我做吧”

 
~~~
package com.spring.jdbc.vo;

 

import java.sql.ResultSet;

import java.sql.SQLException;

 

import org.springframework.jdbc.core.RowMapper;

 

public class UserVoRowMapper implements RowMapper {

    @Override

    public Object mapRow(ResultSet rs, int index) throws SQLException {

        System.out.println("index============" + index);

        UserVo vo = new UserVo();

        vo.setUserId(rs.getInt("u_id"));

        vo.setUserName(rs.getString("u_name"));

        vo.setPassword(rs.getString("u_pwd"));

        vo.setEmail(rs.getString("u_email"));

        return vo;

    }

}
~~~
 

###注解事务的支持
>可以使用@Transactional来表示


~~~
@Transactional

public class UserDaoImpl implements IUserDao {

}
~~~
 

也可以在某个方法上添加@Transactional表示某个方法需要事务。
~~~
@Transactional

public UserVo selectUserById(int userId) {

}
~~~
####异常处理
>如果是抛出需要try{}catch(){}的异常的话，事务是不会回滚的。在下面的代码中会抛出异常后，事务不会回滚，所以会修改。

~~~
@Override

public void updateUser(UserVo vo) throws Exception{

    throw new Exception("抛异常！");

}
~~~
 

如果是抛出的RuntimeException的时候，恰恰相反，事务会回滚。在下面的代码中会抛出异常后，事务会回滚，所以不修改。

~~~
public void updateUser(UserVo vo) {

    throw new RuntimeException("抛异常！");

}
~~~
 

由于抛出需要try{}catch(){}的异常的话，事务是不会回滚的。但是如果要求也回滚的话可以使用下面的配置要求事务回滚。

“rollbackFor = Exception.class”表明发生Exception异常的时候事务也要回滚。

~~~~
@Transactional(rollbackFor = Exception.class)

public void updateUser(UserVo vo) throws Exception {

    throw new Exception("抛异常！");

}
~~~~
 
RuntimeException的时候，事务回滚，不会修改，如果不要回滚可以这么配置。

“noRollbackFor = RuntimeException.class”表示发生RuntimeException时候也不回滚。
~~~~
@Transactional(noRollbackFor = RuntimeException.class)

public void updateUser(UserVo vo) {

    throw new RuntimeException("抛异常！");

}
~~~~
####事务传播行为
>事务的传播行为是指：何时开始一个事务，或者何时暂停，或者方法要在事务上运行。

>在org.springframework.transaction.TransactionDefinition中定义了spring支持的事务传播类型。

NAME| 说明
-----|------
REQUIRED|业务方法需要在一个事务中运行。如果方法运行时，已经处在一个事务中，那么加入到该事务，否则为自己创建一个新的事务。
NOT_SUPPORTED|声明方法不需要事务。如果方法没有关联到一个事务，容器不会为它开启事务。如果方法在一个事务中被调用，该事务会被挂起，在方法调用结束后，原先的事务便会恢复执行。
MANDATORY|该属性指定业务方法只能在一个已经存在的事务中执行，业务方法不能发起自己的事务。如果业务方法在没有事务的环境下调用，容器就会抛出例外。
REQUIRED_NEW|属性表明不管是否存在事务，业务方法总会为自己发起一个新的事务。如果方法已经运行在一个事务中，则原有事务会被挂起，新的事务会被创建，直到方法执行结束，新事务才算结束，原先的事务才会恢复执行。
SUPPORTS|这一事务属性表明，如果业务方法在某个事务范围内被调用，则方法成为该事务的一部分。如果业务方法在事务范围外被调用，则方法在没有事务的环境下执行。（可以在事物中运行，也可以不在事物中运行）
NEVER|指定业务方法绝对不能在事务范围内执行。如果业务方法在某个事务中执行，容器会抛出例外，只有业务方法没有关联到任何事务，才能正常执行。
NESTED|如果一个活动的事务存在，则运行在一个嵌套的事务中. 如果没有活动事务, 则按REQUIRED属性执行.它使用了一个单独的事务，这个事务拥有多个可以回滚的保存点。内部事务的回滚不会对外部事务造成影响。如果外部事务回滚，内部事务是会受到影响的。它只对DataSourceTransactionManager事务管理器起效


#####只读事物
>使用readyOnly=true表示一个只读事务，如果进行增删，改的操作，会报异常，这点要注意。

~~~
@Override

@Transactional(propagation = Propagation.REQUIRED, readOnly = true)

public void deleteUser(int userId) {

    jdbcTemplate.update("DELETE FROM t_user WHERE user_id=?", new Object[] { userId }, new int[] { Types.INTEGER });

}
~~~
 

####事务隔离级别
>数据库系统提供了四种事务隔离级别供用户选择。不同的隔离级别采用不同的锁类型来实现，在四种隔离级别中，Serializable的隔离级别最高，Read Uncommited的隔离级别最低。大多数据库默认的隔离级别为Read Commited。


NAME| 说明
-----|------
Read Uncommited|读未提交数据(会出现脏读,不可重复读和幻读)。
Read Commited|读已提交数据(会出现不可重复读和幻读)
Repeatable Read|可重复读(会出现幻读)
Serializable|可串行化（Serializable）

1.  脏读：一个事务读取了另一个未提交的并行事务写的数据。

2.  不可重复读：在同一事务中，多次读取同一数据返回的结果有所不同。换句话说就是，后续读取可以读到另一事务已提交的更新数据。

3.  可重复读：在同一事务中多次读取数据时，能够保证所读数据一样，也就是，后续读取不能读到另一事务已提交的更新数据。

4.  幻读：一个事务读取到另一事务已提交的insert数据。

 
NAME| 说明
-----|------
读已提交| 当一个事务运行在这个隔离级别时， 一个 SELECT 查询只能看到查询开始之前提交的数据而永远 无法看到未提交的数据或者是在查询执行时其他并行的事务提交做的改变。 
串行化|提供最严格的事务隔离。 这个级别模拟串行的事务执行， 就好象事务将被一个接着一个那样串行的，而不是并行的执行。

###    基于XML方式配置事务
~~~
<!-- 配置事务管理类 -->

<bean id="transactionManager"

    class="org.springframework.jdbc.datasource.DataSourceTransactionManager">

    <property name="dataSource" ref="dataSource" />

</bean>

<aop:config>

    <aop:pointcut id="tp" expression="execution(* com.jdbc..*.*(..))" />

    <aop:advisor advice-ref="txAdvice" pointcut-ref="tp" />

</aop:config>

<tx:advice id="txAdvice" transaction-manager="transactionManager">

    <tx:attributes>

        <tx:method name="select*" propagation="NOT_SUPPORTED" />

        <tx:method name="*" propagation="REQUIRED" />

    </tx:attributes>

</tx:advice>

<bean id="userDao" class="com.jdbc.dao.impl.UserDaoImplByXml">

    <property name="dataSource" ref="dataSource" />

</bean>
~~~