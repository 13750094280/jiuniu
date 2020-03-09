package cn.nineox.jiuniu.frame;

import java.io.BufferedWriter;
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
import cn.nineox.jiuniu.FtlFile;
import cn.nineox.jiuniu.FtlUtil;
import freemarker.template.Configuration;
import freemarker.template.Template;

@Mojo(name = "frame")
public class FrameMojo extends AbstractMojo {

	@Parameter(name = "artifactId")
	private String artifactId;

	@Parameter(name = "groupId")
	private String groupId;

	@Parameter(name = "outDir")
	private String outDir;

	@Parameter(name = "name")
	private String name;

	@Parameter(name = "pkg")
	private String pkg;

	public void execute() throws MojoExecutionException, MojoFailureException {
		// TODO Auto-generated method stub
		String mvnProject = (String) this.getPluginContext().get("project");
		String[] words = mvnProject.split(":");
		if (words[2].indexOf("-") == -1) {
			Project project = new Project();
			project.setArtifactId(artifactId);
			project.setGroupId(groupId);
			project.setName(name);
			project.setPkg(pkg);
			this.write(project, outDir);
		}

	}

	public void write(Project project, String outDir) {
		try {

			List<FtlFile> fileList = new ArrayList<FtlFile>();
			fileList.add(new FtlFile("/ftl/server/frame", "service-pom.ftl", outDir + "/" + project.getArtifactId() + "/pom.xml"));
			fileList.add(new FtlFile("/ftl/server/frame", "web-pom.ftl", outDir + "/" + project.getArtifactId() + "-web/pom.xml"));
			String webPath = outDir + "/" + project.getArtifactId() + "-web/src/main/java/";
			webPath += project.getPkg().replace(".", "/");
			webPath += FtlUtil.getFlName("", project.getName());
			fileList.add(new FtlFile("/ftl/server/frame", "WebApplication.ftl", webPath + "/" + project.getName() + "WebApplication.java"));
			fileList.add(new FtlFile("/ftl/server/frame/common/aspect", "EntityInfo.ftl", webPath + "/common/aspet/EntityInfo.java"));
			fileList.add(new FtlFile("/ftl/server/frame/common/aspect", "HttpAspect.ftl", webPath + "/common/aspet/HttpAspect.java"));
			fileList.add(new FtlFile("/ftl/server/frame/common/aspect", "OperatorAspect.ftl", webPath + "/common/aspet/OperatorAspect.java"));
			fileList.add(new FtlFile("/ftl/server/frame/common/config", "ExceptionControllerAdvice.ftl", webPath + "/common/config/ExceptionControllerAdvice.java"));
			fileList.add(new FtlFile("/ftl/server/frame/common/config", "HandlerMethodReturnValueHandlerProxy.ftl", webPath + "/common/config/HandlerMethodReturnValueHandlerProxy.java"));
			fileList.add(new FtlFile("/ftl/server/frame/common/config", "RedisConfig.ftl", webPath + "/common/config/RedisConfig.java"));
			fileList.add(new FtlFile("/ftl/server/frame/common/config", "RedisSessionConfig.ftl", webPath + "/common/config/RedisSessionConfig.java"));
			fileList.add(new FtlFile("/ftl/server/frame/common/config", "RestReturnValueHandlerConfigurer.ftl", webPath + "/common/config/RestReturnValueHandlerConfigurer.java"));
			fileList.add(new FtlFile("/ftl/server/frame/common/config", "WebConfig.ftl", webPath + "/common/config/WebConfig.java"));
			fileList.add(new FtlFile("/ftl/server/frame/common/listener", "TestRedisListener.ftl", webPath + "/common/listener/TestRedisListener.java"));
			fileList.add(new FtlFile("/ftl/server/frame/common/xparam", "SessUserXParam.ftl", webPath + "/common/listener/SessUserXParam.java"));
			for (FtlFile file : fileList) {
				writeFile(project, file);
			}

		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	private void writeFile(Project project, FtlFile file) {
		try {
			// 第一步：创建一个Configuration对象，直接new一个对象。构造方法的参数就是freemarker对于的版本号。
			Configuration configuration = new Configuration(Configuration.getVersion());
			// 第二步：设置模板文件所在的路径。
			configuration.setClassForTemplateLoading(FrameMojo.class, file.getFtlPath());
			// 第三步：设置模板文件使用的字符集。一般就是utf-8.
			configuration.setDefaultEncoding("utf-8");
			Template template = configuration.getTemplate(file.getFtl());
			// 第四步：加载一个模板，创建一个模板对象。

			// 第五步：创建一个模板使用的数据集，可以是pojo也可以是map。一般是Map。
			Map<String, Project> dataModel = new HashMap<String, Project>();
			// 向数据集中添加数据
			dataModel.put("project", project);

			// 第六步：创建一个Writer对象，一般创建一FileWriter对象，指定生成的文件名。
			FileUtil.mkdir(file.getTargetPath());

			// FileUtil.mkdir(dirPath)
			Writer out = new BufferedWriter(new OutputStreamWriter(new FileOutputStream(file.getTarget(), true), "UTF-8"));

			// Writer out = new FileWriter(file.getJava());
			// 第七步：调用模板对象的process方法输出文件。
			template.process(dataModel, out);
			// 第八步：关闭流。
			out.close();
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

}
