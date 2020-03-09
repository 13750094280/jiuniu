package ${clazz.pkg!}.web.controller.${clazz.flName!};

import java.util.List;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.beans.BeanUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.util.Assert;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;

import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.core.toolkit.StringUtils;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;


import ${clazz.pkg!}.service.${clazz.flName!}.${clazz.fuName!};
import ${clazz.pkg!}.service.${clazz.flName!}.${clazz.fuName!}Service;
import cn.nineox.shuqitong.common.framework.OxConst;
import cn.nineox.shuqitong.common.framework.bean.OxPage;
import cn.nineox.shuqitong.common.framework.util.PageUtil;
import cn.nineox.shuqitong.common.framework.util.PkUtil;
import cn.nineox.shuqitong.common.framework.xparam.SessUser;

/**
 * <p>
 * ${clazz.comment!}
 * </p>
 *
 * @author luxh
 * @since ${clazz.date!}
 */
@RestController
@RequestMapping("/${clazz.flName!}")
public class ${clazz.fuName!}Controller {

	Log logger = LogFactory.getLog(${clazz.fuName!}Controller.class);

	@Autowired
	private ${clazz.fuName!}Service ${clazz.flName!}Service;

	
	@RequestMapping(value = "/page")
	public OxPage<${clazz.fuName!}> page(SessUser sessUser, @RequestBody ${clazz.fuName!}Query query) {
		QueryWrapper<${clazz.fuName!}> queryWrapper = new QueryWrapper<${clazz.fuName!}>();
		queryWrapper.eq("orgId", sessUser.getOrgId());
		queryWrapper.orderByDesc("oxCtime");
		IPage<${clazz.fuName!}> page = ${clazz.flName!}Service.page(new Page<${clazz.fuName!}>(query.getStart(), query.getSize()), queryWrapper);
		return PageUtil.convert(page, ${clazz.fuName!}.class);
	}

	@Transactional
	@RequestMapping(value = "/save")
	public boolean save(@RequestBody ${clazz.fuName!}Form form) {
		${clazz.fuName!} ${clazz.flName!} = new ${clazz.fuName!}();
		if (StringUtils.isNotEmpty(form.getId())) {
			${clazz.flName!} = ${clazz.flName!}Service.getById(form.getId());
			BeanUtils.copyProperties(form, ${clazz.flName!}, OxConst.ignoreProperties);
			${clazz.flName!}Service.saveOrUpdate(${clazz.flName!});
		} else {
			BeanUtils.copyProperties(form, ${clazz.flName!});
			${clazz.flName!}.setId(PkUtil.getId());
			${clazz.flName!}Service.save(${clazz.flName!});
		}
		return true;
	}

	@PostMapping(value = "/delete")
	public boolean delete(@RequestBody String id) {
		Assert.notNull(id, "ID不能为空");
		return ${clazz.flName!}Service.removeById(id);
	}

	@RequestMapping(value = "/get")
	public ${clazz.fuName!}VO get(String id) {
		${clazz.fuName!}VO vo = new ${clazz.fuName!}VO();
		${clazz.fuName!} ${clazz.flName!} = ${clazz.flName!}Service.getById(id);
		BeanUtils.copyProperties(${clazz.flName!}, vo);
		return vo;
	}

}
