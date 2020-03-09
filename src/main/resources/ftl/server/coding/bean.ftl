package ${clazz.pkg!}.service.${clazz.flName!};

import com.baomidou.mybatisplus.annotation.TableField;
import com.baomidou.mybatisplus.annotation.TableName;
import com.fasterxml.jackson.databind.annotation.JsonSerialize;

import cn.nineox.shuqitong.common.framework.BaseModel;
import cn.nineox.shuqitong.common.framework.enums.OxEnumJsonSerializer;
import cn.nineox.shuqitong.common.framework.enums.Status;
import lombok.Data;
import lombok.EqualsAndHashCode;
import lombok.experimental.Accessors;
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
@EqualsAndHashCode(callSuper = false)
@Accessors(chain = true)
@TableName("${clazz.tbName!}")
public class ${clazz.fuName!} extends BaseModel {

	
	<#list clazz.fieldList as field>
	/**
	 * ${field.comment!}
	 */
	@TableField("${field.flName}")
	private ${field.type} ${field.flName};
	</#list>

}
