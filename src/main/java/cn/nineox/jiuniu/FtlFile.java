package cn.nineox.jiuniu;

import org.apache.commons.lang3.StringUtils;

import lombok.Data;

@Data

public class FtlFile {

	private String ftl;

	private String target;

	private String targetPath;

	private String ftlPath;

	public FtlFile(String ftlPath, String ftl, String target) {
		super();
		this.ftl = ftl;
		this.target = target;
		if (StringUtils.isNotEmpty(target)) {
			int index = target.lastIndexOf("/");
			if (index != -1) {
				this.targetPath = target.substring(0, index + 1);
			}
		}
		this.ftlPath = ftlPath;
	}

}
