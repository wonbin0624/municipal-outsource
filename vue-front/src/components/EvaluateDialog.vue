<script setup>
import { ref, watch } from 'vue'
import axios from 'axios'
import { ElMessage } from 'element-plus'

const props = defineProps({
  visible: Boolean,
  workorder: Object
})

const emit = defineEmits(['update:visible', 'success'])

const dialogVisible = ref(false)
const form = ref({
  satisfaction: 5,
  evaluation: ''
})
const loading = ref(false)

watch(() => props.visible, (val) => {
  dialogVisible.value = val
  if (val) {
    form.value = { satisfaction: 5, evaluation: '' }
  }
})

watch(dialogVisible, (val) => {
  if (!val) {
    emit('update:visible', false)
  }
})

const submitEvaluate = async () => {
  if (!form.value.satisfaction) {
    ElMessage.warning('请选择满意度')
    return
  }

  loading.value = true
  try {
    await axios.put('http://localhost:8080/api/workorder/evaluate', {
      id: props.workorder?.id,
      satisfaction: String(form.value.satisfaction),
      evaluation: form.value.evaluation || ''
    })
    ElMessage.success('评价成功，感谢您的反馈！')
    dialogVisible.value = false
    emit('success')
  } catch (error) {
    console.error('评价失败', error)
    ElMessage.error('评价失败，请重试')
  } finally {
    loading.value = false
  }
}
</script>

<template>
  <el-dialog v-model="dialogVisible" title="满意度评价" width="420px" style="border-radius: 0px;">
    <el-form label-width="80px">
      <el-form-item label="满意度">
        <el-rate v-model="form.satisfaction" :max="5" />
      </el-form-item>
      <el-form-item label="评价内容">
        <el-input 
          v-model="form.evaluation" 
          type="textarea" 
          :rows="3" 
          placeholder="请描述您的感受（选填）" />
      </el-form-item>
    </el-form>
    <template #footer>
      <el-button @click="dialogVisible = false">取消</el-button>
      <el-button 
        type="primary" 
        :loading="loading" 
        @click="submitEvaluate" 
        style="background-color: #2d2d2d; border-color: #2d2d2d; border-radius: 2px;">
        提交评价
      </el-button>
    </template>
  </el-dialog>
</template>