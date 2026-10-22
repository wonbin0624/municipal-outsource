<script setup>
import { ref, watch } from 'vue'
import { ElMessage } from 'element-plus'

const props = defineProps({
  modelValue: { type: [String, Array], default: '' },
  module: { type: String, default: 'common' },
  label: { type: String, default: '选择文件' },
  multiple: { type: Boolean, default: false }
})

const emit = defineEmits(['update:modelValue'])

const fileList = ref([])
const uploading = ref(false)

const uploadUrl = 'http://localhost:8080/api/file/upload'

const handleSuccess = (response, file) => {
  console.log('上传返回完整数据:', response)
  console.log('code:', response.code)  // 注意：没有 .data，直接 response.code
  console.log('data:', response.data)
  
  if (response.code === 200) {
    const filePath = response.data?.filePath
    console.log('filePath:', filePath)
    if (filePath) {
      if (props.multiple) {
        const current = Array.isArray(props.modelValue) ? props.modelValue : []
        emit('update:modelValue', [...current, filePath])
      } else {
        emit('update:modelValue', filePath)
      }
      ElMessage.success('上传成功')
    } else {
      ElMessage.error('获取文件路径失败')
    }
  } else {
    ElMessage.error(response.msg || '上传失败')
  }
}

const handleError = (error) => {
  console.error('上传失败', error)
  ElMessage.error('上传失败')
}

const handleRemove = (file) => {
  if (props.multiple) {
    const current = Array.isArray(props.modelValue) ? props.modelValue : []
    const newList = current.filter(path => path !== file.response?.data?.filePath)
    emit('update:modelValue', newList)
  } else {
    emit('update:modelValue', '')
  }
}

watch(() => props.modelValue, (newVal) => {
  if (newVal) {
    if (Array.isArray(newVal) && newVal.length > 0) {
      fileList.value = newVal.map(path => ({ name: path.split('/').pop(), url: 'http://localhost:8080' + path }))
    } else if (typeof newVal === 'string' && newVal) {
      fileList.value = [{ name: newVal.split('/').pop(), url: 'http://localhost:8080' + newVal }]
    }
  } else {
    fileList.value = []
  }
}, { immediate: true })
</script>

<template>
  <div>
    <el-upload
      v-model:file-list="fileList"
      :action="uploadUrl"
      :data="{ module: module }"
      :multiple="multiple"
      :limit="multiple ? 9 : 1"
      :on-success="handleSuccess"
      :on-error="handleError"
      :on-remove="handleRemove"
      :auto-upload="true"
      accept=".jpg,.jpeg,.png,.gif,.bmp,.pdf"
    >
      <el-button type="primary" plain size="small" :loading="uploading">
        {{ label }}
      </el-button>
      <template #tip>
        <div style="font-size: 12px; color: #999; margin-top: 4px;">
          支持 JPG、PNG、PDF 格式，不超过 10MB
        </div>
      </template>
    </el-upload>
  </div>
</template>