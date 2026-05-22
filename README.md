# 🧰 Nginx Proxy Manager Safe Restore Tool

A safe recovery script for **Nginx Proxy Manager** that restores proxy configuration data without risking authentication lockouts or data loss.

It is designed for Docker-based installations using SQLite storage.

---

## 📌 Overview

Manual database edits in Nginx Proxy Manager often lead to:

- Login loops / lockouts
- Broken authentication tables
- Lost admin access
- Corrupted user sessions

This tool fixes that by introducing a **safe, controlled restore workflow**.

---

## ⚙️ What this tool does

✔ Creates a backup of your current database  
✔ Starts a clean login state  
✔ Waits for user confirmation  
✔ Imports ONLY proxy-related data  
✔ Resets authentication safely  
✔ Restarts the container cleanly  

---

## 📦 Preserved data

Your important configuration is always preserved:

- Proxy Hosts
- Redirection Hosts
- Streams
- SSL Certificates
- Access Lists

---

## 🚫 What it does NOT touch

- User authentication logic (handled safely)
- Docker volumes
- System configuration
- Existing SSL files
- Host system data

---

## 🧠 Why this tool exists

During recovery of broken Nginx Proxy Manager installations, common issues include:

- Broken SQLite auth tables
- Missing login credentials
- Failed admin recovery attempts
- Accidental full database resets

This script ensures you never lose access again while still allowing full recovery of your configuration.

---

## 🚀 Usage

### 1. Production Safe (Recommended)

```bash
curl -fsSL https://raw.githubusercontent.com/djdeathgirl/Nginx-Proxy-Manager-Safe-Restore-Tool/main/npm-safe-restore.sh -o npm-safe-restore.sh && chmod +x npm-safe-restore.sh && echo "Downloaded. Run with: ./npm-safe-restore.sh"
```
### 2. Standard Execution
```bash
curl -fsSL https://raw.githubusercontent.com/djdeathgirl/Nginx-Proxy-Manager-Safe-Restore-Tool/main/npm-safe-restore.sh -o npm-safe-restore.sh && chmod +x npm-safe-restore.sh && ./npm-safe-restore.sh

```


### 3. Pipe Execution (Ultra Clean)

```bash
bash <(curl -fsSL https://raw.githubusercontent.com/djdeathgirl/Nginx-Proxy-Manager-Safe-Restore-Tool/main/npm-safe-restore.sh)
```

### 4. Manual Mode (Safe / Inspectable)
```bash
curl -fsSL https://raw.githubusercontent.com/djdeathgirl/Nginx-Proxy-Manager-Safe-Restore-Tool/main/npm-safe-restore.sh -o npm-safe-restore.sh
chmod +x npm-safe-restore.sh
nano npm-safe-restore.sh
./npm-safe-restore.sh
```

### 5. Mayhem Mode (Unsafe / Direct Execute)
```bash
curl -fsSL https://raw.githubusercontent.com/djdeathgirl/Nginx-Proxy-Manager-Safe-Restore-Tool/main/npm-safe-restore.sh | bash

