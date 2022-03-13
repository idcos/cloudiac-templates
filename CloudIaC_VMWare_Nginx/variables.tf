variable "ldcCode" {
    description = "(必填)数据中心"
    type = string
    default = "Datacenter"
}

variable "datastore" {
    description = "存储"
    type = string
    default = "datastore1"
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

variable "name" {
    description = "主机名称"
    type = string
    default = "xiaohei-test-01"
}

variable "cpu" {
    description = "CPU"
    default = 2
}

variable "memory" {
    description = "内存"
    default = 4096
}

variable "disk" {
    description = "磁盘大小"
    type = string
    default = "50"
}

variable "ip" {
    description = "ip"
    type = string
    default = "127.0.0.1"
}

variable "netMask" {
    description = "掩码"
    type = string
    default = "24"
}

variable "gateWay" {
    description = "网关"
    type = string
    default = "127.0.0.1"
}

variable "NginxVersion" {
    description = "软件版本"
    type = string
    default = "1.16.1"
}

variable "serviceNginxPort" {
    description = "服务端口"
    type = string
    default = "80"
}

variable "pidPath" {
    description = "运行文件路径"
    type = string
    default = "/var/run"
}

variable "rootPath" {
    description = "根目录"
    type = string
    default = "/usr/share/nginx/html"
}

variable "process" {
    description = "进程数"
    type = string
    default = "4"
}

variable "maxconnections" {
    description = "最大连接数"
    type = string
    default = "1024"
}

variable "SoftwarenginxIp" {
    description = "介质服务器IP"
    type = string
    default = "127.0.0.1"
}

variable "SoftwareNginxPath" {
    description = "介质路径"
    type = string
    default = "soft/nginx"
}

