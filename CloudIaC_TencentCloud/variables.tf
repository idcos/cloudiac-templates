variable "instancename" {
    description = "主机名"
    type = string
    default = "webserver"
}

variable "cpu" {
    description = "cpu数量"
    default = 1
}

variable "memory" {
    description = "内存大小"
    default = 1
}

variable "disksize" {
    description = "磁盘大小"
    default = 51
}

variable "groupname" {
    description = "安全组名称"
    type = string
    default = "web_group"
}

variable "portrange" {
    description = "开放端口,多个端口用英文逗号隔开"
    type = string
    default = "80"
}
