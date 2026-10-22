<script setup>
import { ref, reactive } from 'vue'
import axios from 'axios'
import { ElMessage } from 'element-plus'
import { SuccessFilled } from '@element-plus/icons-vue' 
import FileUpload from './FileUpload.vue'

const loading = ref(false)
const success = ref(false)

const formData = reactive({
  companyName: '',
  contactPerson: '',
  contactPhone: '',
  address: '',
  businessLicense: '',
  qualification: '',
  qualificationCert: '',
  description: '',
  licenseExpireDate: '',
  qualificationExpireDate: '',
  password: '',
  creditCode: '',
  legalPerson: '',
  businessScope: '',
  confirmPassword: ''
})

const validatePassword = (rule, value, callback) => {
  if (value !== formData.password) {
    callback(new Error('两次密码输入不一致'))
  } else {
    callback()
  }
}

const rules = {
  companyName: [
    { required: true, message: '请输入公司名称', trigger: 'blur' }
  ],
  contactPerson: [
    { required: true, message: '请输入联系人', trigger: 'blur' }
  ],
  contactPhone: [
    { required: true, message: '请输入联系电话', trigger: 'blur' }
  ],
  password: [
    { required: true, message: '请设置登录密码', trigger: 'blur' },
    { min: 6, message: '密码不少于6位', trigger: 'blur' }
  ],
  confirmPassword: [
    { required: true, message: '请确认密码', trigger: 'blur' },
    { validator: validatePassword, trigger: 'blur' }
  ]
}

const formRef = ref(null)

const handleSubmit = async () => {
  if (!formRef.value) return
  
  await formRef.value.validate(async (valid) => {
    if (!valid) return

    loading.value = true
    try {
      const res = await axios.post('http://localhost:8080/api/provider/register', formData)
      if (res.data.code === 200) {
        success.value = true
        ElMessage.success('入驻申请已提交，账号已创建，请等待管理员审核！')
        setTimeout(() => {
          window.location.href = '/'
        }, 3000)
      } else {
        ElMessage.warning(res.data.msg)
      }
    } catch (error) {
      console.error('提交失败', error)
      ElMessage.error('提交失败，请重试')
    } finally {
      loading.value = false
    }
  })
}
</script>

<template>
  <div class="register-container">
    <div class="register-box">
      <div class="header">
        <h1>服务商入驻申请</h1>
        <p class="subtitle">填写企业信息，提交入驻申请，等待管理员审核</p>
      </div>

      <div v-if="success" class="success-box">
        <el-icon size="60" color="#67c23a"><SuccessFilled /></el-icon>
        <h2>提交成功！</h2>
        <p>您的入驻申请已提交，账号已创建。</p>
        <p>请等待管理员审核通过后即可登录。</p>
        <p style="color: #999; font-size: 14px;">3秒后自动跳转到登录页...</p>
      </div>

      <el-form
        v-else
        ref="formRef"
        :model="formData"
        :rules="rules"
        label-width="130px"
        label-position="right"
      >
        <el-form-item label="公司名称" prop="companyName">
          <el-input v-model="formData.companyName" placeholder="请输入公司全称" />
        </el-form-item>

        <el-form-item label="统一社会信用代码" prop="creditCode">
  <el-input v-model="formData.creditCode" placeholder="请输入18位统一社会信用代码" />
</el-form-item>

<el-form-item label="法人信息" prop="legalPerson">
  <el-input v-model="formData.legalPerson" placeholder="请输入法人姓名" />
</el-form-item>

<el-form-item label="经营范围" prop="businessScope">
  <el-input v-model="formData.businessScope" placeholder="请输入经营范围" />
