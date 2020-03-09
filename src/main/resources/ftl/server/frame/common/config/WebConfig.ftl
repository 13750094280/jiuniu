package ${project.pkg!}.common.config;

import java.util.List;

import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.web.method.support.HandlerMethodArgumentResolver;
import org.springframework.web.servlet.config.annotation.InterceptorRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurationSupport;

import com.baomidou.kisso.web.interceptor.SSOSpringInterceptor;
import com.baomidou.mybatisplus.extension.plugins.PaginationInterceptor;
import com.baomidou.mybatisplus.extension.plugins.PerformanceInterceptor;

import cn.nineox.shuqitong.common.framework.xparam.resolver.XParamHandlerMethodArgumentResolver;

@Configuration
public class WebConfig extends WebMvcConfigurationSupport {

	@Bean
	public PaginationInterceptor paginationInterceptor() {
		PaginationInterceptor paginationInterceptor = new PaginationInterceptor();
		return paginationInterceptor;
	}

	@Bean
	public XParamHandlerMethodArgumentResolver resolver() {
		return new XParamHandlerMethodArgumentResolver();
	}

	@Override
	protected void addArgumentResolvers(List<HandlerMethodArgumentResolver> argumentResolvers) {
		argumentResolvers.add(this.resolver());
	}

	/**
	 * mybatis-plus SQL执行效率插件【生产环境可以关闭】
	 */
	@Bean
	public PerformanceInterceptor performanceInterceptor() {
		return new PerformanceInterceptor();
	}

	@Bean
	public ParamHandlerInterceptor paramHandlerInterceptor() {
		return new ParamHandlerInterceptor();
	}

//	@Bean
//	public SSOSpringInterceptor ssoSpringInterceptor() {
//		return new SSOSpringInterceptor();
//	}

	@Override
	protected void addInterceptors(InterceptorRegistry registry) {
//		registry.addInterceptor(this.ssoSpringInterceptor()).addPathPatterns("/**/*")
//				.excludePathPatterns("/sso/login").excludePathPatterns("/sysIndustry/*");
		registry.addInterceptor(this.paramHandlerInterceptor());
		super.addInterceptors(registry);
	}

}
