Here's a well-structured `README.md` that organizes and links your setup guides step-by-step, making it easy for users to follow the deployment process for different requirements:

---

# 🛠️ Full Deployment Guide for Node.js + TypeScript on AWS EC2

This guide helps you deploy a production-ready Node.js (with TypeScript) backend with optional setups like MongoDB, Elastic IP, SSL, and S3 integration on an Ubuntu EC2 instance.

---

## ✅ Prerequisites

* AWS Account
* A domain (for subdomain + SSL)
* Familiarity with basic Linux commands

---

## 🚀 Deployment Steps

### 1. Launch EC2 Instance

* Use Ubuntu (Free Tier: `t2.micro`)
* Create a key pair and download the `.pem` file
* Open all ports temporarily (lock down later)

---

### 2. Assign Elastic IP (Recommended for Stable IP)

🔗 [Elastic IP Setup →](./ELASTIC_IP.md)

---

### 3. Install and Setup Node.js with TypeScript

🔗 [Node.js + TypeScript Setup →](./NODEJS_TS.md)

---

### 4. Setup MongoDB (Optional – if your app uses a database)

🔗 [MongoDB Installation & Remote Access →](./MONGODB.md)

---

### 5. Setup Nginx Reverse Proxy & Subdomain

This step is included in the Node.js guide above.

---

### 6. Enable HTTPS with SSL using Certbot

🔗 [Enable SSL with Certbot (HTTPS) →](./SSL_ENABLE.md)

---

### 7. Setup AWS S3 Bucket (Optional – for file storage)

🔗 [S3 Bucket + IAM User →](./S3_BUCKET.md)

---

## 🔄 Auto-Renew SSL & Logs

* SSL certificates via Certbot auto-renew.
* Log files help you verify renewal worked.
* Refer to [SSL\_ENABLE.md](./SSL_ENABLE.md) for log setup and cron job.

---

## 📁 Folder Structure Recommendation

```
project-root/
├── dist/              # Compiled JS (output)
├── src/               # TypeScript source code
├── node_modules/
├── .env
├── package.json
├── tsconfig.json
└── ecosystem.config.js (optional for PM2)
```

---

## ✅ Final Checklist

| Task                             | Completed? |
| -------------------------------- | ---------- |
| EC2 Setup                        | ✅ / ❌      |
| Elastic IP Assigned              | ✅ / ❌      |
| Node.js App Deployed             | ✅ / ❌      |
| MongoDB Setup (if needed)        | ✅ / ❌      |
| Nginx Reverse Proxy              | ✅ / ❌      |
| SSL Enabled (HTTPS)              | ✅ / ❌      |
| S3 Bucket Configured (if needed) | ✅ / ❌      |

---
