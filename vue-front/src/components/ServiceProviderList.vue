<script setup>
import { ref, onMounted } from 'vue'
import axios from 'axios'
import { ElMessage, ElMessageBox } from 'element-plus'

const providers = ref([])
const dialogVisible = ref(false)
const editDialogVisible = ref(false)

const formData = ref({
  id: null,
  companyName: '',
  creditCode: '',
  legalPerson: '', 
  businessScope: '', 
  contactPerson: '',
  contactPhone: '',
  address: '',
  category: '',
  area: '',
  creditRating: 'B',
  licenseExpireDate: '',
  qualificationExpireDate: '',
  status: 1
})

const loadProviders = async () => {
  try {
    const res = await axios.get('http://localhost:8080/api/provider/list')
    if (res.data.code === 200) {
      providers.value = res.data.data
    }
  } catch (error) {
    console.error(error)
    ElMessage.error('加载列表失败')
  }
}

const handleAdd = async () => {
  if (!formData.value.companyName) {
    ElMessage.warning('请输入公司名称')
    return
  }
  try {
    await axios.post('http://localhost:8080/api/provider/add', formData.value)
    dialogVisible.value = false
    ElMessage.success('添加成功')
    loadProviders()
    formData.value = { 
      id: null, 
      companyName: '', 
      contactPerson: '', 
      contactPhone: '', 
      address: '', 
      category: '',
      area: '',
      creditRating: 'B',
      licenseExpireDate: '',
      qualificationExpireDate: '',
      status: 1 
    }
  } catch (error) {
    console.error(error)
    ElMessage.error('添加失败')
  }
}

const openEdit = (row) => {
  formData.value = { ...row }
  editDialogVisible.value = true
}

const handleUpdate = async () => {
  if (!formData.value.companyName) {
    ElMessage.warning('请输入公司名称')
    return
  }
  try {
    await axios.put('http://localhost:8080/api/provider/update', formData.value)
    editDialogVisible.value = false
    ElMessage.success('修改成功')
    loadProviders()
    formData.value = { 
      id: null, 
      companyName: '', 
      contactPerson: '', 
      contactPhone: '', 
      address: '', 
      category: '',
      area: '',
      creditRating: 'B',
      licenseExpireDate: '',
      qualificationExpireDate: '',
      status: 1 
    }
  } catch (error) {
    console.error(error)
    ElMessage.error('修改失败')
  }
}

const handleDelete = async (id) => {
  try {
    await ElMessageBox.confirm('确定要删除这个服务商吗？删除后无法恢复！', '提示', {
      confirmButtonText: '确定删除',
      cancelButtonText: '取消',
      type: 'warning'
    })
    await axios.delete(`http://localhost:8080/api/provider/${id}`)
    ElMessage.success('删除成功')
    loadProviders()
  } catch (error) {
    if (error !== 'cancel') {
      console.error(error)
      ElMessage.error('删除失败')
    }
  }
}

const handleAudit = async (id) => {
  try {
    await ElMessageBox.confirm('确定要通过该服务商的入驻审核吗？', '提示', {
      confirmButtonText: '确定通过',
      cancelButtonText: '取消',
      type: 'success'
    })
    await axios.put(`http://localhost:8080/api/provider/audit/${id}`)
    ElMessage.success('审核通过，服务商已入驻')
    loadProviders()
  } catch (error) {
    if (error !== 'cancel') {
      console.error(error)
      ElMessage.error('审核失败')
    }
  }
}

const handleReject = async (id) => {
  try {
    const { value: reason } = await ElMessageBox.prompt('请输入驳回原因（选填）：', '驳回入驻申请', {
      confirmButtonText: '确定驳回',
      cancelButtonText: '取消',
      inputType: 'textarea',
      inputPlaceholder: '请输入驳回原因，留空则使用默认原因'
    })
    await axios.put(`http://localhost:8080/api/provider/reject/${id}`, { reason: reason || '不符合入驻条件' })
    ElMessage.success('已驳回')
    loadProviders()
  } catch (error) {
    if (error !== 'cancel') {
      console.error(error)
      ElMessage.error('驳回失败')
    }
  }
}

const viewProfile = (id) => {
  window.location.href = `/provider-profile/${id}`
}

const isExpiring = (expireDate) => {
  if (!expireDate) return false
  const today = new Date()
  const expire = new Date(expireDate)
  const diffDays = Math.ceil((expire - today) / (1000 * 60 * 60 * 24))
  return diffDays <= 30 && diffDays >= 0
}

const isExpired = (expireDate) => {
  if (!expireDate) return false
  const today = new Date()
  const expire = new Date(expireDate)
  return expire < today
}

onMounted(() => {
  loadProviders()
})
</script>

