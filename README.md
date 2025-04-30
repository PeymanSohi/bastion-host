# 🛡️ Bastion Host Setup Project

This project demonstrates how to set up a **bastion host** to securely access a **private server** inside a cloud network, using **Terraform**, **Ansible**, and **SSH jump host configuration**. It also includes optional monitoring with `fail2ban`.

---

## 📌 What is a Bastion Host?

A bastion host is a publicly accessible server that acts as a secure gateway between external users and a private/internal network. It reduces the attack surface by centralizing access and enables SSH jump access to internal servers without exposing them to the internet.

---

## ⚙️ Tools Used

- **Cloud Provider**: AWS (can adapt to GCP, Azure, DigitalOcean)
- **Provisioning**: Terraform
- **Configuration Management**: Ansible
- **SSH Security**: ProxyJump (jump host)
- **Monitoring**: Fail2ban

---

## 🚀 How to Use

### 1. 🔧 Setup Infrastructure (Terraform)

```bash
cd terraform/
terraform init
terraform apply -var="key_name=your_key" -var="bastion_ami=ami-xxx" -var="private_ami=ami-xxx"
```

> ⚠️ Replace variables with actual values.

### 2. 🔑 SSH Configuration

Edit the `ssh-config/config` file:
```ssh
Host bastion
    HostName <BASTION_PUBLIC_IP>
    User ubuntu
    IdentityFile ~/.ssh/bastion-key.pem

Host private-server
    HostName <PRIVATE_PRIVATE_IP>
    User ubuntu
    IdentityFile ~/.ssh/private-key.pem
    ProxyJump bastion
```

Then connect via:
```bash
ssh -F ssh-config/config bastion
ssh -F ssh-config/config private-server
```

### 3. ⚙️ Configure Servers (Ansible)

Edit `ansible/inventory/hosts.ini` with the instance IPs. Then run:

```bash
cd ansible/
ansible-playbook -i inventory/hosts.ini site.yml
```

---

## 🛡️ Security Best Practices

- SSH keys only (no password login)
- Root login disabled
- `fail2ban` to monitor SSH brute-force attempts
- Optional UFW firewall on Bastion
- Use IAM roles and least privilege access in cloud provider

---

## ❗️ DO NOT COMMIT

- `.pem` private keys
- Public/private IP addresses
- Cloud credentials
- `hosts.ini` (it's in `.gitignore`)

---

## ✅ Final Result

You can SSH to the private server via:

```bash
ssh -F ssh-config/config private-server
```

Or jump through the bastion manually:

```bash
ssh -F ssh-config/config bastion
# From inside bastion
ssh ubuntu@<PRIVATE_PRIVATE_IP>
```

---



https://roadmap.sh/projects/bastion-host