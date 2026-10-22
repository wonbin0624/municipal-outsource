<script setup>
import { ref, onMounted } from 'vue'
import axios from 'axios'
import { ElMessage } from 'element-plus'

const list = ref([])
const dialogVisible = ref(false)
const currentWorkorder = ref({})
const providers = ref([])

// 加载工单列表
const loadList = async () => {
  try {
    const res = await axios.get('http://localhost:8080/api/workorder/list')
    if (res.data.code === 200) {
      list.value = res.data.data
    }
  } catch (error) {
    console.error(error)
    ElMessage.error('加载工单列表失败')
  }
}

// 加载服务商列表（用于下拉框）
const loadProviders = async () => {
  try {
    const res = await axios.get('http://localhost:8080/api/provider/list')
    if (res.data.code === 200) {
      providers.value = res.data.data
    }
  } catch (error) {
    console.error(error)
    ElMessage.error('加载服务商失败')
  }
}

// 打开分配弹窗
const openAssign = (row) => {
  currentWorkorder.value = { ...row }
  dialogVisible.value = true
}

// 执行分配操作
const handleAssign = async () => {
  if (!currentWorkorder.value.providerId) {
    ElMessage.warning('请选择一个服务商进行分配')
    return
  }
  try {
    // 调用后端分配接口
    await axios.put('http://localhost:8080/api/workorder/assign', currentWorkorder.value)
    ElMessage.success('分配成功')
    dialogVisible.value = false
    loadList()
  } catch (error) {
    console.error(error)
    ElMessage.error('分配失败')
  }
}

onMounted(() => {
  loadList()
  loadProviders()
})
</script>

<template>
  <div style="background: white; border-radius: 0px; padding: 30px; box-shadow: 0 4px 12px rgba(0,0,0,0.05);">
    <div style="display: flex; justify-content: space-between; align-items: center; margin-bottom: 25px; border-bottom: 1px solid #eee; padding-bottom: 15px;">
      <h2 style="color: #2d2d2d; margin: 0; font-weight: 600; font-size: 20px;">市民工单列表</h2>
    </div>

    <el-table :data="list" style="width: 100%;" border :header-cell-style="{ backgroundColor: '#f5f5f5', color: '#2d2d2d', fontWeight: 'bold' }">
      <el-table-column prop="workorderCode" label="工单编号" width="160" />
      <el-table-column prop="category" label="分类" width="120" />
      <el-table-column prop="content" label="诉求内容" />
      <el-table-column prop="status" label="处理状态" width="120">
        <template #default="scope">
          <el-tag v-if="scope.row.status === 0" type="info">待处理</el-tag>
          <el-tag v-else-if="scope.row.status === 1" type="warning">处理中</el-tag>
          <el-tag v-else type="success">已完结</el-tag>
        </template>
      </el-table-column>
      <el-table-column prop="providerId" label="分配服务商" width="180">
        <template #default="scope">
          {{ providers.find(p => p.id === scope.row.providerId)?.companyName || '未分配' }}
        </template>
      </el-table-column>
      <el-table-column label="操作" width="120">
        <template #default="scope">
          <el-button 
            type="primary" 
            size="small" 
            style="background-color: #2d2d2d; border-color: #2d2d2d; color: white;"
            @click="openAssign(scope.row)">
            分配
          </el-button>
        </template>
      </el-table-column>
    </el-table>

    <div v-if="list.length === 0" style="text-align: center; padding: 30px; color: #999;">
      <p>暂无市民提交的工单</p>
    </div>

    <!-- 分配弹窗 -->
    <el-dialog v-model="dialogVisible" title="分配工单" width="400px" style="border-radius: 0px;">
      <el-form label-width="100px">
        <el-form-item label="诉求内容">
          <el-input v-model="currentWorkorder.content" disabled />
        </el-form-item>
        <el-form-item label="分配给服务商">
          <el-select v-model="currentWorkorder.providerId" placeholder="请选择服务商" style="width: 100%;">
            <el-option 
              v-for="item in providers" 
              :key="item.id" 
              :label="item.companyName" 
              :value="item.id" />
          </el-select>
        </el-form-item>
      </el-form>
      <template #footer>
        <el-button @click="dialogVisible = false">取消</el-button>
        <el-button type="primary" @click="handleAssign" style="background-color: #2d2d2d; border-color: #2d2d2d; border-radius: 2px;">确定分配</el-button>
      </template>
    </el-dialog>
  </div>
</template>