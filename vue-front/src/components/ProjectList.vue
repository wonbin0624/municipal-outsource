<script setup>
import { ref, onMounted } from 'vue'
import axios from 'axios'
import { ElMessage, ElMessageBox } from 'element-plus'

const projects = ref([])
const dialogVisible = ref(false)
const editDialogVisible = ref(false)
const providers = ref([])

// 查询参数
const searchParams = ref({
  name: '',
  area: '',
  providerId: '',
  status: null
})

const formData = ref({
  id: null, 
  name: '', 
  area: '', 
  providerId: '', 
  contractNo: '', 
  amount: '',
  startDate: '',
  endDate: '',
  status: 1
})

// 加载服务商列表（用于下拉框）
const loadProviders = async () => {
  try {
    const res = await axios.get('http://localhost:8080/api/provider/list')
    if (res.data.code === 200) {
      providers.value = res.data.data
    }
  } catch (error) {
    console.error('加载服务商失败', error)
  }
}

// 加载项目列表（带查询参数）
const loadProjects = async () => {
  try {
    const params = new URLSearchParams()
    if (searchParams.value.name) params.append('name', searchParams.value.name)
    if (searchParams.value.area) params.append('area', searchParams.value.area)
    if (searchParams.value.providerId) params.append('providerId', searchParams.value.providerId)
    if (searchParams.value.status !== null && searchParams.value.status !== '') params.append('status', searchParams.value.status)
    
    const res = await axios.get(`http://localhost:8080/api/project/list?${params.toString()}`)
    if (res.data.code === 200) projects.value = res.data.data
  } catch (error) {
    console.error(error)
    ElMessage.error('加载列表失败')
  }
}

// 重置查询
const resetSearch = () => {
  searchParams.value = { name: '', area: '', providerId: '', status: null }
  loadProjects()
}

const handleAdd = async () => {
  if (!formData.value.name) { ElMessage.warning('请输入项目名称'); return }
  try {
    await axios.post('http://localhost:8080/api/project/add', formData.value)
    dialogVisible.value = false
    ElMessage.success('添加成功')
    loadProjects()
    formData.value = { id: null, name: '', area: '', providerId: '', contractNo: '', amount: '', startDate: '', endDate: '', status: 1 }
  } catch (error) { console.error(error); ElMessage.error('添加失败') }
}

const openEdit = (row) => {
  formData.value = { ...row }
  editDialogVisible.value = true
}

const handleUpdate = async () => {
  if (!formData.value.name) { ElMessage.warning('请输入项目名称'); return }
  try {
    await axios.put('http://localhost:8080/api/project/update', formData.value)
    editDialogVisible.value = false
    ElMessage.success('修改成功')
    loadProjects()
    formData.value = { id: null, name: '', area: '', providerId: '', contractNo: '', amount: '', startDate: '', endDate: '', status: 1 }
  } catch (error) { console.error(error); ElMessage.error('修改失败') }
}

const handleDelete = async (id) => {
  try {
    await ElMessageBox.confirm('确定要删除这个项目吗？删除后无法恢复！', '提示', {
      confirmButtonText: '确定删除',
      cancelButtonText: '取消',
      type: 'warning'
    })
    await axios.delete(`http://localhost:8080/api/project/${id}`)
    ElMessage.success('删除成功')
    loadProjects()
  } catch (error) {
    if (error !== 'cancel') {
      console.error(error)
      ElMessage.error('删除失败')
    }
  }
}

onMounted(() => { 
  loadProjects()
  loadProviders()
})
</script>

