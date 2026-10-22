<script setup>
import { ref } from 'vue'
import axios from 'axios'
import RegisterDialog from './RegisterDialog.vue'

const username = ref('')
const password = ref('')
const msg = ref('')

const showRegister = ref(false)

const handleLogin = async () => {
  if (!username.value || !password.value) {
    msg.value = '请输入用户名和密码'
    return
  }

  try {
    const res = await axios.post('http://localhost:8080/api/auth/login', {
      username: username.value,
      password: password.value
    })

    console.log('登录返回数据:', res.data)

    if (res.data.code === 200) {
      const data = res.data.data
      const userRole = data.role || 'user'
      const token = data.token
      
      console.log('角色:', userRole, 'Token:', token)
      
      localStorage.setItem('userRole', userRole)
      localStorage.setItem('token', token)
      localStorage.setItem('username', data.username || username.value)  // 👈 保存用户名
      
      msg.value = '登录成功'
      window.location.reload()
    } else {
      msg.value = '登录失败：' + res.data.msg
    }
  } catch (error) {
    console.error('发生了错误:', error)
    msg.value = '网络请求失败，请查看控制台'
  }
}

// ===== 跳转到服务商入驻页面 =====
const goToProviderRegister = () => {
  window.location.href = '/provider-register'
}
</script>

<template>
  <div class="login-container">
    <div class="login-box">
      <div class="title">云政通</div>
      <div class="subtitle">市政外包服务一体化平台</div>

      <div class="input-group">
        <label>用户名</label>
        <input type="text" v-model="username" placeholder="请输入账号" />
      </div>

      <div class="input-group">
        <label>密码</label>
        <input type="password" v-model="password" placeholder="请输入密码" />
      </div>

      <button class="login-btn" @click="handleLogin">登 录</button>

      <!-- 市民注册入口 -->
      <div class="register-link" @click="showRegister = true">
        还没有账号？点击市民注册
      </div>

      <!-- 服务商入驻入口 -->
      <div class="register-link" style="margin-top: 5px;" @click="goToProviderRegister">
        服务商？点击申请入驻
      </div>

      <div class="msg-box">{{ msg }}</div>
    </div>

    <RegisterDialog v-model="showRegister" />
  </div>
</template>

<style scoped>
.login-container {
  width: 100vw;
  height: 100vh;
  display: flex;
  justify-content: center;
  align-items: center;
  background: linear-gradient(135deg, #f5e6ec 0%, #ffffff 100%);
}

.login-box {
  background: rgba(255, 255, 255, 0.95);
  padding: 50px 60px;
  border-radius: 20px;
  box-shadow: 0 10px 40px rgba(0, 0, 0, 0.08);
  width: 340px;
  text-align: center;
}

.title {
  font-size: 32px;
  font-weight: 700;
  color: #2d2d2d;
  letter-spacing: 4px;
  margin-bottom: 5px;
}

.subtitle {
  font-size: 14px;
  color: #888;
  margin-bottom: 30px;
}

.input-group {
  text-align: left;
  margin-bottom: 20px;
}

.input-group label {
  display: block;
  font-size: 14px;
  color: #555;
  margin-bottom: 6px;
}

.input-group input {
  width: 100%;
  padding: 12px;
  border: 1px solid #eee;
  border-radius: 10px;
  outline: none;
  box-sizing: border-box;
  font-size: 14px;
  background: #fafafa;
  transition: 0.3s;
}

.input-group input:focus {
  border-color: #2d2d2d;
  background: white;
}

.login-btn {
  width: 100%;
  padding: 12px;
  background-color: #2d2d2d;
  color: white;
  border: none;
  border-radius: 10px;
  font-size: 16px;
  cursor: pointer;
  margin-top: 10px;
  transition: 0.3s;
  letter-spacing: 2px;
}

.login-btn:hover {
  background-color: #4d4d4d;
}

.register-link {
  margin-top: 20px;
  font-size: 14px;
  color: #888;
  cursor: pointer;
  text-decoration: underline;
}

.register-link:hover {
  color: #2d2d2d;
}

.msg-box {
  margin-top: 15px;
  min-height: 20px;
  font-size: 14px;
  color: #e74c3c;
}
</style>