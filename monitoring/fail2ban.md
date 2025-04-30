# Monitoring SSH Access with Fail2ban

## Installation

Fail2ban is already installed by Ansible in the bastion role.

## Basic Configuration

Edit `/etc/fail2ban/jail.local` and ensure the SSH jail is enabled:

```ini
[sshd]
enabled = true
port    = ssh
logpath = %(sshd_log)s
maxretry = 3
```

Then restart the service:

```bash
sudo systemctl restart fail2ban
```

## Status

Check status with:

```bash
sudo fail2ban-client status
sudo fail2ban-client status sshd
```
```

---