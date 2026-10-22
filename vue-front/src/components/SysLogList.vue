<script setup>
import { ref, onMounted } from 'vue'
import axios from 'axios'
import { ElMessage } from 'element-plus'

const logs = ref([])
const loading = ref(false)

const loadLogs = async () => {
  loading.value = true
  try {
    // 👇 调用后端接口获取真实日志
    const res = await axios.get('http://localhost:8080/api/user/logs')
    if (res.data.code === 200) {
      logs.value = res.data.data
    } else {
      ElMessage.warning(res.data.msg || '加载日志失败')
    }
  } catch (error) {
    console.error('加载日志失败', error)
    ElMessage.error('加载日志失败，请检查后端服务')
  } finally {
    loading.value = false
  }
}

onMounted(() => {
  loadLogs()
})
</script>

<template>
  <div style="background: white; border-radius: 0px; padding: 30px; box-shadow: 0 4px 12px rgba(0,0,0,0.05);">
    <div style="display: flex; justify-content: space-between; align-items: center; margin-bottom: 25px; border-bottom: 1px solid #eee; padding-bottom: 15px;">
      <h2 style="color: #2d2d2d; margin: 0; font-weight: 600; font-size: 20px;">操作日志</h2>
      <el-button size="small" @click="loadLogs" style="background-color: #2d2d2d; color: white; border: none; border-radius: 2px;">
        刷新
      </el-button>
    </div>

    <el-table 
      :data="logs" 
      v-loading="loading"
      style="width: 100%;" 
      border 
      :header-cell-style="{ backgroundColor: '#f5f5f5', color: '#2d2d2d', fontWeight: 'bold' }"
    >
      <el-table-column prop="createdAt" label="操作时间" width="180" />
      <el-table-column prop="username" label="操作人" width="150" />
      <el-table-column prop="operation" label="操作内容" />
    </el-table>

    <div v-if="!loading && logs.length === 0" style="text-align: center; padding: 30px; color: #999;">
      <p>暂无操作日志记录</p>
    </div>
  </div>
</template>