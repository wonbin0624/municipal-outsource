<script setup>
import { ref, onMounted } from 'vue'
import axios from 'axios'
import { ElMessage, ElMessageBox } from 'element-plus'
import FileUpload from './FileUpload.vue'

const records = ref([])
const dialogVisible = ref(false)
const projects = ref([])

const loadProjects = async () => {
  try {
    const res = await axios.get('http://localhost:8080/api/project/list')
    if (res.data.code === 200) {
      projects.value = res.data.data
    }
  } catch (error) {
    console.error('加载项目列表失败', error)
  }
}

const formData = ref({
  projectId: '',
  patrolPerson: '',
  content: '',
  result: 0,
  imgUrl: ''
})

const loadRecords = async () => {
  try {
    const res = await axios.get('http://localhost:8080/api/patrol/list')
    if (res.data.code === 200) {
      records.value = res.data.data
    }
  } catch (error) {
    console.error(error)
    ElMessage.error('加载巡检记录失败')
  }
}

const handleAdd = async () => {
  if (!formData.value.projectId || !formData.value.content) {
    ElMessage.warning('请选择项目并填写巡检内容')
    return
  }
  try {
    await axios.post('http://localhost:8080/api/patrol/add', formData.value)
    dialogVisible.value = false
    ElMessage.success('巡检提交成功！系统已自动识别违规类型')
    loadRecords()
    formData.value = { projectId: '', patrolPerson: '', content: '', result: 0, imgUrl: '' }
  } catch (error) {
    console.error(error)
    ElMessage.error('提交失败')
  }
}

const handleDelete = async (id) => {
  try {
    await ElMessageBox.confirm('确定要删除这条巡检记录吗？删除后无法恢复！', '提示', {
      confirmButtonText: '确定删除',
      cancelButtonText: '取消',
      type: 'warning',
    })
    await axios.delete(`http://localhost:8080/api/patrol/${id}`)
    ElMessage.success('删除成功')
    loadRecords()
  } catch (error) {
    if (error !== 'cancel') {
      console.error(error)
      ElMessage.error('删除失败')
    }
  }
}

onMounted(() => {
  loadRecords()
  loadProjects()
})
</script>

<template>
  <div style="background: white; border-radius: 0px; padding: 30px; box-shadow: 0 4px 12px rgba(0,0,0,0.05);">
    <div style="display: flex; justify-content: space-between; align-items: center; margin-bottom: 25px; border-bottom: 1px solid #eee; padding-bottom: 15px;">
      <h2 style="color: #2d2d2d; margin: 0; font-weight: 600; font-size: 20px;">日常巡检记录</h2>
      <el-button type="primary" @click="dialogVisible = true" style="background-color: #2d2d2d; border-color: #2d2d2d; border-radius: 4px; padding: 10px 20px; font-weight: 500;">新增巡检</el-button>
    </div>

    <el-table :data="records" style="width: 100%;" border :header-cell-style="{ backgroundColor: '#f5f5f5', color: '#2d2d2d', fontWeight: 'bold' }">
      <el-table-column prop="id" label="ID" width="80" />
      
      <el-table-column label="关联项目" width="150">
        <template #default="scope">
          {{ projects.find(p => p.id === scope.row.projectId)?.name || scope.row.projectId }}
        </template>
      </el-table-column>

      <el-table-column prop="patrolPerson" label="巡查员" width="120" />
      <el-table-column prop="content" label="巡检内容" />
      
      <!-- 👇 新增：现场照片列 -->
      <el-table-column label="现场照片" width="100">
        <template #default="scope">
          <a v-if="scope.row.imgUrl" 
             :href="'http://localhost:8080' + scope.row.imgUrl" 
             target="_blank" 
             style="color: #2d2d2d;">
            查看照片
          </a>
          <span v-else style="color: #999;">无</span>
        </template>
      </el-table-column>
      
      <el-table-column prop="patrolType" label="智能识别类型" width="150">
        <template #default="scope">
          <el-tag v-if="scope.row.patrolType === '环境卫生'" type="warning" effect="light" style="background: #fafafa; color: #333; border: 1px solid #ddd;">环境卫生</el-tag>
          <el-tag v-else-if="scope.row.patrolType === '设施损坏'" type="danger" effect="light" style="background: #fafafa; color: #333; border: 1px solid #ddd;">设施损坏</el-tag>
          <el-tag v-else-if="scope.row.patrolType === '绿化养护'" type="success" effect="light" style="background: #fafafa; color: #333; border: 1px solid #ddd;">绿化养护</el-tag>
          <el-tag v-else type="info" effect="plain" style="border: 1px solid #eee; color: #999; background: transparent;">{{ scope.row.patrolType }}</el-tag>
        </template>
      </el-table-column>
      
      <el-table-column prop="patrolTime" label="时间" width="180" />

      <el-table-column label="操作" width="100">
        <template #default="scope">
          <el-button type="danger" size="small" style="background-color: #ddd; border-color: #ddd; color: #2d2d2d;" @click="handleDelete(scope.row.id)">删除</el-button>
        </template>
      </el-table-column>
    </el-table>

    <!-- 新增巡检弹窗 -->
    <el-dialog v-model="dialogVisible" title="新增巡检记录" width="520px" style="border-radius: 0px;">
      <el-form label-width="100px">
        <el-form-item label="关联项目">
          <el-select v-model="formData.projectId" placeholder="请选择项目" style="width: 100%;">
            <el-option v-for="item in projects" :key="item.id" :label="item.name" :value="item.id" />
          </el-select>
        </el-form-item>
        <el-form-item label="巡查员">
          <el-input v-model="formData.patrolPerson" placeholder="请输入巡查员姓名" />
        </el-form-item>
        <el-form-item label="巡检内容">
          <el-input type="textarea" v-model="formData.content" placeholder="例如：A区门口发现大量垃圾堆积" />
        </el-form-item>
        <el-form-item label="巡检结果">
          <el-radio-group v-model="formData.result">
            <el-radio :label="0">一切正常</el-radio>
            <el-radio :label="1">发现问题</el-radio>
          </el-radio-group>
        </el-form-item>
        <!-- 👇 新增：现场照片上传 -->
        <el-form-item label="现场照片">
          <FileUpload v-model="formData.imgUrl" module="patrol" label="上传照片" />
          <div v-if="formData.imgUrl" style="margin-top: 5px; font-size: 12px; color: #67c23a;">
            已上传
          </div>
        </el-form-item>
      </el-form>
      <template #footer>
        <el-button @click="dialogVisible = false">取消</el-button>
        <el-button type="primary" @click="handleAdd" style="background-color: #2d2d2d; border-color: #2d2d2d; border-radius: 2px;">提交巡检</el-button>
      </template>
    </el-dialog>
  </div>
</template>