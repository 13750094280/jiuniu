package cn.nineox.jiuniu;

import org.apache.commons.lang3.StringUtils;

import cn.hutool.db.meta.JdbcType;

public class FtlUtil {

	

	public static String getType(JdbcType type) {
		String result = "";
		if (type == JdbcType.VARCHAR || type == JdbcType.CHAR || type == JdbcType.LONGVARCHAR) {
			result = "String";
		} else if (type == JdbcType.TINYINT || type==JdbcType.BIT) {
			result = "Boolean";
		} else if (type == JdbcType.SMALLINT || type == JdbcType.INTEGER) {
			result = "int";
		} else if (type == JdbcType.FLOAT || type == JdbcType.NUMERIC || type == JdbcType.DOUBLE || type==JdbcType.DECIMAL) {
			result = "Double";
		} else if (type == JdbcType.BIGINT) {
			result = "long";
		} else if (type == JdbcType.TIMESTAMP || type == JdbcType.TIME_WITH_TIMEZONE || type == JdbcType.TIME) {
			result = "Date";
		}
		return result;
	}

	public static String getBasePath(String outDir, String pkg) {
		String basePath = "";
		pkg = pkg.replace(".", "/");
		if (outDir.endsWith("/")) {
			basePath = outDir + pkg;
		} else {
			basePath = outDir + "/" + pkg;
		}
		return basePath;
	}

	

	public static String getFlName(String prefix, String name) {
		name = name.replace(prefix + "_", "");
		name = FtlUtil.camelName(name);
		return name;
	}

	public static String getFuName(String prefix, String name) {
		name = name.replace(prefix + "_", "");
		name = FtlUtil.camelName(name);
		if (StringUtils.isNotEmpty(name)) {
			name = name.substring(0, 1).toUpperCase() + name.substring(1);
		}
		return name;
	}

	public static String camelName(String name) {
		StringBuilder result = new StringBuilder();
		// 快速检查
		if (name == null || name.isEmpty()) {
			// 没必要转换
			return "";
		} else if (!name.contains("_")) {
			// 不含下划线，仅将首字母小写
			return name.substring(0, 1).toLowerCase() + name.substring(1);
		}
		// 用下划线将原始字符串分割
		String camels[] = name.split("_");
		for (String camel : camels) {
			// 跳过原始字符串中开头、结尾的下换线或双重下划线
			if (camel.isEmpty()) {
				continue;
			}
			// 处理真正的驼峰片段
			if (result.length() == 0) {
				// 第一个驼峰片段，全部字母都小写
				result.append(camel.toLowerCase());
			} else {
				// 其他的驼峰片段，首字母大写
				result.append(camel.substring(0, 1).toUpperCase());
				result.append(camel.substring(1).toLowerCase());
			}
		}
		return result.toString();
	}

}
