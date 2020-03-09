
<#list clazzList as clazz>
import ${clazz.flName!}Routes from "../page/${clazz.flName!}/config/routes";
</#list>



<#list clazzList as clazz1>
...${clazz1.flName!}Routes,
</#list>