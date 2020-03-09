package ${clazz.pkg!}.service.${clazz.flName!};

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import ${clazz.pkg!}.service.${clazz.flName!}.dao.${clazz.fuName!}Dao;
import cn.nineox.shuqitong.common.framework.base.OxServiceImpl;
/**
 * <p>
 * ${clazz.comment!} Service
 * </p>
 *
 * @author luxh
 * @since ${clazz.date!}
 */
 
@Service
public class ${clazz.fuName!}Service extends OxServiceImpl<${clazz.fuName!}Dao, ${clazz.fuName!}> {
	Log logger = LogFactory.getLog(${clazz.fuName!}Service.class);

	@Autowired
	private ${clazz.fuName!}Dao ${clazz.flName!}Dao;
}
