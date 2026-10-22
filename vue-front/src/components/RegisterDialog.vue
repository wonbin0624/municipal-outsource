<script setup>
import { ref } from 'vue'
import axios from 'axios'
import { ElMessage } from 'element-plus'

const props = defineProps(['modelValue'])
const emit = defineEmits(['update:modelValue'])

const form = ref({
  username: '',
  password: '',
  realName: '',
  phone: ''
})

const loading = ref(false)

// 关闭弹窗
const close = () => {
  emit('update:modelValue', false)
}

// 提交注册
const handleRegister = async () => {
  if (!form.value.username || !form.value.password) {
    ElMessage.warning('用户名和密码不能为空')
    return
  }

  loading.value = true
  try {
    // 调用添加用户接口，强制把角色设为 citizen
    await axios.post('http://localhost:8080/api/user/add', {
      ...form.value,
      role: 'citizen',
      status: 1
    })
    ElMessage.success('注册成功！请登录')
    close()
    // 清空表单
    form.value = { username: '', password: '', realName: '', phone: '' }
  } catch (error) {
    console.error(error)
    ElMessage.error('注册失败，请重试')
  } finally {
    loading.value = false
  }
}
</script>

<template>
  <el-dialog v-model="props.modelValue" title="市民注册" width="400px" style="border-radius: 0px;">
    <el-form label-width="80px">
      <el-form-item label="用户名">
        <el-input v-model="form.username" placeholder="请输入用户名" />
      </el-form-item>
      <el-form-item label="密码">
        <el-input v-model="form.password" type="password" placeholder="请输入密码" />
      </el-form-item>
      <el-form-item label="真实姓名">
        <el-input v-model="form.realName" placeholder="请输入真实姓名" />
      </el-form-item>
      <el-form-item label="手机号">
        <el-input v-model="form.phone" placeholder="请输入手机号" />
      </el-form-item>
    </el-form>
    <template #footer>
      <span class="dialog-footer">
        <el-button @click="close">取消</el-button>
        <el-button type="primary" :loading="loading" @click="handleRegister" style="background-color: #2d2d2d; border-color: #2d2d2d; border-radius: 2px;">
          确认注册
        </el-button>
      </span>
    </template>
  </el-dialog>
</template>