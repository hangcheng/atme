##maven 插件
###编译插件
~~~~
<plugin>
	<!-- 编译主源码即java代码 -->
	<groupId>org.apache.maven.plugins</groupId>
	<artifactId>maven-compiler-plugin</artifactId>
	<version>3.2</version>
	<configuration>
		<source>1.6</source>
		<target>1.6</target>
	</configuration>
</plugin>
~~~~

###资源插件
~~~~
<plugin>
	<!-- 处理资源文件 -->
	<groupId>org.apache.maven.plugins</groupId>
	<artifactId>maven-resources-plugin</artifactId>
	<configuration>
		<encoding>UTF-8</encoding>
	</configuration>
</plugin>
~~~~

###Tomcat 插件
~~~~
<plugin>
	<groupId>org.apache.tomcat.maven</groupId>
	<artifactId>tomcat6-maven-plugin</artifactId>
	<version>2.0-beta-1</version>
	<configuration>
		<port>8080</port>
		<path>/csl</path>
		<uriEncoding>utf-8</uriEncoding>
		<ignorePackaging>true</ignorePackaging>
	</configuration>
</plugin>
~~~~
> mvn tomcat6:run


###mybatis 自动生成插件
~~~~
<plugin>
	<groupId>org.mybatis.generator</groupId>
	<artifactId>mybatis-generator-maven-plugin</artifactId>
	<version>1.3.2</version>
	<configuration>
		<!-- <configurationFile>src/main/resources/generatorConfig.xml</configurationFile> -->
		<!--允许移动生成的文件 -->
		<verbose>true</verbose>
		<!--允许覆盖生成的文件 -->
		<overwrite>true</overwrite>
	</configuration>
	<dependencies>
        <dependency>  
            <groupId>mysql</groupId>  
            <artifactId>mysql-connector-java</artifactId>  
            <version>5.1.6</version>  
        </dependency>  
        <dependency>  
            <groupId>org.mybatis.generator</groupId>  
            <artifactId>mybatis-generator-core</artifactId>  
            <version>1.3.2</version>  
        </dependency>  
        <dependency>  
            <groupId>org.mybatis</groupId>  
            <artifactId>mybatis</artifactId>  
            <version>3.2.2</version>  
        </dependency>  
    </dependencies>  
</plugin>
~~~~
> mvn mybatis-generator:generate

###axis2 插件
####java2wsdl
~~~~
<plugin>
	<groupId>org.apache.axis2</groupId>
	<artifactId>axis2-java2wsdl-maven-plugin</artifactId>
	<configuration>
	  <className>com.foo.myservice.MyHandler</className>
	</configuration>
	<executions>
	  <execution>
	    <goals>
	      <goal>java2wsdl</goal>
	    </goals>
	  </execution>
	 </executions>
</plugin>
~~~~
> mvn axis2-java2wsdl:java2wsdl

####wsdl2code
~~~~
<plugin>
    <groupId>org.apache.axis2</groupId>
    <artifactId>axis2-wsdl2code-maven-plugin</artifactId>
    <version>1.4</version>
    <executions>
        <execution>
            <goals>
                <goal>wsdl2code</goal>
            </goals>
            <configuration>
                <packageName>com.foo.myservice</packageName>
                <wsdlFile>src/main/wsdl/myservice.wsdl</wsdlFile>
                <databindingName>xmlbeans</databindingName>
            </configuration>
        </execution>
    </executions>
</plugin>
~~~~
> mvn axis2-wsdl2code:wsdl2code


###jar war 打包插件
~~~~
<plugin>
	<groupId>org.apache.maven.plugins</groupId>
	<artifactId>maven-jar-plugin</artifactId>
	<!-- <configuration> <excludes> 
		<exclude>log4j.properties</exclude> 
		</excludes> </configuration> -->
</plugin>
<plugin>
	<groupId>org.apache.maven.plugins</groupId>
	<artifactId>maven-war-plugin</artifactId>
	<configuration>
		<archive>
			<addMavenDescriptor>false</addMavenDescriptor>
		</archive>
		<webResources>
			<resource>
				<!-- this is relative to the pom.xml directory -->
				<directory>src/main/resources/${package.environment}</directory>
				<targetPath>WEB-INF/classes</targetPath>
				<filtering>true</filtering>
			</resource>
		</webResources>
	</configuration>
</plugin>
~~~~

###源码打包插件
~~~~
<plugin>
    <groupId>org.apache.maven.plugins</groupId>
    <artifactId>maven-source-plugin</artifactId>
    <version>2.2.1</version>
    <executions>
        <execution>
            <id>attach-sources</id>
            <goals>
                <goal>jar</goal>
            </goals>
        </execution>
    </executions>
</plugin>
~~~~

###JavaDoc文档插件
~~~~
<plugin>
	<groupId>org.apache.maven.plugins</groupId>
	<artifactId>maven-javadoc-plugin</artifactId>
	<version>3.2</version>
	<configuration>
		<charset>UTF-8</charset>
		<encoding>UTF-8</encoding>
	</configuration>
</plugin>
~~~~

