<script setup>
import { ref, onMounted, computed } from 'vue'
import axios from 'axios'
import { ElMessage } from 'element-plus'

const list = ref([])
const dialogVisible = ref(false)
const editDialogVisible = ref(false)
const currentTotal = ref(0)

const formData = ref({
  id: null,
  indexName: '',
  indexCode: '',
  weight: '',
  description: '',
  status: 1,
  oldWeight: 0  // 编辑时保存原权重
})

// 新增时是否可以提交
const canSubmit = computed(() => {
  const weight = Number(formData.value.weight)
  return weight > 0 && (currentTotal.value + weight) <= 100
})

// 编辑时是否可以提交
const editCanSubmit = computed(() => {
  const weight = Number(formData.value.weight)
  const otherTotal = currentTotal.value - (formData.value.oldWeight || 0)
  return weight > 0 && (otherTotal + weight) <= 100
})

// 新增时编辑时其他指标总权重（不含本指标，用于编辑弹窗提示）
const otherTotalForEdit = computed(() => {
  return currentTotal.value - (formData.value.oldWeight || 0)
})

// 新增时新增后的总权重
const newTotalForAdd = computed(() => {
  return currentTotal.value + Number(formData.value.weight || 0)
})

// 编辑时修改后的总权重
const newTotalForEdit = computed(() => {
  return otherTotalForEdit.value + Number(formData.value.weight || 0)
})

const loadList = async () => {
  try {
    const res = await axios.get('http://localhost:8080/api/assess/list')
    if (res.data.code === 200) {
      list.value = res.data.data
      currentTotal.value = list.value
        .filter(item => item.status === 1)
        .reduce((sum, item) => sum + (item.weight || 0), 0)
    }
  } catch (error) {
    console.error(error)
    ElMessage.error('加载指标列表失败')
  }
}

const handleAdd = async () => {
  if (!formData.value.indexName) {
    ElMessage.warning('请输入指标名称')
    return
  }
  if (!formData.value.weight || Number(formData.value.weight) <= 0) {
    ElMessage.warning('请输入有效的权重分数')
    return
  }
  if (currentTotal.value + Number(formData.value.weight) > 100) {
    ElMessage.warning('权重之和不能超过100分，当前已有 ' + currentTotal.value + ' 分')
    return
  }

  try {
    const res = await axios.post('http://localhost:8080/api/assess/add', formData.value)
    ElMessage.success(res.data.msg || '添加成功')
    dialogVisible.value = false
    loadList()
    formData.value = { id: null, indexName: '', indexCode: '', weight: '', description: '', status: 1, oldWeight: 0 }
  } catch (error) {
    console.error(error)
    ElMessage.error('添加失败')
  }
}

const openEdit = (row) => {
  formData.value = { ...row, oldWeight: row.weight }
  editDialogVisible.value = true
}

const handleUpdate = async () => {
  if (!formData.value.indexName) {
    ElMessage.warning('请输入指标名称')
    return
  }
  if (!formData.value.weight || Number(formData.value.weight) <= 0) {
    ElMessage.warning('请输入有效的权重分数')
    return
  }

  const otherTotal = currentTotal.value - (formData.value.oldWeight || 0)
  if (otherTotal + Number(formData.value.weight) > 100) {
    ElMessage.warning('权重之和不能超过100分，当前其他指标合计已占 ' + otherTotal + ' 分')
    return
  }

  try {
    const res = await axios.put('http://localhost:8080/api/assess/update', formData.value)
    ElMessage.success(res.data.msg || '修改成功')
    editDialogVisible.value = false
    loadList()
    formData.value = { id: null, indexName: '', indexCode: '', weight: '', description: '', status: 1, oldWeight: 0 }
  } catch (error) {
    console.error(error)
    ElMessage.error('修改失败')
  }
}

const handleDelete = async (id) => {
  if (!confirm('确定要删除这条指标吗？')) return
  try {
    await axios.delete(`http://localhost:8080/api/assess/${id}`)
    ElMessage.success('删除成功')
    loadList()
  } catch (error) {
    console.error(error)
    ElMessage.error('删除失败')
  }
}

onMounted(() => {
  loadList()
})
</script>

