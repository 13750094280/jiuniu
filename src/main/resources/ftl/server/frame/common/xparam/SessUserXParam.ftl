package ${project.pkg!}.common.xparam;

import javax.servlet.http.HttpServletRequest;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.MethodParameter;
import org.springframework.stereotype.Service;

import com.baomidou.kisso.SSOHelper;
import com.baomidou.kisso.security.token.SSOToken;
import com.baomidou.mybatisplus.core.toolkit.StringUtils;

import cn.nineox.shuqitong.common.framework.xparam.SessKey;
import cn.nineox.shuqitong.common.framework.xparam.SessUser;
import cn.nineox.shuqitong.common.framework.xparam.XParam;
import cn.nineox.shuqitong.common.framework.xparam.notlogin.LoginUtil;
import cn.nineox.shuqitong.common.token.service.TokenService;
import io.jsonwebtoken.Claims;

/**
 * 获取session中的uid.
 * 
 * @author 阿海
 * 
 */
@Service
public class SessUserXParam implements XParam {

	@Autowired
	private TokenService tokenService;

	protected Log logger = LogFactory.getLog(this.getClass());

	@Override
	public Object getValue(HttpServletRequest request, MethodParameter parameter) {
		// 分布式session还不够好，Long类型存进去再拿出来会变成Integer，这里做兼容

		SessUser sessUser = null;
		SSOToken token = SSOHelper.getSSOToken(request);

		if (token != null) {
			Claims claims = token.getClaims();
			if (claims != null) {
				sessUser = new SessUser();
				sessUser.setUid(claims.get("uid", String.class));
				sessUser.setUname(claims.get("uname", String.class));
				sessUser.setHeadpic(claims.get("headpic", String.class));
				//sessUser.setDept(claims.get("dept", Boolean.class));
				sessUser.setDeptId(claims.get("deptId", String.class));
				sessUser.setDeptName(claims.get("deptName", String.class));
				sessUser.setDeptBsid(claims.get("deptBsid", String.class));
				sessUser.setOrgId(claims.get("orgId", String.class));
				sessUser.setOrgName(claims.get("orgName", String.class));
				sessUser.setOrgBsid(claims.get("orgBsid", String.class));				
				sessUser.setEnterpriseId(claims.get("enterpriseId",String.class));
				sessUser.setEnterpriseCode(claims.get("enterpriseCode",String.class));
			}
			
		}

		// String json = tokenService.get(token.getId());

//		if (StringUtils.isNotEmpty(json)) {
//			sessUser = JSON.parseObject(json, SessUser.class);
//		}
		if (sessUser == null || StringUtils.isEmpty(sessUser.getUid())) {
			return LoginUtil.isLogin(request, parameter);
		}
		return sessUser;

	}

	@Override
	public String getKey() {
		return SessKey.sessUser;
	}
}