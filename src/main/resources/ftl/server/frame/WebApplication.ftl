package ${project.pkg!};

import org.mybatis.spring.annotation.MapperScan;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.context.annotation.ComponentScan;

@SpringBootApplication
//@EnableDiscoveryClient
@ComponentScan(value = "cn.nineox")
@MapperScan("cn.nineox.**.dao")
//@EnableFeignClients
public class ${project.name!}WebApplication {

    protected static boolean isProd(String[] args) {
        // --spring.profiles.active=prod
        for (String arg : args) {
            if ("--spring.profiles.active=prod".equals(arg)) {
                return true;
            }
        }
        return false;
    }

    protected static boolean isTest(String[] args) {
        // --spring.profiles.active=prod
        for (String arg : args) {
            if ("--spring.profiles.active=test".equals(arg)) {
                return true;
            }
        }
        return false;
    }

    protected static boolean isNineOxTest(String[] args) {
        // --spring.profiles.active=prod
        for (String arg : args) {
            if ("--spring.profiles.active=oxtest".equals(arg)) {
                return true;
            }
        }
        return false;
    }

    public static void main(String[] args) {
        boolean isProd = isProd(args);
        boolean isTest = isTest(args);
        boolean isNineOxTest = isNineOxTest(args);

        SpringApplication app = new SpringApplication(${project.name!}WebApplication.class);
        // 启动dev配置文件
        if (isProd) {
            app.setAdditionalProfiles("prod"); // dev 或prod
        }
        if (isTest) {
            app.setAdditionalProfiles("test"); // dev 或prod
        }
        if (isNineOxTest) {
            app.setAdditionalProfiles("oxtest"); // dev 或prod
        }
        app.run();
    }
}
