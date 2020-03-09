<!-- 示例页面 -->
<template>
<div class="app-wrap">
    <div class="title">
        <h1>${clazz.comment!}</h1>
        <div class="funRight">
            <!-- <el-button class="info btn funBtn" @click="$router.push('/channel/0')">新增</el-button> -->
            <el-button class="info btn funBtn" @click="add">新增</el-button>
            <el-tooltip class="item" effect="dark" content="刷新" placement="top">
                <button class="btn icoBtn" @click="reset" width="32px">
                    <img src="../../assets/images/shuaxin.svg">
                </button>
            </el-tooltip>
            <el-popover placement="bottom" trigger="click">
                <div class="filtrate">
                    <el-row>
                        <el-col :span="24" v-for="item in columns" :key="item.label">
                            <el-checkbox v-model="item.visible">
                                <span :class="item.visible?'selBox':'noBox'">{{item.label}}</span>
                            </el-checkbox>
                        </el-col>
                    </el-row>
                </div>
                <el-tooltip class="item" effect="dark" content="筛选" placement="top" slot="reference">
                    <button class="btn icoBtn" style="margin:0 10px">
                        <img src="../../assets/images/setting.svg">
                    </button>
                </el-tooltip>
            </el-popover>
            <el-tooltip class="item" effect="dark" content="导出" placement="top">
                <button class="btn icoBtn">
                    <img src="../../assets/images/zhaunfa.svg" class="zhaunfa">
                </button>
            </el-tooltip>
        </div>
    </div>
    <div class="fun fff p10 ">
        <div class="funLeft">
            <el-row :gutter="10">
                <el-col :span="16">
                    <el-input placeholder="名称" class="search" v-model="query.name" clearable></el-input>
                </el-col>
                <el-col :span="8">
                    <button class="theme btn" @click="doPageQuery">搜索</button>
                </el-col>
            </el-row>
        </div>
    </div>
    <div class="formTable fff p10">
        <el-table :data="list" border style="width: 100%" @row-dblclick="details" @selection-change="handleSelectionChange">
            <el-table-column type="index" label="序号" align="center" fixed="left">
            </el-table-column>
            <el-table-column :prop="index" :align="item.align" :label="item.label" :width="item.width" :formatter="item.formatter" show-overflow-tooltip v-for="(item,index) in columns" :key="index" v-if="item.visible">
                <template slot-scope="scope">
                    <span>
                        {{Boolean(item.formatter)?item.formatter(scope.row[index]):scope.row[index]}}
                    </span>
                </template>
            </el-table-column>
            <el-table-column prop="amt" label="操作" header-align="center" align="center" fixed="right" :resizable="false" width="100px">
                <template slot-scope="scope">
                    <el-link type="danger" @click="del(scope.row)" >删除</el-link>&nbsp;&nbsp;
                </template>
            </el-table-column>
        </el-table>
        <paging :totalCount="totalCount" @doPageQuery="doPageQuery"></paging>
    </div>


    <edit ref="editForm" ></edit>


</div>
</template>

<script>
import minxin from '../../assets/javascript/minxin.js'
import config from './config/columns'
import edit from "./edit";
export default {
    data() {
        return {
            input: '',
            form: {},
            url: "/${clazz.flName!}/page",
            dialogVisible: false,
            chooseList: [],
            columns: config.columns,
            list: [],
            appInfo: this.$store.getters.AppInfo||{
                user: {}
            },
        };
    },
    mixins: [minxin],

    components: {
        edit
    },
    computed: {
    },

    created() {
    },
    methods: {
        handleSelectionChange(val) {
            this.chooseList = val
        },
        del(row) {
            this.$confirm('确认删除选中的记录吗?', '提示', {
                confirmButtonText: '确定',
                cancelButtonText: '取消',
                type: 'warning'
            }).then(() => {
                this.$api.get("/${clazz.flName!}/delete", {id:row.id}).then(res => {
                    if (res) {
                        this.getList()
                    }
                })
            }).catch(() => {})
        },
        details(row) {
            this.$refs["editForm"].$emit("update", row.id);
        },
        add() {
            this.$refs["editForm"].$emit("add");
        },
        
    },

}
</script>

<style lang="less" scoped>
@import '../../assets/css/table.css';

/*引入公共样式*/
.btn {
    height: 32px;
    border-radius: 2px
}

.funBtn {
    height: 28px;
}

.filtrate {
    width: 150px;
}

.el-icon-success {
    font-size: 16px;
    color: #49ADB8;
}

</style>
