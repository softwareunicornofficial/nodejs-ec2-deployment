#!/bin/bash

echo "=========================================="
echo "🟢 EC2 Setup Script Starting (Node.js + MongoDB + Nginx)"
echo "=========================================="

# Update system
echo "🔄 Updating packages..."
sudo apt-get update -y
sudo apt-get upgrade -y

# Install Nginx
echo "📦 Installing Nginx..."
sudo apt-get install nginx -y
sudo systemctl start nginx
sudo systemctl enable nginx

# Allow ports
echo "🔓 Allowing ports 80, 443, and SSH..."
sudo ufw allow 'Nginx Full'
sudo ufw allow OpenSSH
sudo ufw enable

# Install Node.js v22 and PM2
echo "📦 Installing Node.js and PM2..."
sudo apt-get install curl -y
curl -sL https://deb.nodesource.com/setup_22.x | sudo -E bash -
sudo apt-get install -y nodejs
sudo npm install pm2 -g

echo "✅ Node.js version: $(node -v)"
echo "✅ NPM version: $(npm -v)"

curl -fsSL https://www.mongodb.org/static/pgp/server-8.0.asc | \
   sudo gpg -o /usr/share/keyrings/mongodb-server-8.0.gpg \
   --dearmor

# Install MongoDB (Community Edition)
echo "📦 Installing MongoDB..."
curl -fsSL https://www.mongodb.org/static/pgp/server-8.0.asc | \
   sudo gpg -o /usr/share/keyrings/mongodb-server-8.0.gpg \
   --dearmor
echo "deb [ arch=amd64,arm64 signed-by=/usr/share/keyrings/mongodb-server-8.0.gpg ] https://repo.mongodb.org/apt/ubuntu noble/mongodb-org/8.0 multiverse" | sudo tee /etc/apt/sources.list.d/mongodb-org-8.0.list
sudo apt-get update -y
sudo apt-get install -y mongodb-org
sudo systemctl start mongod
sudo systemctl enable mongod

echo "✅ MongoDB status:"
sudo systemctl status mongod | grep Active

# Install Certbot for SSL (Optional)
echo "🔐 Installing Certbot (Optional for SSL)..."
sudo snap install core
sudo snap refresh core
sudo snap install --classic certbot
sudo ln -s /snap/bin/certbot /usr/bin/certbot

echo "💡 Run 'sudo certbot --nginx' manually to enable HTTPS after Nginx setup."

# Create basic project directory
echo "📁 Creating project directory..."
sudo mkdir -p /var/www
cd /var/www

echo "✅ Setup Complete. Summary:"
echo "-------------------------------"
echo "✅ Node.js installed with PM2"
echo "✅ Nginx is running on port 80"
echo "✅ MongoDB is installed and active"
echo "✅ Certbot is installed (use later for HTTPS)"
echo "✅ Project dir: /var/www"

echo "🚀 NEXT STEPS:"
echo "1️⃣ git clone your backend into /var/www"
echo "2️⃣ Configure your Nginx reverse proxy"
echo "3️⃣ Run your app with: pm2 start dist/server.js"
echo "4️⃣ (Optional) Set up SSL with Certbot"
