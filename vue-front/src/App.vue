<script setup>
import { ref, onMounted, computed } from 'vue'
import Login from './components/Login.vue'
import Home from './components/Home.vue'
import ServiceProviderRegister from './components/ServiceProviderRegister.vue'
import ServiceProviderProfile from './components/ServiceProviderProfile.vue'

const currentPath = ref(window.location.pathname)

window.addEventListener('popstate', () => {
  currentPath.value = window.location.pathname
})

const currentPage = computed(() => {
  // 👇 1. 先判断入驻页面（最高优先级）
  if (currentPath.value === '/provider-register') {
    return 'register'
  }
  // 👇 2. 再判断档案页面
  if (currentPath.value.startsWith('/provider-profile/')) {
    return 'profile'
  }
  // 👇 3. 最后判断是否登录
  const token = localStorage.getItem('token')
  if (token) {
    return 'home'
  }
  return 'login'
})

const handleLoginSuccess = () => {
  const token = localStorage.getItem('token')
  if (token) {
    currentPath.value = '/'
    window.history.pushState({}, '', '/')
  }
}

onMounted(() => {
  const token = localStorage.getItem('token')
  if (token && currentPath.value !== '/provider-register' && !currentPath.value.startsWith('/provider-profile/')) {
    currentPath.value = '/'
    window.history.pushState({}, '', '/')
  }
})
</script>

<template>
  <ServiceProviderRegister v-if="currentPage === 'register'" />
  <ServiceProviderProfile v-else-if="currentPage === 'profile'" />
  <Login v-else-if="currentPage === 'login'" @login-success="handleLoginSuccess" />
  <Home v-else />
</template>