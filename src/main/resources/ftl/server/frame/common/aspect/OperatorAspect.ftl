package ${project.pkg!}.common.aspect;

import java.util.Date;

import javax.servlet.http.HttpServletRequest;

import org.aspectj.lang.JoinPoint;
import org.aspectj.lang.annotation.Aspect;
import org.aspectj.lang.annotation.Before;
import org.springframework.stereotype.Component;

import com.baomidou.kisso.SSOHelper;
import com.baomidou.kisso.security.token.SSOToken;

import cn.nineox.shuqitong.common.framework.util.RequestUtil;
import cn.nineox.shuqitong.common.framework.xparam.SessUser;
import io.jsonwebtoken.Claims;

/**
 * 更新操作人拦截器
 * 
 */
@Aspect
@Component
public class OperatorAspect {

	
	/**
	 * 设置创建用户ID和最后更新人ID
	 */	
	@Before("execution(* com.baomidou.mybatisplus.extension.service.impl.ServiceImpl+.save(..)) || execution(* com.baomidou.mybatisplus.extension.service.impl.ServiceImpl+.saveOrUpdate(..))")
	public void add(JoinPoint joinPoint) {
		EntityInfo entityInfo = new EntityInfo(joinPoint);
		HttpServletRequest request = RequestUtil.getCurrentRequest();
		if (request != null) {
			try {
				SessUser user = this.getSessUser(request);
				if (user != null) {
					setBaseInfo(entityInfo, user);
				}

			} catch (Exception e) {
				e.printStackTrace();
			}
		}
	}

	private SessUser getSessUser(HttpServletRequest request) {
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
				sessUser.setEnterpriseId(claims.get("enterpriseId", String.class));
				sessUser.setEnterpriseCode(claims.get("enterpriseCode", String.class));
			}
		}
		return sessUser;
	}

	private void setBaseInfo(EntityInfo entityInfo, SessUser sessUser) {

		if (entityInfo.hasAnyField("oxCuid")) {
			if (entityInfo.getFieldValue("oxCuid") == null) {
				entityInfo.setFieldValue("oxCuid", sessUser.getUid());
			}
		}
		if (entityInfo.hasAnyField("oxCuname")) {
			if (entityInfo.getFieldValue("oxCuname") == null) {
				entityInfo.setFieldValue("oxCuname", sessUser.getUname());
			}
		}
		if (entityInfo.hasAnyField("oxCtime")) {
			if (entityInfo.getFieldValue("oxCtime") == null) {
				entityInfo.setFieldValue("oxCtime", new Date());
			}
		}

		if (entityInfo.hasAnyField("oxLuid")) {
			entityInfo.setFieldValue("oxLuid", sessUser.getUid());
		}
		if (entityInfo.hasAnyField("oxLuname")) {
			entityInfo.setFieldValue("oxLuname", sessUser.getUname());
		}
		if (entityInfo.hasAnyField("oxLtime")) {
			entityInfo.setFieldValue("oxLtime", new Date());
		}
	}

}