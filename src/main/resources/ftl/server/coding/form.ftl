package ${clazz.pkg!}.web.controller.${clazz.flName!};

import java.util.List;

import com.fasterxml.jackson.databind.annotation.JsonSerialize;

import lombok.Data;
import java.util.Date;

/**
 * <p>
 * ${clazz.comment!} 
 * </p>
 *
 * @author luxh
 * @since ${clazz.date!}
 */
@Data
public class ${clazz.fuName!}Form {
	
	<#list clazz.fieldList as field>
	/**
	 * ${field.comment!}
	 */
	private ${field.type} ${field.flName};
	</#list>

}
