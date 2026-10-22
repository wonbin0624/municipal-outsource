<script setup>
import { ref, onMounted } from 'vue'
import axios from 'axios'
import { ElMessage } from 'element-plus'

// 👇 从 URL 中获取服务商 ID（不用 vue-router）
const getProviderId = () => {
  const path = window.location.pathname
  const parts = path.split('/')
  return parts[parts.length - 1]
}

const providerId = ref(getProviderId())
const provider = ref({})
const projects = ref([])
const loading = ref(false)

// 判断资质是否即将到期（30天内）
const isExpiring = (expireDate) => {
  if (!expireDate) return false
  const today = new Date()
  const expire = new Date(expireDate)
  const diffDays = Math.ceil((expire - today) / (1000 * 60 * 60 * 24))
  return diffDays <= 30 && diffDays >= 0
}

// 判断资质是否已过期
const isExpired = (expireDate) => {
  if (!expireDate) return false
  const today = new Date()
  const expire = new Date(expireDate)
  return expire < today
}

// 获取状态标签
const getStatusTag = (status) => {
  switch(status) {
    case 1: return { type: 'success', text: '已入驻' }
    case 0: return { type: 'warning', text: '待审核' }
    case 2: return { type: 'danger', text: '已驳回' }
    default: return { type: 'info', text: '未知' }
  }
}

// 获取信用评级标签
const getCreditTag = (rating) => {
  switch(rating) {
    case 'A': return { type: 'success', text: 'A级 - 优秀' }
    case 'B': return { type: 'warning', text: 'B级 - 良好' }
    case 'C': return { type: 'danger', text: 'C级 - 一般' }
    default: return { type: 'info', text: '未评级' }
  }
}

const loadData = async () => {
  loading.value = true
  try {
    // 1. 获取所有服务商，找到对应 ID 的那个
    const res = await axios.get('http://localhost:8080/api/provider/list')
    if (res.data.code === 200) {
      const found = res.data.data.find(p => p.id == providerId.value)
      if (found) {
        provider.value = found
      } else {
        ElMessage.warning('未找到该服务商')
      }
    }
    
    // 2. 获取所有项目，筛选该服务商的项目
    const projectRes = await axios.get('http://localhost:8080/api/project/list')
    if (projectRes.data.code === 200) {
      projects.value = projectRes.data.data.filter(
        p => p.providerId === provider.value.companyName
      )
    }
  } catch (error) {
    console.error('加载失败', error)
    ElMessage.error('加载服务商信息失败')
  } finally {
    loading.value = false
  }
}

// 返回列表
const goBack = () => {
  window.location.href = '/'
}

onMounted(() => {
  loadData()
})
</script>

<template>
  <div style="min-height: 100vh; background-color: #f0f0f0; padding: 30px;">
    <div style="max-width: 1200px; margin: 0 auto;">
      
      <!-- 返回按钮 -->
      <div style="margin-bottom: 20px;">
        <el-button @click="goBack" style="background-color: #2d2d2d; color: white; border: none;">
          ← 返回首页
        </el-button>
      </div>

      <!-- 主卡片 -->
      <div style="background: white; border-radius: 8px; padding: 30px; box-shadow: 0 4px 12px rgba(0,0,0,0.05);">
        
        <!-- 标题 -->
        <div style="display: flex; justify-content: space-between; align-items: center; margin-bottom: 25px; border-bottom: 2px solid #eee; padding-bottom: 15px;">
          <div>
            <h2 style="color: #2d2d2d; margin: 0; font-weight: 600; font-size: 24px;">
               {{ provider.companyName || '服务商电子档案' }}
            </h2>
            <p style="color: #999; margin: 5px 0 0 0; font-size: 14px;">
              档案编号：SP-{{ String(provider.id || '').padStart(4, '0') }}
            </p>
          </div>
          <div style="display: flex; gap: 10px; align-items: center;">
            <el-tag :type="getStatusTag(provider.status).type" size="large" effect="dark">
              {{ getStatusTag(provider.status).text }}
            </el-tag>
            <el-tag 
              v-if="isExpiring(provider.licenseExpireDate) || isExpiring(provider.qualificationExpireDate)" 
              type="warning" 
              size="large" 
              effect="dark">
              资质即将到期
            </el-tag>
            <el-tag 
              v-if="isExpired(provider.licenseExpireDate) || isExpired(provider.qualificationExpireDate)" 
              type="danger" 
              size="large" 
              effect="dark">
              资质已过期
            </el-tag>
          </div>
        </div>

        <div v-loading="loading">
          <!-- 企业基本信息 -->
          <div style="margin-bottom: 30px;">
            <h3 style="color: #2d2d2d; border-left: 4px solid #2d2d2d; padding-left: 12px; margin-bottom: 20px; font-size: 16px;">
              企业基本信息
            </h3>
            <el-descriptions :column="3" border>
              <el-descriptions-item label="公司名称" label-style="font-weight: bold; background-color: #f5f5f5;">
                {{ provider.companyName || '-' }}
              </el-descriptions-item>
              <el-descriptions-item label="联系人" label-style="font-weight: bold; background-color: #f5f5f5;">
                {{ provider.contactPerson || '-' }}
              </el-descriptions-item>
              <el-descriptions-item label="联系电话" label-style="font-weight: bold; background-color: #f5f5f5;">
                {{ provider.contactPhone || '-' }}
              </el-descriptions-item>
              <el-descriptions-item label="公司地址" label-style="font-weight: bold; background-color: #f5f5f5;" :span="2">
                {{ provider.address || '-' }}
              </el-descriptions-item>
              <el-descriptions-item label="统一社会信用代码">
  {{ provider.creditCode || '-' }}
</el-descriptions-item>
<el-descriptions-item label="法人信息">
  {{ provider.legalPerson || '-' }}
