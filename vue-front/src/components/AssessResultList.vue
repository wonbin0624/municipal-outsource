<script setup>
import { ref, onMounted, nextTick } from 'vue'
import axios from 'axios'
import { ElMessage } from 'element-plus'
import * as echarts from 'echarts'

const list = ref([])
const loading = ref(false)

// ===== 微调相关 =====
const adjustDialogVisible = ref(false)
const currentAdjust = ref({})
const newScore = ref(null)
const adjustRemark = ref('')

const renderChart = () => {
  const chartDom = document.getElementById('scoreChart')
  if (!chartDom) {
    console.warn('还未找到图表容器，稍后重试')
    return
  }

  if (list.value.length === 0) return

  if (echarts.getInstanceByDom(chartDom)) {
    echarts.getInstanceByDom(chartDom).dispose()
  }

  const myChart = echarts.init(chartDom)
  
  const xData = list.value.map(item => item.projectName || `项目 ${item.projectId}`)
  const yData = list.value.map(item => item.totalScore)

  const option = {
    title: {
      text: '各项目考核得分排名',
      left: 'center',
      textStyle: { color: '#333', fontSize: 16 }
    },
    tooltip: {
      trigger: 'axis',
      axisPointer: { type: 'shadow' }
    },
    grid: {
      left: '3%',
      right: '4%',
      bottom: '3%',
      containLabel: true
    },
    xAxis: {
      type: 'category',
      data: xData,
axisLabel: { 
    color: '#666',
    rotate: -30    // 👈 加上这一行，负值表示顺时针旋转，让文字倾斜
  }
},
    yAxis: {
      type: 'value',
      min: 0,
      max: 100,
      axisLabel: { color: '#666' }
    },
    series: [
      {
        name: '考核得分',
        type: 'bar',
        barWidth: '40%',
        data: yData,
        itemStyle: {
          color: '#2d2d2d'
        }
      }
    ]
  }

  myChart.setOption(option)
  
  window.addEventListener('resize', () => {
    myChart.resize()
  })
}

const loadList = async () => {
  try {
    const res = await axios.get('http://localhost:8080/api/assessResult/list')
    if (res.data.code === 200) {
      list.value = res.data.data
      nextTick(() => {
        renderChart()
      })
    }
  } catch (error) {
    console.error(error)
    ElMessage.error('加载考核结果失败')
  }
}

const handleCalculate = async () => {
  loading.value = true
  try {
    const res = await axios.post('http://localhost:8080/api/assessResult/calculate')
    if (res.data.code === 200) {
      ElMessage.success(res.data.msg)
      loadList()
    } else {
      ElMessage.warning(res.data.msg)
    }
  } catch (error) {
    console.error(error)
    ElMessage.error('核算失败')
  } finally {
    loading.value = false
  }
}

// ===== 打开微调弹窗 =====
const openAdjust = (row) => {
  currentAdjust.value = { ...row }
  newScore.value = row.totalScore
  adjustRemark.value = ''
  adjustDialogVisible.value = true
}

// ===== 确认微调 =====
const confirmAdjust = async () => {
  if (newScore.value === null || newScore.value === undefined) {
    ElMessage.warning('请输入新的分数')
    return
  }

  // 分数范围校验
  if (newScore.value < 0 || newScore.value > 100) {
    ElMessage.warning('分数必须在 0-100 之间')
    return
  }

  try {
    const res = await axios.put('http://localhost:8080/api/assessResult/adjust', {
      id: currentAdjust.value.id,
      totalScore: newScore.value,
      comment: adjustRemark.value || '人工微调'
    })
    if (res.data.code === 200) {
      ElMessage.success('微调成功！')
      adjustDialogVisible.value = false
      loadList()
    } else {
      ElMessage.warning(res.data.msg)
    }
  } catch (error) {
    console.error(error)
    ElMessage.error('微调失败')
  }
}

