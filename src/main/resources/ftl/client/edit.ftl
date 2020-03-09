<!-- 订单列表编辑页 -->
<template>
  <el-dialog class="user-defined-dialog channel-dialog" @close="resetFields" append-to-body :title="isEdit?'编辑${clazz.comment!}':'新增${clazz.comment!}'" :visible.sync="dialogVisible" :close-on-click-modal="false" width="550px">

    <div class="details">
      <el-form ref="editForm" :model="form" :rules="rules" label-width="80px">
		<#list clazz.fieldList as field>
        <el-form-item label="${field.comment!}" prop="name">
          <el-input v-model="form.${field.flName!}" autocomplete="off"></el-input>
        </el-form-item>
        </#list>
      </el-form>

    </div>

    <div slot="footer" class="dialog-footer">      
      <el-button type="primary" @click="save">保 存</el-button>
      <el-button @click="dialogVisible =false">取 消</el-button>
    </div>
  </el-dialog>
</template>

<script>
import imgUpload from '../../components/common/modules/headUpload'
export default {
  data() {
    return {
      isEdit: false,
      dialogVisible: false,
      productList: [],
      form: {
      },
      attachmentList: [],
      rules: {
       
      },
      appInfo: this.$store.getters.AppInfo || {
        user: {}
      },
    };
  },
  components: {
    imgUpload
  },
  computed: {
  },
  created() {
    this.init();
  },

  methods: {
    updateIcon(val) {
      this.$set(this.form, "facePic", val);
    },
    resetFields() {
      this.form = {
        
      };
    },
    init() {
      this.$on("add", function () {
        this.form.id = ''
        this.isEdit = false;
        this.dialogVisible = true;
      });
      this.$on("update", function (id) {
        this.form.id = id;
        this.get();
        this.isEdit = true;
        this.dialogVisible = true;        
      });
    },
    get() {
      this.$api.get('/${clazz.flName!}/get', {
        id: this.form.id
      }).then(res => {
        if (res) {         
          this.form = res
        }
      })
    },
    // 保存
    save() {
      this.$refs['editForm'].validate((valid) => {
        if (valid) {
          this.$api.post("/channel/save", this.form).then(res => {
            if (res) {
              this.$api.success();
              this.dialogVisible = false;
              this.resetFields();
              this.$parent.doQuery()
              this.backList();
            }
          })
        }
      })
    },
    backList() {
      this.$router.push("/${clazz.flName!}");
    }
  }
}
</script>

<style lang="less" scoped>
@import "../../assets/css/edit";
</style>
