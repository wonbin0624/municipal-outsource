<script setup>
import { ref } from 'vue'
import axios from 'axios'
import ProjectList from './ProjectList.vue'
import ServiceProviderList from './ServiceProviderList.vue'
import PatrolList from './PatrolList.vue'
import AssessIndexList from './AssessIndexList.vue'
import AssessResultList from './AssessResultList.vue'
import SettlementOrderList from './SettlementOrderList.vue'
import WorkorderList from './WorkorderList.vue'
import SysLogList from './SysLogList.vue'
import ProviderWorkorder from './ProviderWorkorder.vue'
import EvaluateDialog from './EvaluateDialog.vue'
import ProviderRectifyTask from './ProviderRectifyTask.vue'
import RectifyTaskList from './RectifyTaskList.vue'

// ===== 1. 获取角色 =====
const userRole = localStorage.getItem('userRole') || 'admin'

// ===== 2. 根据角色设置默认Tab =====
const getDefaultTab = () => {
  switch (userRole) {
    case 'admin': return 'user'
    case 'citizen': return 'citizen'
    case 'inspector': return 'patrol'
    case 'provider': return 'myWorkorder'
    default: return 'user'
  }
}
const currentTab = ref(getDefaultTab())

// ===== 3. 角色校验 =====
if (userRole !== 'admin' && userRole !== 'inspector' && userRole !== 'provider' && userRole !== 'citizen') {
  window.location.href = '/'
}

// ===== 4. 退出登录 =====
const handleLogout = () => {
  localStorage.removeItem('token')
  localStorage.removeItem('userRole')
  localStorage.removeItem('username')
  window.location.href = '/'
}

// ===== 5. 用户管理相关 =====
const users = ref([])
const dialogVisible = ref(false)
const newUser = ref({
  username: '', password: '', realName: '', phone: '', role: 'inspector', status: 1
})

const handleAddUser = async () => {
  try {
    await axios.post('http://localhost:8080/api/user/add', newUser.value)
    dialogVisible.value = false
    alert('添加成功！')
    loadUsers()
    newUser.value = { username: '', password: '', realName: '', phone: '', role: 'inspector', status: 1 }
  } catch (error) {
    console.error('添加失败', error)
    alert('添加失败')
  }
}

const editDialogVisible = ref(false)
const editUser = ref({})

const openEditUser = (row) => {
  editUser.value = { ...row }
  editDialogVisible.value = true
}

const handleUpdateUser = async () => {
  try {
    await axios.put('http://localhost:8080/api/user/update', editUser.value)
    editDialogVisible.value = false
    alert('修改成功！')
    loadUsers()
  } catch (error) {
    console.error('修改失败', error)
    alert('修改失败')
  }
}

const loadUsers = async () => {
  try {
    const res = await axios.get('http://localhost:8080/api/user/list')
    if (res.data.code === 200) {
      users.value = res.data.data
    }
  } catch (error) {
    console.error('加载列表失败', error)
  }
}
loadUsers()

// ===== 6. 市民申诉相关 =====
const workorders = ref([])
const workorderForm = ref({ 
  citizenName: localStorage.getItem('username') || '市民', 
  citizenPhone: '', 
  content: '', 
  category: '其他',
  area: ''
})

const loadWorkorders = async () => {
  try {
    const username = localStorage.getItem('username') || '市民'
    const res = await axios.get(`http://localhost:8080/api/workorder/my-orders?citizenName=${username}`)
    if (res.data.code === 200) {
      workorders.value = res.data.data
    }
  } catch (error) {
    console.error('加载诉求失败', error)
  }
}

const submitWorkorder = async () => {
  if (!workorderForm.value.content) {
    alert('请输入诉求内容！')
    return
  }
  try {
    console.log('提交的工单数据:', JSON.stringify(workorderForm.value))
    await axios.post('http://localhost:8080/api/workorder/add', workorderForm.value)
    alert('诉求提交成功！')
    workorderForm.value.citizenPhone = ''
    workorderForm.value.content = ''
    workorderForm.value.category = '其他'
    workorderForm.value.area = ''
    loadWorkorders()
  } catch (error) {
    console.error('提交失败', error)
    alert('提交失败，请检查控制台')
  }
}