<template>
  <div style="background: white; border-radius: 0px; padding: 30px; box-shadow: 0 4px 12px rgba(0,0,0,0.05);">
    <div style="display: flex; justify-content: space-between; align-items: center; margin-bottom: 25px; border-bottom: 1px solid #eee; padding-bottom: 15px;">
      <h2 style="color: #2d2d2d; margin: 0; font-weight: 600; font-size: 20px;">服务商管理列表</h2>
      <div>
        <el-button type="primary" @click="dialogVisible = true" style="background-color: #2d2d2d; border-color: #2d2d2d; border-radius: 4px; padding: 10px 20px; font-weight: 500;">新增服务商</el-button>
      </div>
    </div>

    <el-table :data="providers" style="width: 100%;" border :header-cell-style="{ backgroundColor: '#f5f5f5', color: '#2d2d2d', fontWeight: 'bold' }">
      <el-table-column prop="id" label="ID" width="70" />
      <el-table-column prop="companyName" label="公司名称" min-width="150" />
      <el-table-column prop="contactPerson" label="联系人" width="100" />
      <el-table-column prop="contactPhone" label="联系电话" width="130" />
      <el-table-column prop="address" label="地址" min-width="150" />
      
      <el-table-column label="资质状态" width="120">
        <template #default="scope">
          <span v-if="isExpired(scope.row.licenseExpireDate) || isExpired(scope.row.qualificationExpireDate)">
            <el-tag type="danger" size="small" effect="dark">已过期</el-tag>
          </span>
          <span v-else-if="isExpiring(scope.row.licenseExpireDate) || isExpiring(scope.row.qualificationExpireDate)">
            <el-tag type="warning" size="small" effect="dark">即将到期</el-tag>
          </span>
          <span v-else>
            <el-tag type="success" size="small" effect="plain">正常</el-tag>
          </span>
        </template>
      </el-table-column>

      <el-table-column prop="status" label="状态" width="100">
        <template #default="scope">
          <el-tag v-if="scope.row.status === 1" type="success" effect="dark" style="background: #2d2d2d; border: none; border-radius: 2px;">已入驻</el-tag>
          <el-tag v-else-if="scope.row.status === 0" type="warning" effect="light" style="background: #fafafa; color: #333; border: 1px solid #ddd;">待审核</el-tag>
          <el-tag v-else type="danger" effect="plain" style="border: 1px solid #eee; color: #999; background: transparent;">已驳回</el-tag>
        </template>
      </el-table-column>
      
      <el-table-column label="操作" width="420" fixed="right">
        <template #default="scope">
          <div style="display: flex; align-items: center; flex-wrap: wrap; gap: 4px;">
            <el-button 
              type="info" 
              size="small" 
              style="background-color: #6c757d; border-color: #6c757d; color: white; border-radius: 2px;" 
              @click="viewProfile(scope.row.id)">查看档案</el-button>
            
            <el-button 
              v-if="scope.row.status === 0" 
              type="success" 
              size="small" 
              style="background-color: #2d2d2d; border-color: #2d2d2d; color: white; border-radius: 2px;" 
              @click="handleAudit(scope.row.id)">审核通过</el-button>
            
            <el-button 
              v-if="scope.row.status === 0" 
              type="danger" 
              size="small" 
              style="background-color: #d9534f; border-color: #d9534f; color: white; border-radius: 2px;" 
              @click="handleReject(scope.row.id)">驳回</el-button>
            
            <el-button 
              type="primary" 
              size="small" 
              style="background-color: #2d2d2d; border-color: #2d2d2d; color: white; border-radius: 2px;" 
              @click="openEdit(scope.row)">编辑</el-button>
              
            <el-button 
              type="danger" 
              size="small" 
              style="background-color: #ddd; border-color: #ddd; color: #2d2d2d; border-radius: 2px;" 
              @click="handleDelete(scope.row.id)">删除</el-button>
          </div>
        </template>
      </el-table-column>
    </el-table>

    <!-- ===== 新增弹窗 ===== -->
    <el-dialog v-model="dialogVisible" title="新增服务商" width="550px" style="border-radius: 0px;">
      <el-form label-width="130px">
        <el-form-item label="公司名称">
          <el-input v-model="formData.companyName" placeholder="请输入公司全称" />
        </el-form-item>
        <el-form-item label="联系人">
          <el-input v-model="formData.contactPerson" placeholder="请输入联系人" />
        </el-form-item>
        <el-form-item label="联系电话">
          <el-input v-model="formData.contactPhone" placeholder="请输入手机号" />
        </el-form-item>
        <el-form-item label="地址">
          <el-input v-model="formData.address" placeholder="请输入详细地址" />
        </el-form-item>
        
        <el-form-item label="擅长领域">
          <el-select v-model="formData.category" placeholder="请选择" style="width: 100%;">
            <el-option label="环境卫生" value="环境卫生" />
            <el-option label="绿化养护" value="绿化养护" />
            <el-option label="设施维修" value="设施维修" />
            <el-option label="公共安全" value="公共安全" />
            <el-option label="供水供电" value="供水供电" />
            <el-option label="噪音扰民" value="噪音扰民" />
            <el-option label="其他" value="其他" />
          </el-select>
        </el-form-item>

        <!-- 👇 新增：负责片区 -->
        <el-form-item label="负责片区">
          <el-select v-model="formData.area" placeholder="请选择负责片区" style="width: 100%;">
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
        </el-form-item>

        <el-form-item label="信用评级">
          <el-select v-model="formData.creditRating" placeholder="请选择" style="width: 100%;">
            <el-option label="A级 - 优秀" value="A" />
            <el-option label="B级 - 良好" value="B" />
            <el-option label="C级 - 一般" value="C" />
          </el-select>
        </el-form-item>

        <el-form-item label="营业执照到期日">
          <el-date-picker 
            v-model="formData.licenseExpireDate" 
            type="date" 
            placeholder="选择日期"
            format="YYYY-MM-DD"
            value-format="YYYY-MM-DD"
            style="width: 100%;" />
        </el-form-item>

        <el-form-item label="资质证书到期日">
          <el-date-picker 
            v-model="formData.qualificationExpireDate" 
            type="date" 
            placeholder="选择日期"
            format="YYYY-MM-DD"
            value-format="YYYY-MM-DD"
            style="width: 100%;" />
        </el-form-item>

        <el-form-item label="状态">
          <el-radio-group v-model="formData.status">
            <el-radio :label="1">已入驻</el-radio>
            <el-radio :label="0">待审核</el-radio>
            <el-radio :label="2">已驳回</el-radio>
          </el-radio-group>
        </el-form-item>
      </el-form>
      <template #footer>
        <el-button @click="dialogVisible = false">取消</el-button>
        <el-button type="primary" @click="handleAdd" style="background-color: #2d2d2d; border-color: #2d2d2d; border-radius: 2px;">确定添加</el-button>
      </template>
    </el-dialog>

    <!-- ===== 编辑弹窗 ===== -->
    <el-dialog v-model="editDialogVisible" title="编辑服务商" width="550px" style="border-radius: 0px;">
      <el-form label-width="130px">
        <el-form-item label="公司名称">
          <el-input v-model="formData.companyName" />
        </el-form-item>
        <el-form-item label="统一社会信用代码">
  <el-input v-model="formData.creditCode" placeholder="请输入18位统一社会信用代码" />