<template>
  <div style="background: white; border-radius: 0px; padding: 30px; box-shadow: 0 4px 12px rgba(0,0,0,0.05);">
    <div style="display: flex; justify-content: space-between; align-items: center; margin-bottom: 20px; border-bottom: 1px solid #eee; padding-bottom: 15px;">
      <h2 style="color: #2d2d2d; margin: 0; font-weight: 600; font-size: 20px;">外包项目列表</h2>
      <el-button type="primary" @click="dialogVisible = true" style="background-color: #2d2d2d; border-color: #2d2d2d; border-radius: 4px; padding: 10px 20px; font-weight: 500;">新增项目</el-button>
    </div>

    <!-- 👇 查询条件 -->
    <div style="display: flex; gap: 15px; margin-bottom: 20px; flex-wrap: wrap; align-items: center;">
      <div style="display: flex; align-items: center; gap: 8px;">
        <span style="font-size: 14px; color: #666;">项目名称：</span>
        <el-input v-model="searchParams.name" placeholder="请输入" style="width: 150px;" @input="loadProjects" clearable />
      </div>
      
      <div style="display: flex; align-items: center; gap: 8px;">
        <span style="font-size: 14px; color: #666;">所属片区：</span>
        <el-select v-model="searchParams.area" placeholder="全部" clearable style="width: 120px;" @change="loadProjects">
          <el-option label="鼓楼区" value="鼓楼区" />
          <el-option label="玄武区" value="玄武区" />
          <el-option label="秦淮区" value="秦淮区" />
          <el-option label="建邺区" value="建邺区" />
          <el-option label="栖霞区" value="栖霞区" />
          <el-option label="雨花台区" value="雨花台区" />
          <el-option label="江宁区" value="江宁区" />
          <el-option label="浦口区" value="浦口区" />
          <el-option label="六合区" value="六合区" />
          <el-option label="溧水区" value="溧水区" />
          <el-option label="高淳区" value="高淳区" />
        </el-select>
      </div>
      
      <div style="display: flex; align-items: center; gap: 8px;">
        <span style="font-size: 14px; color: #666;">服务商：</span>
        <el-select v-model="searchParams.providerId" placeholder="全部" clearable style="width: 150px;" @change="loadProjects">
          <el-option v-for="item in providers" :key="item.id" :label="item.companyName" :value="item.companyName" />
        </el-select>
      </div>
      
      <div style="display: flex; align-items: center; gap: 8px;">
        <span style="font-size: 14px; color: #666;">状态：</span>
        <el-select v-model="searchParams.status" placeholder="全部" clearable style="width: 120px;" @change="loadProjects">
          <el-option label="进行中" :value="1" />
          <el-option label="已完结" :value="2" />
          <el-option label="已暂停" :value="0" />
        </el-select>
      </div>
      
      <el-button size="small" @click="resetSearch" style="background-color: #2d2d2d; color: white; border: none; border-radius: 2px;">
        重置
      </el-button>
    </div>

    <el-table :data="projects" style="width: 100%;" border :header-cell-style="{ backgroundColor: '#f5f5f5', color: '#2d2d2d', fontWeight: 'bold' }">
      <el-table-column prop="id" label="项目编号" width="80" />
      <el-table-column prop="name" label="项目名称" min-width="140" />
      <el-table-column prop="area" label="所属片区" width="100" />
      <el-table-column prop="providerId" label="服务商名称" width="150" />
      <el-table-column prop="startDate" label="开始日期" width="120" />
      <el-table-column prop="endDate" label="结束日期" width="120" />
      <el-table-column prop="amount" label="月度费用" width="120">
        <template #default="scope">
          ¥ {{ scope.row.amount }}
        </template>
      </el-table-column>
      <el-table-column prop="status" label="当前状态" width="100">
        <template #default="scope">
          <el-tag v-if="scope.row.status === 1" type="warning" effect="light" style="background: #fafafa; color: #333; border: 1px solid #ddd;">进行中</el-tag>
          <el-tag v-else-if="scope.row.status === 2" type="success" effect="dark" style="background: #2d2d2d; border: none; border-radius: 2px;">已完结</el-tag>
          <el-tag v-else type="info" effect="plain" style="border: 1px solid #eee; color: #999; background: transparent;">已暂停</el-tag>
        </template>
      </el-table-column>
      <el-table-column label="操作" width="180" fixed="right">
        <template #default="scope">
          <el-button type="primary" size="small" style="background-color: #2d2d2d; border-color: #2d2d2d; color: white; border-radius: 2px;" @click="openEdit(scope.row)">编辑</el-button>
          <el-button type="danger" size="small" style="background-color: #ddd; border-color: #ddd; color: #2d2d2d;" @click="handleDelete(scope.row.id)">删除</el-button>
        </template>
      </el-table-column>
    </el-table>
    <div v-if="projects.length === 0" style="text-align: center; padding: 20px; color: #999;">暂无数据</div>

    <!-- 新增弹窗 -->
    <el-dialog v-model="dialogVisible" title="新增项目" width="500px" style="border-radius: 0px;">
      <el-form label-width="120px">
        <el-form-item label="项目名称">
          <el-input v-model="formData.name" placeholder="请输入项目名称" />
        </el-form-item>
        <el-form-item label="所属片区">
          <el-input v-model="formData.area" placeholder="请输入所属片区" />
        </el-form-item>
        <el-form-item label="服务商名称">
          <el-input v-model="formData.providerId" placeholder="请输入服务商名称" />
        </el-form-item>
        <el-form-item label="合同编号">
          <el-input v-model="formData.contractNo" placeholder="请输入合同编号" />
        </el-form-item>
        <el-form-item label="合同开始日期">
          <el-date-picker 
            v-model="formData.startDate" 
            type="date" 
            placeholder="选择开始日期"
            format="YYYY-MM-DD"
            value-format="YYYY-MM-DD"
            style="width: 100%;" />
        </el-form-item>
        <el-form-item label="合同结束日期">
          <el-date-picker 
            v-model="formData.endDate" 
            type="date" 
            placeholder="选择结束日期"
            format="YYYY-MM-DD"
            value-format="YYYY-MM-DD"
            style="width: 100%;" />
        </el-form-item>
        <el-form-item label="月度费用">
          <el-input v-model="formData.amount" placeholder="请输入月度费用" />
        </el-form-item>
        <el-form-item label="状态">
          <el-radio-group v-model="formData.status">
            <el-radio :label="1">进行中</el-radio>
            <el-radio :label="2">已完结</el-radio>
            <el-radio :label="0">已暂停</el-radio>
          </el-radio-group>
        </el-form-item>
      </el-form>
      <template #footer>
        <el-button @click="dialogVisible = false">取消</el-button>
        <el-button type="primary" @click="handleAdd" style="background-color: #2d2d2d; border-color: #2d2d2d; border-radius: 2px;">确定添加</el-button>
      </template>
    </el-dialog>

    <!-- 编辑弹窗 -->
    <el-dialog v-model="editDialogVisible" title="编辑项目" width="500px" style="border-radius: 0px;">
      <el-form label-width="120px">
        <el-form-item label="项目名称">
          <el-input v-model="formData.name" />
        </el-form-item>
        <el-form-item label="所属片区">
          <el-input v-model="formData.area" />
        </el-form-item>
        <el-form-item label="服务商名称">
          <el-input v-model="formData.providerId" />
        </el-form-item>
        <el-form-item label="合同编号">
          <el-input v-model="formData.contractNo" />
        </el-form-item>
        <el-form-item label="合同开始日期">
          <el-date-picker 
            v-model="formData.startDate" 
            type="date" 
            placeholder="选择开始日期"
            format="YYYY-MM-DD"
            value-format="YYYY-MM-DD"
            style="width: 100%;" />
        </el-form-item>
        <el-form-item label="合同结束日期">
          <el-date-picker 
            v-model="formData.endDate" 
            type="date" 
            placeholder="选择结束日期"
            format="YYYY-MM-DD"
            value-format="YYYY-MM-DD"
            style="width: 100%;" />
        </el-form-item>
        <el-form-item label="月度费用">
          <el-input v-model="formData.amount" />
        </el-form-item>
        <el-form-item label="状态">
          <el-radio-group v-model="formData.status">
            <el-radio :label="1">进行中</el-radio>
            <el-radio :label="2">已完结</el-radio>
            <el-radio :label="0">已暂停</el-radio>
          </el-radio-group>
        </el-form-item>
      </el-form>
      <template #footer>
        <el-button @click="editDialogVisible = false">取消</el-button>
        <el-button type="primary" @click="handleUpdate" style="background-color: #2d2d2d; border-color: #2d2d2d; border-radius: 2px;">保存修改</el-button>
      </template>
    </el-dialog>
  </div>
</template>