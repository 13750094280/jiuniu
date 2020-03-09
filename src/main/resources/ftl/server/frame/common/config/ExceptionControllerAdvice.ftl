package ${project.pkg!}.common.config;

import java.util.HashMap;
import java.util.Map;

import org.springframework.http.HttpStatus;
import org.springframework.web.bind.annotation.ControllerAdvice;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.ResponseStatus;

@ControllerAdvice
public class ExceptionControllerAdvice {

	@ResponseBody
	@ExceptionHandler(value = { Exception.class, RuntimeException.class })
	@ResponseStatus(code = HttpStatus.INTERNAL_SERVER_ERROR)
	public Map<String, Object> exceptionHandler(Exception ex) {
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("status", ex.getClass().getSimpleName());
		map.put("message", ex.getMessage());
		map.put("data", null);
		// 发生异常进行日志记录，写入数据库或者其他处理，此处省略
		ex.printStackTrace();
		return map;
	}
	
	
	//如果有其创异常可以再具体点写方法
}
