# EC2 Free Tier Deployment: Node.js + MongoDB + Nginx + S3 + Subdomain + SSL

---

## 1. Launch EC2 Instance

* Choose Ubuntu Free Tier (t2.micro)
* Allow all ports temporarily (edit later for security)
* Create key-pair and download `.pem` file

---

## 2. Install Nginx

```bash
sudo apt-get install nginx -y
```

Visit `http://YOUR_INSTANCE_PUBLIC_IP/` to check Nginx.

---

## 3. Install Node.js

```bash
sudo apt-get update -y
sudo apt-get install curl -y
curl -sL https://deb.nodesource.com/setup_22.x | sudo -E bash -
sudo apt-get install -y nodejs
node -v # should show v18.16.0 or above
npm -v  # should show 9.5.1 or above
sudo npm install pm2 -g
```

---

## 4. Install MongoDB

```bash
sudo apt install wget curl gnupg2 software-properties-common apt-transport-https ca-certificates lsb-release
curl -fsSL https://www.mongodb.org/static/pgp/server-6.0.asc | sudo gpg --dearmor -o /etc/apt/trusted.gpg.d/mongodb-6.gpg
echo "deb [ arch=amd64,arm64 ] https://repo.mongodb.org/apt/ubuntu $(lsb_release -cs)/mongodb-org/6.0 multiverse" | sudo tee /etc/apt/sources.list.d/mongodb-org-6.0.list
sudo apt update -y
sudo apt install mongodb-org -y
sudo systemctl enable --now mongod
sudo systemctl status mongod
mongod --version
```

Edit bind IP:

```bash
sudo nano /etc/mongod.conf
# Change: bindIp: 127.0.0.1 -> 0.0.0.0 (no spaces changed)
```

```bash
sudo systemctl restart mongod
```

---

## 5. Setup Elastic IP

1. AWS Console > Elastic IPs > Allocate new IP
2. Associate with your EC2 instance
3. Update security group:

   * Allow `Custom TCP`, Port: `27017`, Source: Your Public IP & Elastic IP

---

## 6. Connect with MongoDB Compass

Use:

```txt
mongodb://YOUR_ELASTIC_IP:27017
```

Ensure your local IP is whitelisted.

---

## 7. Deploy Node.js Backend

```bash
cd /var/www/
sudo git clone https://github.com/YOUR_USER/YOUR_REPO.git
cd YOUR_REPO
sudo npm install
```

---

## 8. Setup Nginx Reverse Proxy

```bash
cd /etc/nginx/sites-available/
sudo cp default YOUR_PROJECT_NAME
sudo nano YOUR_PROJECT_NAME
```

Update:

```nginx
server {
    listen 80;
    listen [::]:80;
    root /var/www/YOUR_REPO;
    index index.html;
    server_name api.yourdomain.com;

    location / {
        proxy_pass http://localhost:YOUR_PORT;
        proxy_http_version 1.1;
        proxy_set_header Upgrade $http_upgrade;
        proxy_set_header Connection 'upgrade';
        proxy_set_header Host $host;
        proxy_cache_bypass $http_upgrade;
    }
}
```

```bash
sudo ln -s /etc/nginx/sites-available/YOUR_PROJECT_NAME /etc/nginx/sites-enabled/
sudo nano /etc/nginx/nginx.conf
# Add: client_max_body_size 100M;
sudo nginx -t
```

---

## 9. Enable SSL (HTTPS)

```bash
sudo snap install --classic certbot
sudo certbot --nginx
# Enter email, agree, choose domain
sudo certbot renew
sudo certbot renew --dry-run
```

---

## 10. Start Server

```bash
pm2 start server.js
```

---

## 11. Setup AWS S3 Bucket

1. Go to S3 > Create Bucket
2. Uncheck "Block all public access"
3. Permissions > Bucket Policy > Generate:

```json
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": "*",
      "Action": "s3:*",
      "Resource": [
        "arn:aws:s3:::your-bucket-name/*"
      ]
    }
  ]
}
```

4. Set CORS:

```json
[
    {
        "AllowedHeaders": ["*"],
        "AllowedMethods": ["GET", "HEAD"],
        "AllowedOrigins": ["*"],
        "ExposeHeaders": [],
        "MaxAgeSeconds": 3000
    }
]
```

---

## 12. Setup IAM User for S3 Access

1. IAM > Users > Add User: `S3BucketAccess`
2. Attach policy: `AmazonS3FullAccess`
3. Create access keys
4. Store `.csv` with `ACCESS_KEY` & `SECRET_KEY`

Use these keys in your app to access S3 bucket.

---

# ✅ Done! Your full-stack backend is live with MongoDB, Nginx, Node.js, subdomain + SSL, and S3 support.
