# Tomcat
server:
    port: 8090
    connection-timeout: 5000
    servlet:
        context-path: /api
       


#datasource
spring:
    application:
        name: udb-web
    http:
        multipart: 
            maxFileSize: 50Mb
            maxRequestSize: 50Mb
    freemarker:
        template-loader-path: classpath:/templates
            
    jackson:
        date-format:yyyy-MM-dd HH:mm:ss
        time-zone:GMT+8
# jdbc:mysql://192.168.1.108:3306/jtcr_udb      9ox654321   
    datasource:
        name: website
        url: jdbc:mysql://127.0.0.1:3306/logistics_agent?useUnicode=true&characterEncoding=utf8&useSSL=false&zeroDateTimeBehavior=convertToNull&serverTimezone=Asia/Shanghai
        # url: jdbc:mysql://192.168.1.108:3306/logistics_agent?useUnicode=true&characterEncoding=utf8&useSSL=false&zeroDateTimeBehavior=convertToNull&serverTimezone=Asia/Shanghai
        username: root
        # password: 9ox654321
        password: root
        type: com.alibaba.druid.pool.DruidDataSource
        driver-class-name: com.mysql.jdbc.Driver
        initialSize: 5
        minIdle: 5
        maxActive: 20
        maxWait: 60000
        timeBetweenEvictionRunsMillis: 60000
        minEvictableIdleTimeMillis: 300000
        validationQuery: SELECT 1 FROM DUAL
        testWhileIdle: true
        testOnBorrow: false
        testOnReturn: false
        poolPreparedStatements: true
        maxPoolPreparedStatementPerConnectionSize: 20
        spring.datasource.filters: stat,wall,log4j
        connectionProperties: druid.stat.mergeSql=true;druid.stat.slowSqlMillis=5000
    #Redis数据库    
    redis:
        database: 0
        host: 127.0.0.1
        port: 6379
        password: 
        pool:
            max-active: 200
            max-wait: -1
            max-idle: 10
            min-idle: 0
        timeout: 1000 
        
# Mybatis-Plus 配置
mybatis-plus:
  mapper-locations: classpath*:cn/nineox/**/*Dao.xml
  type-aliases-package: cn.nineox.**.dao
  # 支持统配符 * 或者 ; 分割
  typeEnumsPackage: cn.nineox.**
  
management:
  endpoints:
    web:
      exposure:
        include: "*" #暴露所有节点
    health:
      sensitive: false #关闭过滤敏感信息
  endpoint:
    health:
      show-details: ALWAYS  #显示详细信息
  security:
    enabled: false
    
netp:
  upload:
    domain: http://182.61.25.98/file/
    dir: /data/upload/websie/file/

      
# 单点信息配置，全部可无
kisso:
  config:
    signkey: C691d971EJ3H376G81
    cookieName: kisso
    #cookieDomain: nineox.cn
    
nineox:
  menu-code: udb
  platform: 
    name: 星联供应链管理平台
    idCardNo: 999999999999999999
    manager: 平台管理员
    passport: superman
    mobile: 11111111111
  defaultPass: 123  
  appId: udb

qianzhan:
    appkey: 5f25aaf50228f0d2
    seckey: ea9fb2dcb84f9f56    
    url: https://api.qianzhan.com/OpenPlatformService  