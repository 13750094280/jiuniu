import tools from "../../../assets/javascript/tools.js";
export default {
  columns: {
  	<#list clazz.fieldList as field>
	  ${field.flName}: {
        label: "${field.comment!}",
        visible: true,
        width: "auto",
        align: "left"
      },
	</#list>
  }
};
