<script setup>
import { ref, onMounted } from 'vue'
import axios from 'axios'
import { ElMessage, ElMessageBox } from 'element-plus'

const tasks = ref([])
const dialogVisible = ref(false)
const currentTask = ref({})
const reviewComment = ref('')

const loadTasks = async () => {
  const res = await axios.get('http://localhost:8080/api/rectify/review-list')
  if (res.data.code === 200) {
    tasks.value = res.data.data
  }
}

const openReview = (row) => {
  currentTask.value = row
  reviewComment.value = ''
  dialogVisible.value = true
}

const doReview = async (pass) => {
  if (!pass && !reviewComment.value) {
    ElMessage.warning('驳回时请填写意见')
    return
  }
  await axios.put('http://localhost:8080/api/rectify/review', {
    id: currentTask.value.id,
    status: pass ? 3 : 4,
    reviewComment: reviewComment.value
  })
  ElMessage.success(pass ? '复核通过' : '已驳回')
  dialogVisible.value = false
  loadTasks()
}

onMounted(() => {
  loadTasks()
})
</script>

<template>
  <div style="background: white; padding: 30px; box-shadow: 0 4px 12px rgba(0,0,0,0.05);">
    <h2 style="color: #2d2d2d; margin: 0 0 25px 0; font-weight: 600; font-size: 20px;">整改任务复核</h2>

    <el-table :data="tasks" border style="width: 100%;"
      :header-cell-style="{ backgroundColor: '#f5f5f5', fontWeight: 'bold' }">
      <el-table-column prop="taskCode" label="任务编号" width="160" />
      <el-table-column prop="projectName" label="关联项目" width="180" />
      <el-table-column prop="providerName" label="服务商" width="180" />
      <el-table-column prop="description" label="问题描述" min-width="180" />
      <el-table-column prop="rectifyComment" label="整改说明" min-width="180" />
      <el-table-column label="操作" width="120">
        <template #default="scope">
          <el-button type="warning" size="small"
            style="background-color: #e6a23c; border-color: #e6a23c; color: white;"
            @click="openReview(scope.row)">
            复核
          </el-button>
        </template>
      </el-table-column>
    </el-table>

    <div v-if="tasks.length === 0" style="text-align: center; padding: 30px; color: #999;">
      暂无待复核的整改任务
    </div>

    <el-dialog v-model="dialogVisible" title="复核整改任务" width="520px">
      <el-form label-width="100px">
        <el-form-item label="任务编号"><span>{{ currentTask.taskCode }}</span></el-form-item>
        <el-form-item label="服务商"><span>{{ currentTask.providerName }}</span></el-form-item>
        <el-form-item label="问题描述"><span style="color: #666;">{{ currentTask.description }}</span></el-form-item>
        <el-form-item label="整改说明"><span style="color: #67c23a;">{{ currentTask.rectifyComment }}</span></el-form-item>
        <el-form-item label="复核意见">
          <el-input v-model="reviewComment" type="textarea" :rows="3"
            placeholder="请填写复核意见（驳回时必填）" />
        </el-form-item>
      </el-form>
      <template #footer>
        <el-button @click="dialogVisible = false">取消</el-button>
        <el-button type="danger" @click="doReview(false)">驳回</el-button>
        <el-button type="primary" style="background-color: #2d2d2d; border-color: #2d2d2d;"
          @click="doReview(true)">通过</el-button>
      </template>
    </el-dialog>
  </div>
</template>