<template>
  <div style="background: white; border-radius: 0px; padding: 30px; box-shadow: 0 4px 12px rgba(0,0,0,0.05);">
    <div style="display: flex; justify-content: space-between; align-items: center; margin-bottom: 25px; border-bottom: 1px solid #eee; padding-bottom: 15px;">
      <h2 style="color: #2d2d2d; margin: 0; font-weight: 600; font-size: 20px;">考核指标管理</h2>
      <el-button type="primary" @click="dialogVisible = true" style="background-color: #2d2d2d; border-color: #2d2d2d; border-radius: 4px; padding: 10px 20px; font-weight: 500;">新增指标</el-button>
    </div>

    <el-table :data="list" style="width: 100%;" border :header-cell-style="{ backgroundColor: '#f5f5f5', color: '#2d2d2d', fontWeight: 'bold' }">
      <el-table-column prop="id" label="ID" width="80" />
      <el-table-column prop="indexName" label="指标名称" />
      <el-table-column prop="indexCode" label="编码" width="120" />
      <el-table-column prop="weight" label="权重" width="100" />
      <el-table-column prop="description" label="说明" />
      <el-table-column prop="status" label="状态" width="100">
        <template #default="scope">
          <el-tag v-if="scope.row.status === 1" type="success" effect="dark" style="background: #2d2d2d; border: none; border-radius: 2px;">启用</el-tag>
          <el-tag v-else type="danger" effect="plain" style="border: 1px solid #eee; color: #999; background: transparent;">禁用</el-tag>
        </template>
      </el-table-column>
      <el-table-column label="操作" width="180">
        <template #default="scope">
          <el-button type="primary" size="small" style="background-color: #2d2d2d; border-color: #2d2d2d; color: white; border-radius: 2px;" @click="openEdit(scope.row)">编辑</el-button>
          <el-button type="danger" size="small" style="background-color: #ddd; border-color: #ddd; color: #2d2d2d;" @click="handleDelete(scope.row.id)">删除</el-button>
        </template>
      </el-table-column>
    </el-table>

    <!-- ===== 新增弹窗 ===== -->
    <el-dialog v-model="dialogVisible" title="新增考核指标" width="500px" style="border-radius: 0px;">
      <el-form label-width="100px">
        <el-form-item label="指标名称"><el-input v-model="formData.indexName" /></el-form-item>
        <el-form-item label="指标编码"><el-input v-model="formData.indexCode" /></el-form-item>
        <el-form-item label="权重（分）">
          <el-input-number
            v-model="formData.weight"
            :min="1"
            :max="100"
            :step="1"
            placeholder="填写权重分数"
            style="width: 100%;" />
        </el-form-item>
        <el-form-item label="说明"><el-input v-model="formData.description" /></el-form-item>
        <el-form-item label="状态">
          <el-radio-group v-model="formData.status">
            <el-radio :label="1">启用</el-radio>
            <el-radio :label="0">禁用</el-radio>
          </el-radio-group>
        </el-form-item>
      </el-form>
      <!-- 新增总权重提示 -->
      <div v-if="currentTotal !== null && formData.weight" style="font-size: 14px; text-align: center; margin-bottom: 15px;">
        <span style="color: #333;">当前已有指标总权重：{{ currentTotal }} 分，新增后为：{{ newTotalForAdd }} 分</span>
        <span v-if="newTotalForAdd === 100" style="color: #333;">（权重分配完整）</span>
        <span v-else-if="newTotalForAdd > 100" style="color: #ff0000; font-weight: bold;">（超过100分，请调整！）</span>
        <span v-else style="color: #ff0000; font-weight: bold;">（还差 {{ 100 - newTotalForAdd }} 分）</span>
      </div>
      <template #footer>
        <el-button @click="dialogVisible = false">取消</el-button>
        <el-button type="primary" @click="handleAdd" :disabled="!canSubmit" style="background-color: #2d2d2d; border-color: #2d2d2d; border-radius: 2px;">确定添加</el-button>
      </template>
    </el-dialog>

    <!-- ===== 编辑弹窗 ===== -->
    <el-dialog v-model="editDialogVisible" title="编辑考核指标" width="500px" style="border-radius: 0px;">
      <el-form label-width="100px">
        <el-form-item label="指标名称"><el-input v-model="formData.indexName" /></el-form-item>
        <el-form-item label="指标编码"><el-input v-model="formData.indexCode" /></el-form-item>
        <el-form-item label="权重（分）">
          <el-input-number
            v-model="formData.weight"
            :min="1"
            :max="100"
            :step="1"
            placeholder="填写权重分数"
            style="width: 100%;" />
        </el-form-item>
        <el-form-item label="说明"><el-input v-model="formData.description" /></el-form-item>
        <el-form-item label="状态">
          <el-radio-group v-model="formData.status">
            <el-radio :label="1">启用</el-radio>
            <el-radio :label="0">禁用</el-radio>
          </el-radio-group>
        </el-form-item>
      </el-form>
      <!-- 编辑总权重提示 -->
      <div v-if="currentTotal !== null && formData.weight" style="font-size: 14px; text-align: center; margin-bottom: 15px;">
        <span style="color: #333;">当前已有指标总权重（不含本指标）：{{ otherTotalForEdit }} 分，修改后为：{{ newTotalForEdit }} 分</span>
        <span v-if="newTotalForEdit === 100" style="color: #333;">（权重分配完整）</span>
        <span v-else-if="newTotalForEdit > 100" style="color: #ff0000; font-weight: bold;">（超过100分，请调整！）</span>
        <span v-else style="color: #ff0000; font-weight: bold;">（还差 {{ 100 - newTotalForEdit }} 分）</span>
      </div>
      <template #footer>
        <el-button @click="editDialogVisible = false">取消</el-button>
        <el-button type="primary" @click="handleUpdate" :disabled="!editCanSubmit" style="background-color: #2d2d2d; border-color: #2d2d2d; border-radius: 2px;">保存修改</el-button>
      </template>
    </el-dialog>
  </div>
</template>