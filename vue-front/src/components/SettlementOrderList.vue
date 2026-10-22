<script setup>
import { ref, onMounted } from 'vue'
import axios from 'axios'
import { ElMessage, ElMessageBox } from 'element-plus'

const list = ref([])
const loading = ref(false)

// 服务商列表
const providers = ref([])

// 查询参数
const searchParams = ref({
  providerId: null,
  period: '',
  status: null
})

// 加载结算列表（带查询参数）
const loadList = async () => {
  loading.value = true
  try {
    const params = new URLSearchParams()
    if (searchParams.value.providerId) params.append('providerId', searchParams.value.providerId)
    if (searchParams.value.period) params.append('period', searchParams.value.period)
    if (searchParams.value.status !== null && searchParams.value.status !== '') params.append('status', searchParams.value.status)
    
    const res = await axios.get(`http://localhost:8080/api/settlement/list?${params.toString()}`)
    if (res.data.code === 200) {
      list.value = res.data.data
    }
  } catch (error) {
    console.error(error)
    ElMessage.error('加载结算列表失败')
  } finally {
    loading.value = false
  }
}

// 获取服务商列表
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

// 重置查询
const resetSearch = () => {
  searchParams.value = { providerId: null, period: '', status: null }
  loadList()
}

// 一键生成结算
const handleGenerate = async () => {
  loading.value = true
  try {
    const res = await axios.post('http://localhost:8080/api/settlement/generate')
    if (res.data.code === 200) {
      ElMessage.success(res.data.msg)
      loadList()
    } else {
      ElMessage.warning(res.data.msg)
    }
  } catch (error) {
    console.error(error)
    ElMessage.error('生成失败，请检查后端日志')
  } finally {
    loading.value = false
  }
}

// 审核
const handleAudit = async (id) => {
  try {
    await ElMessageBox.confirm('确定要通过这笔结算单的审核吗？', '提示', {
      confirmButtonText: '确定通过',
      cancelButtonText: '取消',
      type: 'success'
    })
    await axios.put(`http://localhost:8080/api/settlement/audit/${id}`)
    ElMessage.success('审核通过，已结算！')
    loadList()
  } catch (error) {
    if (error !== 'cancel') {
      console.error(error)
      ElMessage.error('审核失败')
    }
  }
}

// 导出Excel
const handleExport = async () => {
  try {
    // 构建导出URL（带当前查询参数）
    const params = new URLSearchParams()
    if (searchParams.value.providerId) params.append('providerId', searchParams.value.providerId)
    if (searchParams.value.period) params.append('period', searchParams.value.period)
    if (searchParams.value.status !== null && searchParams.value.status !== '') params.append('status', searchParams.value.status)
    
    // 在新窗口打开下载链接
    window.open(`http://localhost:8080/api/settlement/export?${params.toString()}`, '_blank')
    ElMessage.success('导出成功，请检查下载文件夹')
  } catch (error) {
    console.error('导出失败', error)
    ElMessage.error('导出失败')
  }
}

onMounted(() => {
  loadList()
  loadProviders()
})
</script>

<template>
  <div style="background: white; border-radius: 0px; padding: 30px; box-shadow: 0 4px 12px rgba(0,0,0,0.05);">
    <div style="display: flex; justify-content: space-between; align-items: center; margin-bottom: 20px; flex-wrap: wrap; gap: 10px;">
      <h2 style="color: #2d2d2d; margin: 0; font-weight: 600; font-size: 20px;">服务商费用结算</h2>
      <div style="display: flex; gap: 10px;">
        <el-button 
          type="primary" 
          :loading="loading"
          @click="handleGenerate" 
          style="background-color: #2d2d2d; border-color: #2d2d2d; border-radius: 4px; padding: 10px 20px; font-weight: 500; color: white;">
          一键生成当月结算
        </el-button>
        <el-button 
          type="success" 
          @click="handleExport" 
          style="background-color: #2d2d2d; border-color: #2d2d2d; border-radius: 4px; padding: 10px 20px; font-weight: 500; color: white;">
          导出Excel
        </el-button>
      </div>
    </div>

    <!-- 查询条件 -->
    <div style="display: flex; gap: 15px; margin-bottom: 20px; flex-wrap: wrap; align-items: center;">
      <div style="display: flex; align-items: center; gap: 8px;">
        <span style="font-size: 14px; color: #666;">服务商：</span>
        <el-select v-model="searchParams.providerId" placeholder="全部" clearable style="width: 150px;" @change="loadList">
          <el-option 
            v-for="item in providers" 
            :key="item.id" 
            :label="item.companyName" 
            :value="item.id" />
        </el-select>
      </div>
      
      <div style="display: flex; align-items: center; gap: 8px;">
        <span style="font-size: 14px; color: #666;">结算周期：</span>
        <el-input v-model="searchParams.period" placeholder="2026-08" style="width: 130px;" @input="loadList" />
      </div>
      
      <div style="display: flex; align-items: center; gap: 8px;">
        <span style="font-size: 14px; color: #666;">状态：</span>
        <el-select v-model="searchParams.status" placeholder="全部" clearable style="width: 120px;" @change="loadList">
          <el-option label="待审核" :value="0" />
          <el-option label="已结算" :value="1" />
        </el-select>
      </div>
      
      <el-button size="small" @click="resetSearch" style="background-color: #2d2d2d; color: white; border: none; border-radius: 2px;">
        重置
      </el-button>
    </div>

    <el-table :data="list" v-loading="loading" style="width: 100%;" border :header-cell-style="{ backgroundColor: '#f5f5f5', color: '#2d2d2d', fontWeight: 'bold' }">
      <el-table-column prop="id" label="结算单号" width="100" />
      
      <el-table-column label="服务商" width="150">
        <template #default="scope">
          {{ providers.find(p => p.id === scope.row.providerId)?.companyName || scope.row.providerId }}
        </template>
      </el-table-column>

      <el-table-column prop="createdAt" label="生成时间" width="180" />
      <el-table-column prop="baseAmount" label="基础服务费" width="150">
        <template #default="scope">
          ¥ {{ scope.row.baseAmount }}
        </template>
      </el-table-column>
      <el-table-column prop="deductAmount" label="扣减金额" width="150">
        <template #default="scope">
          - ¥ {{ scope.row.deductAmount }}
        </template>
      </el-table-column>
      <el-table-column prop="paidAmount" label="实发金额" width="150">
        <template #default="scope">
          <span style="color: #2d2d2d; font-weight: bold;">¥ {{ scope.row.paidAmount }}</span>
        </template>
      </el-table-column>

      <el-table-column label="结算状态" width="160">
        <template #default="scope">
          <div v-if="scope.row.status === 0">
            <el-tag type="warning" effect="light" style="background: #fafafa; color: #333; border: 1px solid #ddd;">待审核</el-tag>
            <el-button type="success" size="small" style="margin-left: 5px; background-color: #2d2d2d; border-color: #2d2d2d;" @click="handleAudit(scope.row.id)">审核通过</el-button>
          </div>
          <el-tag v-else type="success" effect="dark" style="background: #2d2d2d; border: none;">已结算</el-tag>
        </template>
      </el-table-column>
    </el-table>

    <div v-if="list.length === 0" style="text-align: center; padding: 30px; color: #999;">
      <p>暂无结算记录，请点击「一键生成当月结算」生成数据</p>
    </div>
  </div>
</template>