# 提供商
provider "vsphere" {
  user           = "administrator@vsphere.local"
  password       = "123456"
  vsphere_server = "127.0.0.1"
  # If you have a self-signed cert
  allow_unverified_ssl = true
}

# VC数据中心
data "vsphere_datacenter" "dc" {
  name = var.ldcCode
}

# VC数据存储
data "vsphere_datastore" "datastore" {
  name          = var.datastore
  datacenter_id = data.vsphere_datacenter.dc.id
}

# VC资源池 
data "vsphere_resource_pool" "pool" {
  name          = var.resourcePool
  datacenter_id = data.vsphere_datacenter.dc.id
}

# VC网络
data "vsphere_network" "network" {
  name          = var.network
  datacenter_id = data.vsphere_datacenter.dc.id
}

# VC虚机模板
data "vsphere_virtual_machine" "template" {
  name          = "xiaohei-test"
  datacenter_id = data.vsphere_datacenter.dc.id
}

# 创建虚机资源
resource "vsphere_virtual_machine" "vm" {
  # 创建虚机数量
  count            = var.instanceNumber
  # 虚机名称
  name             = format("%s%02d", var.name, count.index + 1)
  # 放置此虚拟机的文件夹的路径，相对于资源池所在的数据中心。
  # folder         = vsphere_folder.folder.path
  # 资源池的托管对象引用 ID
  resource_pool_id = data.vsphere_resource_pool.pool.id
  # 虚拟机数据存储的托管对象引用 ID
  datastore_id     = data.vsphere_datastore.datastore.id
  # 禁用等待可用IP地址
  wait_for_guest_net_timeout = 0
  # 禁用等待此虚拟机上可用的来宾 IP 地址
  wait_for_guest_ip_timeout = 0
  guest_id = data.vsphere_virtual_machine.template.guest_id
  # CPU和内存
  num_cpus = var.cpu
  memory   = var.memory
  network_interface {
    network_id = data.vsphere_network.network.id
  }
  # host_system_id   = data.vsphere_host.host.id
  # cpu_hot_add_enabled =true
  # memory_hot_add_enabled =true
  # cpu_hot_remove_enabled=true
  # 虚机模板中带的磁盘
  disk {
    label = "disk0"
    size  = 50
    eagerly_scrub    = data.vsphere_virtual_machine.template.disks.0.eagerly_scrub
    thin_provisioned = data.vsphere_virtual_machine.template.disks.0.thin_provisioned
  }

  # 克隆虚机
  clone {
    template_uuid = data.vsphere_virtual_machine.template.id

    customize {
	  timeout = 120
      linux_options {
        host_name = format("%s%02d", var.name, count.index + 1)
        domain    = "test.internal"
      }

      network_interface {
        ipv4_address = split(",", var.ips)[count.index]
        ipv4_netmask = var.netMask
      }

      ipv4_gateway = var.gateway
      dns_server_list = [var.dns]
    }
  }
}

output "vm" {
  value = vsphere_virtual_machine.vm
}

// 为每个计算资源创建一个对应的 ansible_host 资源，
// 执行 ansible playbook 前会基于 ansible_host 资源自动生成 inventory 文件。
resource "ansible_host" "RabbitMQ" {
  count = var.instanceNumber
  // 配置机器的 hostname，一般配置为计算资源的 public_ip (或 private_ip)
  // 对应的值要在output中有输出
  inventory_hostname = vsphere_virtual_machine.vm[count.index].default_ip_address
  // 配置机器所属分组
  groups = ["RabbitMQ"]
  // 传给 ansible 的 vars，可在 playbook 文件中引用
  vars = {
    wait_connection_timeout = 600
    softVersion = var.softVersion
    osType = var.osType
    osVersion = var.osVersion
    mediaLibAddress = var.mediaLibAddress
    servicePort = var.servicePort
    webPort = var.webPort
    adminUsername = var.adminUsername
    adminPassword = var.adminPassword
  }
}