onMounted(() => {
  loadList()
})
</script>

<template>
  <div style="background: white; border-radius: 0px; padding: 30px; box-shadow: 0 4px 12px rgba(0,0,0,0.05);">
    <div style="display: flex; justify-content: space-between; align-items: center; margin-bottom: 25px; border-bottom: 1px solid #eee; padding-bottom: 15px;">
      <h2 style="color: #2d2d2d; margin: 0; font-weight: 600; font-size: 20px;">项目考核结果</h2>
      <el-button 
        type="primary" 
        :loading="loading"
        @click="handleCalculate" 
        style="background-color: #2d2d2d; border-color: #2d2d2d; border-radius: 4px; padding: 10px 20px; font-weight: 500;">
        一键智能核算
      </el-button>
    </div>

    <el-table :data="list" style="width: 100%;" border :header-cell-style="{ backgroundColor: '#f5f5f5', color: '#2d2d2d', fontWeight: 'bold' }">
      <el-table-column label="序号" width="60" type="index" />
      <el-table-column prop="projectName" label="项目名称" width="150" />
      <el-table-column prop="providerName" label="服务商" width="150" />
      <el-table-column prop="totalScore" label="综合得分" width="150">
        <template #default="scope">
          <span style="font-weight: bold; font-size: 18px; color: #2d2d2d;">{{ scope.row.totalScore }} 分</span>
        </template>
      </el-table-column>
      <el-table-column prop="assessPeriod" label="考核周期" width="150" />
      <el-table-column label="核算时间" width="180">
        <template #default="scope">
          {{ scope.row.createdAt ? scope.row.createdAt.replace('T', ' ') : '' }}
        </template>
      </el-table-column>
      <el-table-column prop="comment" label="备注" min-width="150" />
      <!-- ===== 👇 新增：操作列 ===== -->
      <el-table-column label="操作" width="120" fixed="right">
        <template #default="scope">
          <el-button 
            type="warning" 
            size="small" 
            style="background-color: #f5a623; border-color: #f5a623; color: white; border-radius: 2px;"
            @click="openAdjust(scope.row)">
            微调
          </el-button>
        </template>
      </el-table-column>
    </el-table>
    
    <div v-if="list.length === 0" style="text-align: center; padding: 30px; color: #999;">
      <p>暂无考核结果，请点击上方「一键智能核算」生成当月数据</p>
    </div>

    <!-- 图表容器 -->
    <div id="scoreChart" style="width: 100%; height: 350px; margin-top: 40px; border-top: 1px solid #eee; padding-top: 20px;"></div>

    <!-- ===== 👇 新增：微调弹窗 ===== -->
    <el-dialog v-model="adjustDialogVisible" title="人工微调考核分数" width="420px" style="border-radius: 0px;">
      <el-form label-width="100px">
        <el-form-item label="考核ID">
          <span>{{ currentAdjust.id }}</span>
        </el-form-item>
        <el-form-item label="当前分数">
          <span style="font-weight: bold; font-size: 18px; color: #2d2d2d;">{{ currentAdjust.totalScore }} 分</span>
        </el-form-item>
        <el-form-item label="新分数">
          <el-input-number 
            v-model="newScore" 
            :min="0" 
            :max="100" 
            :step="0.5"
            style="width: 100%;"
            placeholder="请输入 0-100 之间的分数" />
        </el-form-item>
        <el-form-item label="调整原因">
          <el-input 
            v-model="adjustRemark" 
            type="textarea" 
            :rows="2"
            placeholder="请输入调整原因（选填）" />
        </el-form-item>
      </el-form>
      <template #footer>
        <el-button @click="adjustDialogVisible = false">取消</el-button>
        <el-button type="primary" @click="confirmAdjust" style="background-color: #2d2d2d; border-color: #2d2d2d; border-radius: 2px;">
          确认调整
        </el-button>
      </template>
    </el-dialog>
  </div>
</template>