// ===== 评价相关 =====
const evaluateDialogVisible = ref(false)
const currentEvaluateWorkorder = ref(null)

const openEvaluate = (row) => {
  console.log('点击评价，工单:', row)
  currentEvaluateWorkorder.value = row
  evaluateDialogVisible.value = true
}

const onEvaluateSuccess = () => {
  loadWorkorders()
}

if (userRole === 'citizen') {
  loadWorkorders()
}
</script>

<template>
  <div style="display: flex; height: 100vh; background-color: #f0f0f0; font-family: 'Helvetica Neue', 'PingFang SC', sans-serif;">
    
    <!-- ====== 左侧菜单 ====== -->
    <div style="width: 220px; background-color: #2d2d2d; display: flex; flex-direction: column; flex-shrink: 0; border-right: 1px solid #3d3d3d; justify-content: space-between;">
      
      <div>
        <div style="font-size: 24px; font-weight: 700; letter-spacing: 4px; padding: 30px 0; text-align: center; color: #fff; border-bottom: 1px solid #3d3d3d;">
          云政通
        </div>
        <div style="padding-top: 20px;">
          <div v-if="userRole === 'admin'"
            style="padding: 18px 30px; cursor: pointer; transition: 0.2s; border-left: 4px solid transparent;"
            :style="currentTab === 'user' ? 'background-color: #3d3d3d; color: #fff; border-left-color: #fff;' : 'color: #aaa;'"
            @click="currentTab = 'user'">
            用户管理
          </div>
          
          <div v-if="userRole === 'admin'"
            style="padding: 18px 30px; cursor: pointer; transition: 0.2s; border-left: 4px solid transparent;"
            :style="currentTab === 'project' ? 'background-color: #3d3d3d; color: #fff; border-left-color: #fff;' : 'color: #aaa;'"
            @click="currentTab = 'project'">
            项目外包管理
          </div>
          
          <div v-if="userRole === 'admin'"
            style="padding: 18px 30px; cursor: pointer; transition: 0.2s; border-left: 4px solid transparent;"
            :style="currentTab === 'provider' ? 'background-color: #3d3d3d; color: #fff; border-left-color: #fff;' : 'color: #aaa;'"
            @click="currentTab = 'provider'">
            服务商管理
          </div>
          
          <div v-if="userRole === 'admin' || userRole === 'inspector'"
            style="padding: 18px 30px; cursor: pointer; transition: 0.2s; border-left: 4px solid transparent;"
            :style="currentTab === 'patrol' ? 'background-color: #3d3d3d; color: #fff; border-left-color: #fff;' : 'color: #aaa;'"
            @click="currentTab = 'patrol'">
            日常巡检
          </div>

          <!-- 👇 新增：巡查员/管理员的整改复核菜单 -->
          <div v-if="userRole === 'admin' || userRole === 'inspector'"
            style="padding: 18px 30px; cursor: pointer; transition: 0.2s; border-left: 4px solid transparent;"
            :style="currentTab === 'rectify' ? 'background-color: #3d3d3d; color: #fff; border-left-color: #fff;' : 'color: #aaa;'"
            @click="currentTab = 'rectify'">
            整改任务复核
          </div>

          <div v-if="userRole === 'admin'"
            style="padding: 18px 30px; cursor: pointer; transition: 0.2s; border-left: 4px solid transparent;"
            :style="currentTab === 'assess' ? 'background-color: #3d3d3d; color: #fff; border-left-color: #fff;' : 'color: #aaa;'"
            @click="currentTab = 'assess'">
            考核指标
          </div>

          <div v-if="userRole === 'admin'"
            style="padding: 18px 30px; cursor: pointer; transition: 0.2s; border-left: 4px solid transparent;"
            :style="currentTab === 'assessResult' ? 'background-color: #3d3d3d; color: #fff; border-left-color: #fff;' : 'color: #aaa;'"
            @click="currentTab = 'assessResult'">
            考核结果
          </div>

          <div v-if="userRole === 'admin'"
            style="padding: 18px 30px; cursor: pointer; transition: 0.2s; border-left: 4px solid transparent;"
            :style="currentTab === 'settlement' ? 'background-color: #3d3d3d; color: #fff; border-left-color: #fff;' : 'color: #aaa;'"
            @click="currentTab = 'settlement'">
            费用结算
          </div>

          <div v-if="userRole === 'admin'"
            style="padding: 18px 30px; cursor: pointer; transition: 0.2s; border-left: 4px solid transparent;"
            :style="currentTab === 'workorder' ? 'background-color: #3d3d3d; color: #fff; border-left-color: #fff;' : 'color: #aaa;'"
            @click="currentTab = 'workorder'">
            工单管理
          </div>

          <div v-if="userRole === 'admin'"
            style="padding: 18px 30px; cursor: pointer; transition: 0.2s; border-left: 4px solid transparent;"
            :style="currentTab === 'log' ? 'background-color: #3d3d3d; color: #fff; border-left-color: #fff;' : 'color: #aaa;'"
            @click="currentTab = 'log'">
            操作日志
          </div>

          <div v-if="userRole === 'citizen'"
            style="padding: 18px 30px; cursor: pointer; transition: 0.2s; border-left: 4px solid transparent;"
            :style="currentTab === 'citizen' ? 'background-color: #3d3d3d; color: #fff; border-left-color: #fff;' : 'color: #aaa;'"
            @click="currentTab = 'citizen'">
            市民申诉
          </div>

          <div v-if="userRole === 'provider'"
            style="padding: 18px 30px; cursor: pointer; transition: 0.2s; border-left: 4px solid transparent;"
            :style="currentTab === 'myWorkorder' ? 'background-color: #3d3d3d; color: #fff; border-left-color: #fff;' : 'color: #aaa;'"
            @click="currentTab = 'myWorkorder'">
            我的工单
          </div>

          <!-- 👇 新增：服务商的整改任务菜单 -->
          <div v-if="userRole === 'provider'"
            style="padding: 18px 30px; cursor: pointer; transition: 0.2s; border-left: 4px solid transparent;"
            :style="currentTab === 'myRectify' ? 'background-color: #3d3d3d; color: #fff; border-left-color: #fff;' : 'color: #aaa;'"
            @click="currentTab = 'myRectify'">
            我的整改任务
          </div>
        </div>
      </div>

      <div style="padding: 18px 30px; cursor: pointer; transition: 0.2s; border-top: 1px solid #3d3d3d; color: #aaa;"
           @click="handleLogout">
        退出登录
      </div>
    </div>

    <!-- ====== 右侧内容 ====== -->
    <div style="flex: 1; padding: 30px; overflow-y: auto;">
      
      <div v-if="currentTab === 'user' && userRole === 'admin'" style="background: white; border-radius: 0px; padding: 30px; box-shadow: 0 4px 12px rgba(0,0,0,0.05);">
        <div style="display: flex; justify-content: space-between; align-items: center; margin-bottom: 25px; border-bottom: 1px solid #eee; padding-bottom: 15px;">
          <h2 style="color: #2d2d2d; margin: 0; font-weight: 600; font-size: 20px;">用户管理列表</h2>
          <el-button @click="dialogVisible = true" style="background-color: #2d2d2d; border-color: #2d2d2d; color: white; border-radius: 4px; padding: 8px 20px; font-weight: 500;">添加用户</el-button>
        </div>
        <el-table :data="users" style="width: 100%;" border :header-cell-style="{ backgroundColor: '#f5f5f5', color: '#2d2d2d', fontWeight: 'bold' }">
          <el-table-column prop="id" label="ID" width="80" />
          <el-table-column prop="username" label="用户名" width="150" />
          <el-table-column prop="realName" label="真实姓名" width="150" />
          <el-table-column prop="phone" label="手机号" width="180" />
          <el-table-column prop="role" label="角色" width="120">
            <template #default="scope">
              <el-tag v-if="scope.row.role === 'admin'" type="danger" effect="dark">管理员</el-tag>
              <el-tag v-else-if="scope.row.role === 'inspector'" type="success" effect="dark">巡查员</el-tag>
              <el-tag v-else-if="scope.row.role === 'provider'" type="warning" effect="dark">服务商</el-tag>
              <el-tag v-else-if="scope.row.role === 'citizen'" type="info" effect="plain">市民</el-tag>
              <el-tag v-else type="info">未定义</el-tag>
            </template>
          </el-table-column>
          <el-table-column prop="status" label="状态" width="100">
            <template #default="scope">
              <el-tag v-if="scope.row.status === 1" type="success" effect="dark" style="background: #2d2d2d; border: none; border-radius: 2px;">启用</el-tag>
              <el-tag v-else type="danger" effect="plain" style="border: 1px solid #eee; color: #999; background: transparent;">禁用</el-tag>
            </template>
          </el-table-column>
          <el-table-column label="操作" width="120">
            <template #default="scope">
              <el-button type="primary" size="small" style="background-color: #2d2d2d; border-color: #2d2d2d;" @click="openEditUser(scope.row)">编辑</el-button>
            </template>
          </el-table-column>
        </el-table>

        <el-dialog v-model="dialogVisible" title="新增用户" width="400px">
          <el-form label-width="80px">
            <el-form-item label="用户名"><el-input v-model="newUser.username" /></el-form-item>
            <el-form-item label="密码"><el-input v-model="newUser.password" type="password" /></el-form-item>
            <el-form-item label="真实姓名"><el-input v-model="newUser.realName" /></el-form-item>
            <el-form-item label="角色">
              <el-select v-model="newUser.role" placeholder="请选择角色" style="width: 100%;">
                <el-option label="管理员" value="admin" />
                <el-option label="巡查员" value="inspector" />
                <el-option label="服务商" value="provider" />
                <el-option label="市民" value="citizen" />
              </el-select>
            </el-form-item>
            <el-form-item label="状态">
              <el-radio-group v-model="newUser.status">
                <el-radio :label="1">启用</el-radio>
                <el-radio :label="0">禁用</el-radio>
              </el-radio-group>
            </el-form-item>
          </el-form>
          <template #footer>
            <el-button @click="dialogVisible = false">取消</el-button>
            <el-button type="primary" style="background-color: #2d2d2d; border-color: #2d2d2d;" @click="handleAddUser">确定添加</el-button>
          </template>
        </el-dialog>

        <el-dialog v-model="editDialogVisible" title="编辑用户" width="400px">
          <el-form label-width="80px">
            <el-form-item label="用户名"><el-input v-model="editUser.username" disabled /></el-form-item>
            <el-form-item label="真实姓名"><el-input v-model="editUser.realName" /></el-form-item>
            <el-form-item label="角色">
              <el-select v-model="editUser.role" placeholder="请选择角色" style="width: 100%;">
                <el-option label="管理员" value="admin" />
                <el-option label="巡查员" value="inspector" />
                <el-option label="服务商" value="provider" />
                <el-option label="市民" value="citizen" />
              </el-select>
            </el-form-item>
            <el-form-item label="状态">
              <el-radio-group v-model="editUser.status">
                <el-radio :label="1">启用</el-radio>
                <el-radio :label="0">禁用</el-radio>
              </el-radio-group>
            </el-form-item>
          </el-form>
          <template #footer>
            <el-button @click="editDialogVisible = false">取消</el-button>
            <el-button type="primary" style="background-color: #2d2d2d; border-color: #2d2d2d;" @click="handleUpdateUser">保存修改</el-button>
          </template>
        </el-dialog>
      </div>

      <div v-if="currentTab === 'project'"><ProjectList /></div>
      <div v-if="currentTab === 'provider'"><ServiceProviderList /></div>
      <div v-if="currentTab === 'patrol'"><PatrolList /></div>
      <div v-if="currentTab === 'rectify'"><RectifyTaskList /></div>
      <div v-if="currentTab === 'assess'"><AssessIndexList /></div>
      <div v-if="currentTab === 'assessResult'"><AssessResultList /></div>
      <div v-if="currentTab === 'settlement'"><SettlementOrderList /></div>
      <div v-if="currentTab === 'workorder' && userRole === 'admin'"><WorkorderList /></div>
      <div v-if="currentTab === 'log' && userRole === 'admin'"><SysLogList /></div>

      <!-- 市民申诉右侧内容 -->
      <div v-if="currentTab === 'citizen' && userRole === 'citizen'" style="background: white; border-radius: 0px; padding: 30px; box-shadow: 0 4px 12px rgba(0,0,0,0.05);">
        <h2 style="color: #2d2d2d; margin: 0; font-weight: 600; font-size: 20px;">市民申诉提交</h2>
        <div style="color: #666; line-height: 1.8;">
          <p>尊敬的市民，您好！</p>
          <div style="margin-top: 20px; background: #f9f9f9; padding: 20px; border-radius: 8px;">
            <div style="margin-bottom: 15px;">
              <el-input v-model="workorderForm.citizenPhone" placeholder="请输入您的联系电话 (选填)" style="width: 100%;" />
            </div>
            <div style="margin-bottom: 15px;">
              <el-select v-model="workorderForm.category" placeholder="请选择申诉分类" style="width: 100%;">
                <el-option label="环境卫生" value="环境卫生" />
                <el-option label="绿化养护" value="绿化养护" />
                <el-option label="设施维修" value="设施维修" />
                <el-option label="公共安全" value="公共安全" />
                <el-option label="供水供电" value="供水供电" />
                <el-option label="噪音扰民" value="噪音扰民" />
                <el-option label="其他" value="其他" />
              </el-select>
            </div>
            <div style="margin-bottom: 15px;">
              <el-select v-model="workorderForm.area" placeholder="请选择所属片区" style="width: 100%;" clearable>
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
            </div>
            <div style="margin-bottom: 15px;">
              <el-input type="textarea" v-model="workorderForm.content" :rows="3" placeholder="请输入您的申诉内容..." style="width: 100%;" />
            </div>
            <el-button type="primary" style="background-color: #2d2d2d; border-color: #2d2d2d; width: 100%;" @click="submitWorkorder">提交申诉</el-button>
          </div>
          
          <el-table :data="workorders" style="width: 100%; margin-top: 20px; border: 1px solid #eee;">
            <el-table-column prop="workorderCode" label="工单编号" width="160" />
            <el-table-column prop="category" label="分类" width="100" />
            <el-table-column prop="content" label="申诉内容" />
            <el-table-column prop="status" label="处理状态" width="100">
              <template #default="scope">
                <el-tag v-if="scope.row.status === 0" type="info">待处理</el-tag>
                <el-tag v-else-if="scope.row.status === 1" type="warning">处理中</el-tag>
                <el-tag v-else type="success">已完结</el-tag>
              </template>
            </el-table-column>
            <el-table-column prop="submitTime" label="提交时间" width="180" />
            <el-table-column label="操作" width="150">
              <template #default="scope">
                <el-button 
                  v-if="scope.row.status === 2 && !scope.row.satisfaction"
                  type="warning" 
                  size="small" 
                  style="background-color: #e6a23c; border-color: #e6a23c; color: white; border-radius: 2px;"
                  @click="openEvaluate(scope.row)">
                  评价
                </el-button>
                <span v-if="scope.row.satisfaction" style="font-size: 14px; color: #f5a623;">
                  ⭐ {{ scope.row.satisfaction }}星
                </span>
                <span v-if="scope.row.status === 1" style="color: #e6a23c; font-size: 12px;">
                  处理中
                </span>
                <span v-if="scope.row.status === 0" style="color: #999; font-size: 12px;">
                  待处理
                </span>
              </template>
            </el-table-column>
          </el-table>
          <div v-if="workorders.length === 0" style="text-align: center; padding: 30px; color: #999; margin-top: 20px;">
            暂无历史申诉记录
          </div>
        </div>

        <EvaluateDialog 
          v-model:visible="evaluateDialogVisible" 
          :workorder="currentEvaluateWorkorder"
          @success="onEvaluateSuccess" />
      </div>

      <!-- 服务商我的工单 -->
      <div v-if="currentTab === 'myWorkorder' && userRole === 'provider'">
        <ProviderWorkorder />
      </div>

      <!-- 服务商我的整改任务 -->
      <div v-if="currentTab === 'myRectify' && userRole === 'provider'">
        <ProviderRectifyTask />
      </div>

    </div>
  </div>
</template>