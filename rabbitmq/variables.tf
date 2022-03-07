# 虚机创建引用变量
variable "ldcCode" {
    description = "数据中心"
    type = string
    default = "Datacenter"
}

variable "datastore" {
    description = "存储"
    type = string
    default = "datastore1"
}

variable "resourcePool" {
    description = "存储"
    type = string
    default = "xiaohei-test"
}

variable "network" {
    description = "数据中心名称"
    type = string
    default = "VM Network"
}

variable "image" {
    description = "镜像"
    type = string
    default = "xiaohei-test"
}

variable "instanceNumber" {
    description = "虚机实例数量"
    type = string
    default = "1"
}

variable "name" {
    description = "主机名称"
    type = string
    default = "rabbitMQ"
}

variable "cpu" {
    description = "CPU"
    default = 1
}

variable "memory" {
    description = "内存"
    default = 2048
}

variable "ips" {
    description = "每个虚拟机的ipv4网络地址,每个中间千万不能有空格"
    type = string
    default = "127.0.0.1"
}

variable "netMask" {
    description = "掩码"
    type = string
    default = "16"
}

variable "gateway" {
    description = "网关"
    type = string
    default = "10.0.0.1"
}

variable "dns" {
    description = "域名解析"
    type = string
    default = "10.0.0.1"
}

# ansible引用变量
variable "softVersion" {
    description = "RabbitMQ版本"
    type = string
    default = "3.3.5"
}

variable "osType" {
    description = "操作系统类型"
    type = string
    default = "centos"
}

variable "osVersion" {
    description = "操作系统版本"
    type = string
    default = "7.4"
}

variable "mediaLibAddress" {
    description = "介质库地址"
    type = string
    default = "10.0.0.4:8000"
}

variable "servicePort" {
    description = "服务端口"
    type = string
    default = "5772"
}

variable "webPort" {
    description = "WEB服务端口"
    type = string
    default = "15772"
}

variable "adminUsername" {
    description = "管理账户用户名"
    type = string
    default = "idcos"
}

variable "adminPassword" {
    description = "管理账户密码"
    type = string
    default = "idcospassword"
}