</el-form-item>
<el-form-item label="法人信息">
  <el-input v-model="formData.legalPerson" placeholder="请输入法人姓名" />
</el-form-item>
<el-form-item label="经营范围">
  <el-input v-model="formData.businessScope" placeholder="请输入经营范围" />
</el-form-item>
        <el-form-item label="联系人">
          <el-input v-model="formData.contactPerson" />
        </el-form-item>
        <el-form-item label="联系电话">
          <el-input v-model="formData.contactPhone" />
        </el-form-item>
        <el-form-item label="地址">
          <el-input v-model="formData.address" />
        </el-form-item>
        
        <el-form-item label="擅长领域">
          <el-select v-model="formData.category" placeholder="请选择" style="width: 100%;">
            <el-option label="环境卫生" value="环境卫生" />
            <el-option label="绿化养护" value="绿化养护" />
            <el-option label="设施维修" value="设施维修" />
            <el-option label="公共安全" value="公共安全" />
            <el-option label="供水供电" value="供水供电" />
            <el-option label="噪音扰民" value="噪音扰民" />
            <el-option label="其他" value="其他" />
          </el-select>
        </el-form-item>

        <!-- 👇 新增：负责片区 -->
        <el-form-item label="负责片区">
          <el-select v-model="formData.area" placeholder="请选择负责片区" style="width: 100%;">
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
        </el-form-item>

        <el-form-item label="信用评级">
          <el-select v-model="formData.creditRating" placeholder="请选择" style="width: 100%;">
            <el-option label="A级 - 优秀" value="A" />
            <el-option label="B级 - 良好" value="B" />
            <el-option label="C级 - 一般" value="C" />
          </el-select>
        </el-form-item>

        <el-form-item label="营业执照到期日">
          <el-date-picker 
            v-model="formData.licenseExpireDate" 
            type="date" 
            placeholder="选择日期"
            format="YYYY-MM-DD"
            value-format="YYYY-MM-DD"
            style="width: 100%;" />
        </el-form-item>

        <el-form-item label="资质证书到期日">
          <el-date-picker 
            v-model="formData.qualificationExpireDate" 
            type="date" 
            placeholder="选择日期"
            format="YYYY-MM-DD"
            value-format="YYYY-MM-DD"
            style="width: 100%;" />
        </el-form-item>

        <el-form-item label="状态">
          <el-radio-group v-model="formData.status">
            <el-radio :label="1">已入驻</el-radio>
            <el-radio :label="0">待审核</el-radio>
            <el-radio :label="2">已驳回</el-radio>
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