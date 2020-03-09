package ${project.pkg!}.common.config;

import java.lang.reflect.Method;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.jboss.logging.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.method.HandlerMethod;
import org.springframework.web.servlet.HandlerInterceptor;

import com.baomidou.kisso.SSOHelper;
import com.baomidou.kisso.security.token.SSOToken;

import cn.nineox.shuqitong.common.framework.xparam.notlogin.NoLogin;
import cn.nineox.shuqitong.common.framework.xparam.notlogin.NotLoginException;
import cn.nineox.shuqitong.common.token.service.TokenService;

public class ParamHandlerInterceptor implements HandlerInterceptor {

	@Autowired
	private TokenService tokenService;

	Logger logger = Logger.getLogger(ParamHandlerInterceptor.class);

	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler)
			throws Exception {
		// 如果不是映射到方法直接通过
		if (!(handler instanceof HandlerMethod)) {
			return true;
		}
		HandlerMethod handlerMethod = (HandlerMethod) handler;
		Method method = handlerMethod.getMethod();
		// 判断接口是否需要登录
		NoLogin noLogin = method.getAnnotation(NoLogin.class);
		// 有 @LoginRequired 注解，需要认证
		// System.out.println("notLogin:" + noLogin + ",method:" + method.getName());
		if (noLogin != null) {
			return true;
		} else {
			// 判断是否存在令牌信息，如果存在，则允许登录

			SSOToken token = SSOHelper.getSSOToken(request);
			if (token == null) {
				throw new NotLoginException("无token，请重新登录");
			}

			return true;
		}

	}

}
