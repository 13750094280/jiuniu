package cn.nineox.jiuniu.coding;

import java.util.ArrayList;
import java.util.List;

import javax.sql.DataSource;

import org.apache.commons.lang3.StringUtils;

import com.alibaba.druid.pool.DruidDataSource;

import cn.hutool.core.collection.CollectionUtil;
import cn.hutool.db.meta.MetaUtil;
import cn.hutool.db.meta.Table;

public class Mysql {

	private DataSource ds;

	private String jdbcUrl;

	private String user;

	private String pass;

	public void init(String jdbcUrl, String user, String pass) {
		this.jdbcUrl = jdbcUrl + "?useUnicode=true&characterEncoding=utf8&useSSL=false&zeroDateTimeBehavior=convertToNull&serverTimezone=Asia/Shanghai";
		this.user = user;
		this.pass = pass;
	}

	public DataSource getDs() {
		if (ds == null) {
			DruidDataSource ds = new DruidDataSource();
			ds.setUrl(jdbcUrl);
			ds.setUsername(user);
			ds.setPassword(pass);
			this.ds = ds;
		}
		return this.ds;
	}

	public List<Table> listByTable(String table) {
		List<Table> result = new ArrayList<Table>();
		List<String> tbList = new ArrayList<String>();
		if (StringUtils.isNotEmpty(table)) {
			String[] tables = table.split(",");
			for (String str : tables) {
				tbList.add(str);
			}
		} else {
			tbList = MetaUtil.getTables(this.getDs());
		}
		if (CollectionUtil.isNotEmpty(tbList)) {
			for (String str : tbList) {
				result.add(MetaUtil.getTableMeta(this.getDs(), str));
			}
		}
		return result;
	}

}