</el-form-item>

        <el-form-item label="联系人" prop="contactPerson">
          <el-input v-model="formData.contactPerson" placeholder="请输入联系人姓名" />
        </el-form-item>

        <el-form-item label="联系电话" prop="contactPhone">
          <el-input v-model="formData.contactPhone" placeholder="请输入手机号或座机号" />
        </el-form-item>

        <el-form-item label="公司地址">
          <el-input v-model="formData.address" placeholder="请输入公司详细地址" />
        </el-form-item>

        <el-form-item label="公司简介">
          <el-input
            v-model="formData.description"
            type="textarea"
            :rows="2"
            placeholder="请简要介绍公司业务范围、资质情况等（选填）"
          />
        </el-form-item>

        <el-form-item label="营业执照">
          <FileUpload v-model="formData.businessLicense" module="license" label="上传营业执照" />
          <div v-if="formData.businessLicense" style="margin-top: 5px; font-size: 12px; color: #67c23a;">
            已上传
          </div>
        </el-form-item>

        <el-form-item label="资质证书">
          <FileUpload v-model="formData.qualification" module="license" label="上传资质证书" />
          <div v-if="formData.qualification" style="margin-top: 5px; font-size: 12px; color: #67c23a;">
            已上传
          </div>
        </el-form-item>

        <el-form-item label="从业资格证明">
          <FileUpload v-model="formData.qualificationCert" module="license" label="上传从业资格证明" />
          <div v-if="formData.qualificationCert" style="margin-top: 5px; font-size: 12px; color: #67c23a;">
            已上传
          </div>
        </el-form-item>

        <el-form-item label="营业执照到期日">
          <el-date-picker 
            v-model="formData.licenseExpireDate" 
            type="date" 
            placeholder="选择到期日期"
            format="YYYY-MM-DD"
            value-format="YYYY-MM-DD"
            style="width: 100%;" />
        </el-form-item>

        <el-form-item label="资质证书到期日">
          <el-date-picker 
            v-model="formData.qualificationExpireDate" 
            type="date" 
            placeholder="选择到期日期"
            format="YYYY-MM-DD"
            value-format="YYYY-MM-DD"
            style="width: 100%;" />
        </el-form-item>

        <!-- 👇 新增：密码设置 -->
        <el-form-item label="登录密码" prop="password">
          <el-input v-model="formData.password" type="password" placeholder="请设置登录密码（不少于6位）" />
        </el-form-item>

        <el-form-item label="确认密码" prop="confirmPassword">
          <el-input v-model="formData.confirmPassword" type="password" placeholder="请再次输入密码" />
        </el-form-item>

        <el-form-item>
          <el-button
            type="primary"
            :loading="loading"
            @click="handleSubmit"
            style="width: 100%; background-color: #2d2d2d; border-color: #2d2d2d;"
          >
            提交入驻申请
          </el-button>
        </el-form-item>

        <div style="text-align: center; margin-top: 10px;">
          <span style="color: #999; font-size: 14px;">已有账号？</span>
          <a href="/" style="color: #2d2d2d; font-weight: bold;">去登录</a>
        </div>
      </el-form>
    </div>
  </div>
</template>

<style scoped>
.register-container {
  width: 100vw;
  height: 100vh;
  display: flex;
  justify-content: center;
  align-items: center;
  background: linear-gradient(135deg, #f5f5f5 0%, #e8e8e8 100%);
}

.register-box {
  background: white;
  padding: 40px 50px;
  border-radius: 12px;
  box-shadow: 0 8px 40px rgba(0, 0, 0, 0.1);
  width: 560px;
  max-width: 95%;
  max-height: 95vh;
  overflow-y: auto;
}

.header {
  text-align: center;
  margin-bottom: 25px;
}

.header h1 {
  font-size: 22px;
  color: #2d2d2d;
  margin-bottom: 5px;
}

.subtitle {
  color: #999;
  font-size: 13px;
}

.success-box {
  text-align: center;
  padding: 30px 0;
}

.success-box h2 {
  color: #67c23a;
  margin-top: 15px;
  margin-bottom: 10px;
}

.success-box p {
  color: #666;
  line-height: 1.8;
}

:deep(.el-form-item) {
  margin-bottom: 16px;
}

:deep(.el-input__wrapper) {
  border-radius: 4px;
}
</style>