<script setup>
import { ref, onMounted } from 'vue'
import axios from 'axios'
import { ElMessage, ElMessageBox } from 'element-plus'

const tasks = ref([])
const providerId = ref(null)
const dialogVisible = ref(false)
const currentTask = ref({})
const comment = ref('')
const images = ref('')

const getProviderId = async () => {
  const username = localStorage.getItem('username')
  const res = await axios.get('http://localhost:8080/api/provider/list')
  if (res.data.code === 200) {
    const found = res.data.data.find(p => p.companyName === username)
    if (found) {
      providerId.value = found.id
      loadTasks()
    }
  }
}

const loadTasks = async () => {
  if (!providerId.value) return
  const res = await axios.get(`http://localhost:8080/api/rectify/my-list?providerId=${providerId.value}`)
  if (res.data.code === 200) {
    tasks.value = res.data.data
  }
}

const openSubmit = (row) => {
  currentTask.value = row
  comment.value = ''
  images.value = ''
  dialogVisible.value = true
}

const submitRectify = async () => {
  if (!comment.value) {
    ElMessage.warning('请填写整改说明')
    return
  }
  await axios.put('http://localhost:8080/api/rectify/submit', {
    id: currentTask.value.id,
    rectifyComment: comment.value,
    rectifyImages: images.value
  })
  ElMessage.success('提交成功，等待巡查员复核')
  dialogVisible.value = false
  loadTasks()
}

const getStatusTag = (status) => {
  switch (status) {
    case 0: return { type: 'info', text: '待整改' }
    case 2: return { type: 'warning', text: '待复核' }
    case 3: return { type: 'success', text: '已通过' }
    case 4: return { type: 'danger', text: '已驳回' }
    default: return { type: 'info', text: '未知' }
  }
}

onMounted(() => {
  getProviderId()
})
</script>

<template>
  <div style="background: white; padding: 30px; box-shadow: 0 4px 12px rgba(0,0,0,0.05);">
    <h2 style="color: #2d2d2d; margin: 0 0 25px 0; font-weight: 600; font-size: 20px;">我的整改任务</h2>

    <el-table :data="tasks" border style="width: 100%;"
      :header-cell-style="{ backgroundColor: '#f5f5f5', fontWeight: 'bold' }">
      <el-table-column prop="taskCode" label="任务编号" width="160" />
      <el-table-column prop="projectName" label="关联项目" width="180" />
      <el-table-column prop="description" label="问题描述" min-width="200" />
      <el-table-column prop="deadline" label="整改期限" width="180" />
      <el-table-column label="状态" width="100">
        <template #default="scope">
          <el-tag :type="getStatusTag(scope.row.status).type">
            {{ getStatusTag(scope.row.status).text }}
          </el-tag>
        </template>
      </el-table-column>
      <el-table-column prop="reviewComment" label="巡查员意见" min-width="150" />
      <el-table-column label="操作" width="120">
        <template #default="scope">
          <el-button v-if="scope.row.status === 0 || scope.row.status === 4"
            type="primary" size="small"
            style="background-color: #2d2d2d; border-color: #2d2d2d;"
            @click="openSubmit(scope.row)">
            提交整改
          </el-button>
          <span v-else-if="scope.row.status === 2" style="color: #999; font-size: 12px;">待复核</span>
          <span v-else style="color: #67c23a; font-size: 12px;">已完成</span>
        </template>
      </el-table-column>
    </el-table>

    <div v-if="tasks.length === 0" style="text-align: center; padding: 30px; color: #999;">
      暂无整改任务
    </div>

    <el-dialog v-model="dialogVisible" title="提交整改" width="520px">
      <el-form label-width="100px">
        <el-form-item label="任务编号"><span>{{ currentTask.taskCode }}</span></el-form-item>
        <el-form-item label="问题描述"><span style="color: #666;">{{ currentTask.description }}</span></el-form-item>
        <el-form-item label="整改说明">
          <el-input v-model="comment" type="textarea" :rows="3" placeholder="请描述整改措施和结果" />
        </el-form-item>
        <el-form-item label="整改照片URL">
          <el-input v-model="images" placeholder="可选，填写图片路径" />
        </el-form-item>
      </el-form>
      <template #footer>
        <el-button @click="dialogVisible = false">取消</el-button>
        <el-button type="primary" style="background-color: #2d2d2d; border-color: #2d2d2d;"
          @click="submitRectify">确认提交</el-button>
      </template>
    </el-dialog>
  </div>
</template>