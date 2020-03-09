package cn.nineox.jiuniu.coding.source;

import java.util.Date;
import java.util.List;

import cn.hutool.core.date.DateUtil;
import cn.nineox.jiuniu.FtlFile;
import lombok.Data;

@Data
public class Clazz {
	
	private String tbName;
	
	private String flName;

	private String fuName;

	private String pkg;

	private String comment;

	private List<Field> fieldList;

	private List<FtlFile> fileList;

	private String date = DateUtil.format(new Date(), "yyyy/MM/dd");

}
