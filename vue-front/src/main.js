import { createApp } from 'vue'
import ElementPlus from 'element-plus'
import 'element-plus/dist/index.css'
import App from './App.vue'
import axios from 'axios'

// ===== 添加 axios 拦截器 =====
axios.interceptors.request.use(
  config => {
    const token = localStorage.getItem('token')
    if (token) {
      config.headers.Authorization = `Bearer ${token}`
    }
    return config
  },
  error => Promise.reject(error)
)

axios.interceptors.response.use(
  response => response,
  error => {
    if (error.response && error.response.status === 401) {
      localStorage.removeItem('token')
      localStorage.removeItem('userRole')
      window.location.href = '/'
    }
    return Promise.reject(error)
  }
)
// ==============================

const app = createApp(App)

app.use(ElementPlus, {
  button: {
    primary: {
      default: '#2d2d2d',
      hover: '#3d3d3d',
      active: '#1a1a1a'
    },
    danger: {
      default: '#2d2d2d',
      hover: '#3d3d3d',
      active: '#1a1a1a'
    }
  }
})

app.mount('#app')

// 样式覆盖...
const style = document.createElement('style')
style.innerHTML = `
  :root {
    --el-color-primary: #2d2d2d;
    --el-color-primary-light-3: #4d4d4d;
    --el-color-primary-light-5: #6d6d6d;
    --el-color-primary-light-7: #8d8d8d;
    --el-color-primary-light-9: #f5f5f5;
    --el-bg-color-page: #f0f0f0;
  }
  .el-menu { 
    --el-menu-bg-color: #2d2d2d; 
    --el-menu-text-color: #f0f0f0; 
    --el-menu-active-color: #ffffff; 
  }
  .el-table { 
    --el-table-header-bg-color: #f5f5f5; 
    --el-table-header-text-color: #2d2d2d; 
  }
`
document.head.appendChild(style)