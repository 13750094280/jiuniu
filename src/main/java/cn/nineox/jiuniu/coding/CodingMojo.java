package cn.nineox.jiuniu.coding;

import java.io.BufferedWriter;
import java.io.File;
import java.io.FileOutputStream;
import java.io.OutputStreamWriter;
import java.io.Writer;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.maven.plugin.AbstractMojo;
import org.apache.maven.plugin.MojoExecutionException;
import org.apache.maven.plugin.MojoFailureException;
import org.apache.maven.plugins.annotations.Mojo;
import org.apache.maven.plugins.annotations.Parameter;

import cn.hutool.core.io.FileUtil;
import cn.hutool.db.meta.Table;
import cn.nineox.jiuniu.FtlFile;
import cn.nineox.jiuniu.coding.source.Clazz;
import cn.nineox.jiuniu.coding.source.CodingSevice;
import freemarker.template.Configuration;
import freemarker.template.Template;

@Mojo(name = "coding")
public class CodingMojo extends AbstractMojo {
	// prefix="jdbc:mysql://localhost:3306/sqt_promotion";

	@Parameter(name = "jdbcUrl")
	private String jdbcUrl;

	@Parameter(name = "user")
	private String user;

	@Parameter(name = "pass")
	private String pass;

	@Parameter(name = "outDir")
	private String outDir;

	@Parameter(name = "pkg")
	private String pkg;

	@Parameter(name = "tables", defaultValue = "")
	private String tables;

	@Parameter(name = "prefix", defaultValue = "")
	private String prefix;

	public void execute() throws MojoExecutionException, MojoFailureException {
		Mysql mysql = new Mysql();
		mysql.init(jdbcUrl, user, pass);
		List<Table> list = mysql.listByTable(this.tables);
		List<Clazz> clazzList = new ArrayList<Clazz>();
		for (Table table : list) {
			Clazz clazz = CodingSevice.get(outDir, pkg, prefix, table);
			this.write(clazz);
			clazzList.add(clazz);
		}
		//
		String clientBasePath = outDir.replace("/src/main/java", "");
		FtlFile file = new FtlFile("/ftl/client", "route.ftl", clientBasePath + "/webapp/route.vue");
		this.write(clazzList, file);

	}

	public void write(List<Clazz> list, FtlFile file) {
		try {
			// 第一步：创建一个Configuration对象，直接new一个对象。构造方法的参数就是freemarker对于的版本号。
			Configuration configuration = new Configuration(Configuration.getVersion());
			// 第二步：设置模板文件所在的路径。

			// 第三步：设置模板文件使用的字符集。一般就是utf-8.
			configuration.setDefaultEncoding("utf-8");
			configuration.setClassForTemplateLoading(CodingMojo.class, file.getFtlPath());
			Template template = configuration.getTemplate(file.getFtl());
			// 第四步：加载一个模板，创建一个模板对象。
			// 第五步：创建一个模板使用的数据集，可以是pojo也可以是map。一般是Map。
			Map<String, Object> dataModel = new HashMap<String, Object>();
			// 向数据集中添加数据
			dataModel.put("clazzList", list);
			// 第六步：创建一个Writer对象，一般创建一FileWriter对象，指定生成的文件名。
			FileUtil.mkdir(file.getTargetPath());
			File src = new File(file.getTarget());
			if (!src.exists()) {
				// FileUtil.mkdir(dirPath)
				Writer out = new BufferedWriter(new OutputStreamWriter(new FileOutputStream(file.getTarget(), true), "UTF-8"));
				// Writer out = new FileWriter(file.getJava());
				// 第七步：调用模板对象的process方法输出文件。
				template.process(dataModel, out);
				// 第八步：关闭流。
				out.close();
			}

		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	public void write(Clazz clazz) {
		try {
			// 第一步：创建一个Configuration对象，直接new一个对象。构造方法的参数就是freemarker对于的版本号。
			Configuration configuration = new Configuration(Configuration.getVersion());
			// 第二步：设置模板文件所在的路径。

			// 第三步：设置模板文件使用的字符集。一般就是utf-8.
			configuration.setDefaultEncoding("utf-8");

			for (FtlFile file : clazz.getFileList()) {
				configuration.setClassForTemplateLoading(CodingMojo.class, file.getFtlPath());
				Template template = configuration.getTemplate(file.getFtl());
				// 第四步：加载一个模板，创建一个模板对象。
				// 第五步：创建一个模板使用的数据集，可以是pojo也可以是map。一般是Map。
				Map<String, Clazz> dataModel = new HashMap<String, Clazz>();
				// 向数据集中添加数据
				dataModel.put("clazz", clazz);
				// 第六步：创建一个Writer对象，一般创建一FileWriter对象，指定生成的文件名。
				FileUtil.mkdir(file.getTargetPath());
				File src = new File(file.getTarget());
				if (!src.exists()) {
					// FileUtil.mkdir(dirPath)
					Writer out = new BufferedWriter(new OutputStreamWriter(new FileOutputStream(file.getTarget(), true), "UTF-8"));
					// Writer out = new FileWriter(file.getJava());
					// 第七步：调用模板对象的process方法输出文件。
					template.process(dataModel, out);
					// 第八步：关闭流。
					out.close();
				}
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

}
