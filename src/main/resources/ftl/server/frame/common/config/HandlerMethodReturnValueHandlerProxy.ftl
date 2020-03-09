package ${project.pkg!}.common.config;

import java.util.HashMap;
import java.util.Map;

import org.springframework.core.MethodParameter;
import org.springframework.web.context.request.NativeWebRequest;
import org.springframework.web.method.support.HandlerMethodReturnValueHandler;
import org.springframework.web.method.support.ModelAndViewContainer;

public class HandlerMethodReturnValueHandlerProxy implements HandlerMethodReturnValueHandler {
	private HandlerMethodReturnValueHandler proxyObject;

	public HandlerMethodReturnValueHandlerProxy(HandlerMethodReturnValueHandler proxyObject) {
		this.proxyObject = proxyObject;
	}

	@Override
	public boolean supportsReturnType(MethodParameter returnType) {
		return proxyObject.supportsReturnType(returnType);
	}

	@Override
	public void handleReturnValue(Object returnValue, MethodParameter returnType, ModelAndViewContainer mavContainer,
			NativeWebRequest webRequest) throws Exception {
		Map<String, Object> resultMap = new HashMap<>();

		resultMap.put("status", STATUS_CODE_SUCCEEDED);
		resultMap.put("message", "");
		resultMap.put("data", returnValue);
		
		proxyObject.handleReturnValue(resultMap, returnType, mavContainer, webRequest);
	}

	private static final String STATUS_CODE_SUCCEEDED = "success";
}
