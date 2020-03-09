package cn.nineox.jiuniu.coding.source;

import java.util.ArrayList;
import java.util.Collection;
import java.util.List;

import cn.hutool.core.collection.CollectionUtil;
import cn.hutool.core.util.ArrayUtil;
import cn.hutool.db.meta.Column;
import cn.hutool.db.meta.Table;
import cn.nineox.jiuniu.FtlFile;
import cn.nineox.jiuniu.FtlUtil;

public class CodingSevice {

	public static Clazz get(String outDir, String pkg, String prefix, Table table) {
		Clazz clazz = new Clazz();
		clazz.setPkg(pkg);
		clazz.setFuName(FtlUtil.getFuName(prefix, table.getTableName()));
		clazz.setFlName(FtlUtil.getFlName(prefix, table.getTableName()));
		List<Field> fieLdList = new ArrayList<Field>();
		clazz.setFieldList(fieLdList);

		clazz.setComment(table.getComment());
		clazz.setTbName(table.getTableName());
		// clazz.init(outDir, pkg);
		List<FtlFile> fileList = new ArrayList<FtlFile>();
		String basePath = FtlUtil.getBasePath(outDir, pkg);
		clazz.setFileList(fileList);
		fileList.add(new FtlFile("/ftl/server/coding", "dao.ftl", basePath + "/service/" + clazz.getFlName() + "/dao/" + clazz.getFuName() + "Dao.java"));
		fileList.add(new FtlFile("/ftl/server/coding", "bean.ftl", basePath + "/service/" + clazz.getFlName() + "/" + clazz.getFuName() + ".java"));
		fileList.add(new FtlFile("/ftl/server/coding", "service.ftl", basePath + "/service/" + clazz.getFlName() + "/" + clazz.getFuName() + "Service.java"));
		fileList.add(new FtlFile("/ftl/server/coding", "controller.ftl", basePath + "/web/controller/" + clazz.getFlName() + "/" + clazz.getFuName() + "Controller.java"));
		fileList.add(new FtlFile("/ftl/server/coding", "query.ftl", basePath + "/web/controller/" + clazz.getFlName() + "/" + clazz.getFuName() + "Query.java"));
		fileList.add(new FtlFile("/ftl/server/coding", "form.ftl", basePath + "/web/controller/" + clazz.getFlName() + "/" + clazz.getFuName() + "Form.java"));
		fileList.add(new FtlFile("/ftl/server/coding", "vo.ftl", basePath + "/web/controller/" + clazz.getFlName() + "/" + clazz.getFuName() + "VO.java"));
		pkg = clazz.getPkg().replace(".", "/");
		String clientBasePath = basePath.replace("/src/main/java", "").replace(pkg, "");
		fileList.add(new FtlFile("/ftl/client/config", "columns.ftl", clientBasePath + "/webapp/" + clazz.getFlName() + "/config/columns.js"));
		fileList.add(new FtlFile("/ftl/client/config", "routes.ftl", clientBasePath + "/webapp/" + clazz.getFlName() + "/config/routes.js"));
		fileList.add(new FtlFile("/ftl/client", "edit.ftl", clientBasePath + "/webapp/" + clazz.getFuName() + "/edit.vue"));
		fileList.add(new FtlFile("/ftl/client", "page.ftl", clientBasePath + "/webapp/" + clazz.getFuName() + "/page.vue"));

		// clazz.setFile(FtlUtil.getClazzFile(outDir, pkg, clazz.getName()));
		Collection<Column> columnList = table.getColumns();
		String[] ignore = { "oxTid", "oxCuid", "oxCtime", "oxCuname", "oxLtime", "oxLuid", "oxLuname", "deleted", "oxOrgId", "oxOrgBsid" };
		if (CollectionUtil.isNotEmpty(columnList)) {
			for (Column c : columnList) {
				if (ArrayUtil.contains(ignore, c.getName())) {
					continue;
				}
				Field field = new Field();
				field.setFlName(FtlUtil.getFlName("", c.getName()));
				field.setFuName(FtlUtil.getFuName("", c.getName()));
				field.setComment(c.getComment());
				field.setType(FtlUtil.getType(c.getTypeEnum()));
				fieLdList.add(field);
			}
		}
		return clazz;
	}
}
