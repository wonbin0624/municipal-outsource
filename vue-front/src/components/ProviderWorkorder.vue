<script setup>
import { ref, onMounted } from 'vue'
import axios from 'axios'
import { ElMessage, ElMessageBox } from 'element-plus'
import FileUpload from './FileUpload.vue'

const workorders = ref([])
const loading = ref(false)
const providerId = ref(null)

// 整改弹窗
const completeDialogVisible = ref(false)
const currentRow = ref(null)
const completeComment = ref('')
const completeImages = ref([])

const getProviderId = async () => {
  try {
    const username = localStorage.getItem('username')
    if (!username) {
      ElMessage.warning('请先登录')
      return
    }
    
    const res = await axios.get('http://localhost:8080/api/provider/list')
    if (res.data.code === 200) {
      const providers = res.data.data
      const found = providers.find(p => p.companyName === username)
      if (found) {
        providerId.value = found.id
        loadWorkorders()
      } else {
        ElMessage.warning('未找到对应的服务商信息')
      }
    }
  } catch (error) {
    console.error('获取服务商信息失败', error)
    ElMessage.error('获取服务商信息失败')
  }
}

const loadWorkorders = async () => {
  if (!providerId.value) return
  loading.value = true
  try {
    const res = await axios.get(`http://localhost:8080/api/workorder/my-list?providerId=${providerId.value}`)
    if (res.data.code === 200) {
      workorders.value = res.data.data
    }
  } catch (error) {
    console.error('加载工单失败', error)
    ElMessage.error('加载工单失败')
  } finally {
    loading.value = false
  }
}

const handleProcessing = async (row) => {
  try {
    await ElMessageBox.confirm('确认开始处理该工单吗？', '提示', {
      confirmButtonText: '确定',
      cancelButtonText: '取消',
      type: 'info'
    })
    await axios.put('http://localhost:8080/api/workorder/update-status', {
      id: row.id,
      providerId: providerId.value,
      status: 1
    })
    ElMessage.success('已开始处理')
    loadWorkorders()
  } catch (error) {
    if (error !== 'cancel') {
      console.error(error)
      ElMessage.error('操作失败')
    }
  }
}

const openCompleteDialog = (row) => {
  currentRow.value = row
  completeComment.value = ''
  completeImages.value = []
  completeDialogVisible.value = true
}

const submitComplete = async () => {
  if (!completeComment.value) {
    ElMessage.warning('请填写整改说明')
    return
  }
  
  try {
    const imagesStr = completeImages.value.length > 0 ? completeImages.value.join(',') : ''
    console.log('提交整改数据:', {
      id: currentRow.value.id,
      providerId: providerId.value,
      status: 2,
      comment: completeComment.value,
      images: imagesStr
    })
    
    await axios.put('http://localhost:8080/api/workorder/update-status', {
      id: currentRow.value.id,
      providerId: providerId.value,
      status: 2,
      comment: completeComment.value,
      images: imagesStr
    })
    ElMessage.success('整改已完成！')
    completeDialogVisible.value = false
    loadWorkorders()
  } catch (error) {
    console.error('整改提交失败', error)
    ElMessage.error('整改提交失败')
  }
}

const getStatusTag = (status) => {
  switch(status) {
    case 0: return { type: 'info', text: '待处理' }
    case 1: return { type: 'warning', text: '处理中' }
    case 2: return { type: 'success', text: '已完结' }
    default: return { type: 'info', text: '未知' }
  }
}

onMounted(() => {
  getProviderId()
})
</script>

<template>
  <div style="background: white; border-radius: 0px; padding: 30px; box-shadow: 0 4px 12px rgba(0,0,0,0.05);">
    <div style="display: flex; justify-content: space-between; align-items: center; margin-bottom: 25px; border-bottom: 1px solid #eee; padding-bottom: 15px;">
  <h2 style="color: #2d2d2d; margin: 0; font-weight: 600; font-size: 20px;">我的工单</h2>
</div>

    <el-table :data="workorders" v-loading="loading" style="width: 100%;" border :header-cell-style="{ backgroundColor: '#f5f5f5', color: '#2d2d2d', fontWeight: 'bold' }">
      <el-table-column prop="workorderCode" label="工单编号" width="160" />
      <el-table-column prop="category" label="分类" width="100" />
      <el-table-column prop="content" label="诉求内容" min-width="200" />
      <el-table-column prop="submitTime" label="提交时间" width="180" />
      <el-table-column label="状态" width="100">
        <template #default="scope">
          <el-tag :type="getStatusTag(scope.row.status).type" size="small">
            {{ getStatusTag(scope.row.status).text }}
          </el-tag>
        </template>
      </el-table-column>
      <el-table-column label="整改说明" width="150">
        <template #default="scope">
          <span style="font-size: 12px; color: #666;">{{ scope.row.comment || '-' }}</span>
        </template>
      </el-table-column>
      <el-table-column label="整改照片" width="120">
  <template #default="scope">
    <span v-if="scope.row.images && scope.row.images.length > 0">
      <a 
        :href="'http://localhost:8080' + scope.row.images.split(',')[0]" 
        target="_blank" 
        style="color: #2d2d2d; text-decoration: underline;">
        查看照片
      </a>
    </span>
    <span v-else style="color: #999;">无</span>
  </template>
</el-table-column>
      <el-table-column label="操作" width="120">
        <template #default="scope">
          <el-button 
            v-if="scope.row.status === 0" 
            type="warning" 
            size="small" 
            style="background-color: #e6a23c; border-color: #e6a23c; color: white; border-radius: 2px;"
            @click="handleProcessing(scope.row)">
            开始处理
          </el-button>
          <el-button 
            v-if="scope.row.status === 1" 
            type="success" 
            size="small" 
            style="background-color: #67c23a; border-color: #67c23a; color: white; border-radius: 2px;"
            @click="openCompleteDialog(scope.row)">
            整改完成
          </el-button>
          <span v-if="scope.row.status === 2" style="color: #999; font-size: 12px;">已完成</span>
        </template>
      </el-table-column>
    </el-table>

    <div v-if="!loading && workorders.length === 0" style="text-align: center; padding: 30px; color: #999;">
      <p>暂无分配给您的工单</p>
    </div>

    <!-- 👇 整改完成弹窗（含图片上传） -->
    <el-dialog v-model="completeDialogVisible" title="整改完成" width="520px" style="border-radius: 0px;">
      <el-form label-width="100px">
        <el-form-item label="工单编号">
          <span>{{ currentRow?.workorderCode }}</span>
        </el-form-item>
        <el-form-item label="诉求内容">
          <span style="color: #666; font-size: 13px;">{{ currentRow?.content }}</span>
        </el-form-item>
        <el-form-item label="整改说明">
          <el-input 
            v-model="completeComment" 
            type="textarea" 
            :rows="3" 
            placeholder="请描述整改措施和结果" />
        </el-form-item>
        <!-- 👇 照片上传 -->
        <el-form-item label="整改照片">
          <FileUpload v-model="completeImages" module="rectify" label="上传照片" :multiple="true" />
          <div style="font-size: 12px; color: #999; margin-top: 4px;">
            可上传多张照片（JPG/PNG，不超过10MB）
          </div>
        </el-form-item>
      </el-form>
      <template #footer>
        <el-button @click="completeDialogVisible = false">取消</el-button>
        <el-button type="primary" @click="submitComplete" style="background-color: #2d2d2d; border-color: #2d2d2d; border-radius: 2px;">
          确认整改完成
        </el-button>
      </template>
    </el-dialog>
  </div>
</template>