</el-descriptions-item>
<el-descriptions-item label="经营范围" :span="2">
  {{ provider.businessScope || '-' }}
</el-descriptions-item>
              <el-descriptions-item label="擅长领域" label-style="font-weight: bold; background-color: #f5f5f5;">
                <el-tag v-if="provider.category" type="info" size="small">
                  {{ provider.category }}
                </el-tag>
                <span v-else>-</span>
              </el-descriptions-item>
              <el-descriptions-item label="信用评级" label-style="font-weight: bold; background-color: #f5f5f5;">
                <el-tag :type="getCreditTag(provider.creditRating).type" size="small">
                  {{ getCreditTag(provider.creditRating).text }}
                </el-tag>
              </el-descriptions-item>
            </el-descriptions>
          </div>

          <!-- 资质信息 -->
          <div style="margin-bottom: 30px;">
            <h3 style="color: #2d2d2d; border-left: 4px solid #2d2d2d; padding-left: 12px; margin-bottom: 20px; font-size: 16px;">
              资质信息
            </h3>
            <el-descriptions :column="2" border>
              <el-descriptions-item label="营业执照" label-style="font-weight: bold; background-color: #f5f5f5;">
                <a v-if="provider.businessLicense" 
                   :href="'http://localhost:8080' + provider.businessLicense" 
                   target="_blank" 
                   style="color: #2d2d2d;">
                  点击查看
                </a>
                <span v-else style="color: #999;">未上传</span>
              </el-descriptions-item>
              <el-descriptions-item label="营业执照到期日" label-style="font-weight: bold; background-color: #f5f5f5;">
                <span :style="(isExpiring(provider.licenseExpireDate) || isExpired(provider.licenseExpireDate)) ? 'color: #e6a23c; font-weight: bold;' : ''">
                  {{ provider.licenseExpireDate || '-' }}
                  <el-tag v-if="isExpiring(provider.licenseExpireDate)" type="warning" size="small" style="margin-left: 8px;">
                    即将到期
                  </el-tag>
                  <el-tag v-if="isExpired(provider.licenseExpireDate)" type="danger" size="small" style="margin-left: 8px;">
                    已过期
                  </el-tag>
                </span>
              </el-descriptions-item>
              <el-descriptions-item label="资质证书" label-style="font-weight: bold; background-color: #f5f5f5;">
                <a v-if="provider.qualification" 
                   :href="'http://localhost:8080' + provider.qualification" 
                   target="_blank" 
                   style="color: #2d2d2d;">
                  点击查看
                </a>
                <span v-else style="color: #999;">未上传</span>
              </el-descriptions-item>
              <el-descriptions-item label="资质证书到期日" label-style="font-weight: bold; background-color: #f5f5f5;">
                <span :style="(isExpiring(provider.qualificationExpireDate) || isExpired(provider.qualificationExpireDate)) ? 'color: #e6a23c; font-weight: bold;' : ''">
                  {{ provider.qualificationExpireDate || '-' }}
                  <el-tag v-if="isExpiring(provider.qualificationExpireDate)" type="warning" size="small" style="margin-left: 8px;">
                    即将到期
                  </el-tag>
                  <el-tag v-if="isExpired(provider.qualificationExpireDate)" type="danger" size="small" style="margin-left: 8px;">
                    已过期
                  </el-tag>
                </span>
              </el-descriptions-item>
              <el-descriptions-item label="从业资格证明" label-style="font-weight: bold; background-color: #f5f5f5;">
                <a v-if="provider.qualificationCert" 
                   :href="'http://localhost:8080' + provider.qualificationCert" 
                   target="_blank" 
                   style="color: #2d2d2d;">
                  点击查看
                </a>
                <span v-else style="color: #999;">未上传</span>
              </el-descriptions-item>
            </el-descriptions>
          </div>

          <!-- 在管项目 -->
          <div>
            <h3 style="color: #2d2d2d; border-left: 4px solid #2d2d2d; padding-left: 12px; margin-bottom: 20px; font-size: 16px;">
              在管项目（{{ projects.length }}个）
            </h3>
            <el-table :data="projects" border style="width: 100%;" v-if="projects.length > 0">
              <el-table-column prop="id" label="项目编号" width="100" />
              <el-table-column prop="name" label="项目名称" />
              <el-table-column prop="area" label="所属片区" width="120" />
              <el-table-column prop="amount" label="月度费用" width="150">
                <template #default="scope">
                  <span style="font-weight: bold; color: #2d2d2d;">¥ {{ scope.row.amount }}</span>
                </template>
              </el-table-column>
              <el-table-column label="状态" width="120">
                <template #default="scope">
                  <el-tag v-if="scope.row.status === 1" type="success" size="small">进行中</el-tag>
                  <el-tag v-else-if="scope.row.status === 2" type="info" size="small">已完结</el-tag>
                  <el-tag v-else type="danger" size="small">已暂停</el-tag>
                </template>
              </el-table-column>
            </el-table>
            <div v-else style="text-align: center; padding: 30px; color: #999;">
              <p>该服务商暂无在管项目</p>
            </div>
          </div>

          <!-- 底部分隔线 -->
          <div style="margin-top: 30px; padding-top: 20px; border-top: 1px solid #eee; text-align: center; color: #999; font-size: 12px;">
            <p>档案生成时间：{{ provider.createdAt || '-' }}</p>
            <p>云政通 · 市政外包服务一体化管理平台</p>
          </div>
        </div>
      </div>
    </div>
  </div>
</template>

<style scoped>
:deep(.el-descriptions__label) {
  font-weight: bold;
  background-color: #f5f5f5;
}
:deep(.el-descriptions__cell) {
  padding: 12px 16px;
}
</style>