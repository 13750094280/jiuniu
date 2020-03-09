<?xml version="1.0"?>
<project
	xsi:schemaLocation="http://maven.apache.org/POM/4.0.0 http://maven.apache.org/xsd/maven-4.0.0.xsd"
	xmlns="http://maven.apache.org/POM/4.0.0"
	xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance">
	<modelVersion>4.0.0</modelVersion>
	<parent>
		<groupId>cn.nineox</groupId>
		<artifactId>shuqitong</artifactId>
		<version>1.0-SNAPSHOT</version>
	</parent>
	<artifactId>${project.artifactId!}-web</artifactId>
	<name>${project.artifactId!}-web</name>
	<url>http://maven.apache.org</url>
	<properties>
		<project.build.sourceEncoding>UTF-8</project.build.sourceEncoding>
		<maven-jar-plugin.version>3.1.1</maven-jar-plugin.version>
	</properties>
	<dependencies>
		<dependency>
			<groupId>junit</groupId>
			<artifactId>junit</artifactId>
			<scope>test</scope>
		</dependency>

		<dependency>
			<groupId>cn.nineox</groupId>
			<artifactId>shuqitong-common</artifactId>
			<version>1.0-SNAPSHOT</version>
		</dependency>
		<dependency>
			<groupId>${project.groupId!}</groupId>
			<artifactId>${project.artifactId!}</artifactId>
			<version>1.0-SNAPSHOT</version>
		</dependency>

		<dependency>
			<groupId>cn.nineox</groupId>
			<artifactId>shuqitong-sso-api</artifactId>
			<version>1.0-SNAPSHOT</version>
		</dependency>



		<!-- actuator监控引入 -->
		<dependency>
			<groupId>org.springframework.boot</groupId>
			<artifactId>spring-boot-starter-actuator</artifactId>
		</dependency>

		<!-- 云部署时，打开注释 <dependency> <groupId>org.springframework.cloud</groupId> 
			<artifactId>spring-cloud-starter-openfeign</artifactId> </dependency> <dependency> 
			<groupId>org.springframework.cloud</groupId> <artifactId>spring-cloud-starter-netflix-eureka-client</artifactId> 
			</dependency> -->

		<!-- 云部署时，注释掉 -->
		<dependency>
			<groupId>org.springframework.boot</groupId>
			<artifactId>spring-boot-starter-web</artifactId>
		</dependency>

		<dependency>
			<groupId>org.springframework.boot</groupId>
			<artifactId>spring-boot-starter-aop</artifactId>
		</dependency>

		<dependency>
			<groupId>org.springframework.session</groupId>
			<artifactId>spring-session-data-redis</artifactId>
		</dependency>

		<dependency>
			<groupId>com.github.jsonzou</groupId>
			<artifactId>jmockdata</artifactId>
			<version>4.1.2</version>
		</dependency>

		<dependency>
			<groupId>org.springframework.boot</groupId>
			<artifactId>spring-boot-starter-test</artifactId>
		</dependency>

		<dependency>
			<groupId>commons-io</groupId>
			<artifactId>commons-io</artifactId>
			<version>2.6</version>
		</dependency>

		<dependency>
			<groupId>commons-codec</groupId>
			<artifactId>commons-codec</artifactId>
			<scope>provided</scope>
			<version>1.9</version><!--$NO-MVN-MAN-VER$ -->
		</dependency>

		<dependency>
			<groupId>org.projectlombok</groupId>
			<artifactId>lombok</artifactId>
		</dependency>

		<dependency>
			<groupId>cn.hutool</groupId>
			<artifactId>hutool-all</artifactId>
			<version>4.5.10</version>
		</dependency>



		<dependency>
			<groupId>com.github.javaparser</groupId>
			<artifactId>javaparser-core</artifactId>
			<version>3.6.5</version>
		</dependency>

		<dependency>
			<groupId>com.github.javaparser</groupId>
			<artifactId>javaparser-symbol-solver-core</artifactId>
			<version>3.6.5</version>
		</dependency>

		<!-- <dependency> <groupId>com.taobao</groupId> <artifactId>sdk</artifactId> 
			<version>1.0</version> </dependency> -->
		<dependency>
			<groupId>org.springframework.boot</groupId>
			<artifactId>spring-boot-starter-data-redis</artifactId>
		</dependency>


		<!-- mysql -->
		<dependency>
			<groupId>mysql</groupId>
			<artifactId>mysql-connector-java</artifactId>
		</dependency>

		<!-- mybatis -->
		<dependency>
			<groupId>com.baomidou</groupId>
			<artifactId>mybatis-plus-boot-starter</artifactId>
		</dependency>

		<dependency>
			<groupId>com.alibaba</groupId>
			<artifactId>druid-spring-boot-starter</artifactId>
		</dependency>

		<dependency>
			<groupId>com.alibaba</groupId>
			<artifactId>fastjson</artifactId>
		</dependency>

		<dependency>
			<groupId>org.mybatis</groupId>
			<artifactId>mybatis-typehandlers-jsr310</artifactId>
		</dependency>

		<!-- generator -->
		<dependency>
			<groupId>com.baomidou</groupId>
			<artifactId>mybatis-plus-generator</artifactId>
		</dependency>

		<!-- https://mvnrepository.com/artifact/com.fasterxml.jackson.core/jackson-databind -->
		<dependency>
			<groupId>com.fasterxml.jackson.core</groupId>
			<artifactId>jackson-databind</artifactId>
		</dependency>

		<!-- https://mvnrepository.com/artifact/org.apache.commons/commons-lang3 -->
		<dependency>
			<groupId>org.apache.commons</groupId>
			<artifactId>commons-lang3</artifactId>
		</dependency>
		<!-- 二维码 -->
		<dependency>
			<groupId>com.google.zxing</groupId>
			<artifactId>core</artifactId>
			<version>3.3.0</version>
		</dependency>




	</dependencies>

	<profiles>
		<profile>
			<id>shuqitong</id>
			<properties>
				<package.environment>shuqitong</package.environment>
			</properties>
		</profile>
	</profiles>

	<build>
		<plugins>
			<plugin>
				<groupId>org.springframework.boot</groupId>
				<artifactId>spring-boot-maven-plugin</artifactId>

				<configuration>
					<!--fork : 如果没有该项配置，devtools不会起作用，即应用不会restart -->
					<fork>true</fork>
					<addResources>true</addResources>
					<mainClass>${pkg!}.${project.name!}WebApplication</mainClass>
				</configuration>
				<executions>
					<execution>
						<goals>
							<goal>repackage</goal>
						</goals>
					</execution>
				</executions>
			</plugin>

			<!-- 不同环境的配置文件选择 -->
			<plugin>
				<groupId>org.apache.maven.plugins</groupId>
				<artifactId>maven-resources-plugin</artifactId>
				<executions>
					<execution>
						<id>copy-resources</id>
						<phase>compile</phase>
						<goals>
							<goal>copy-resources</goal>
						</goals>
						<configuration>
							<!-- 覆盖原有文件 -->
							<overwrite>true</overwrite>
							<outputDirectory>target/classes</outputDirectory>
							<!-- 也可以用下面这样的方式（指定相对url的方式指定outputDirectory） <outputDirectory>target/classes</outputDirectory> -->
							<!-- 待处理的资源定义 -->
							<resources>
								<resource>
									<!-- 指定resources插件处理哪个目录下的资源文件 -->
									<directory>src/main/resources/${r'package.environment'}</directory>
									<filtering>false</filtering>
								</resource>
							</resources>
						</configuration>
						<inherited></inherited>
					</execution>
				</executions>
			</plugin>
			<plugin>
				<groupId>cn.nineox</groupId>
				<artifactId>jn-maven-plugin</artifactId>
				<configuration>
					<outDir>${r'basedir'}/src/main/java</outDir>
					<jdbcUrl>jdbc:mysql://localhost:3306/sqt_beetles</jdbcUrl>
					<user>root</user>
					<pass>aa</pass>
					<pkg>cn.nineox.shuqitong.beetles</pkg>
					<prefix>btl</prefix>
				</configuration>
			</plugin>

		</plugins>

		<resources>
			<resource>
				<directory>src/main/java</directory>
				<filtering>false</filtering>
				<includes>
					<include>**/*.xml</include>
				</includes>
			</resource>
		</resources>
	</build>
</project>
