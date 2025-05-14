Here's the updated guide with **TypeScript** integration for your Node.js deployment:

---

# EC2 Free Tier Deployment: Node.js with TypeScript

This guide covers the steps for deploying a Node.js application with TypeScript on an EC2 instance, including installing necessary packages, setting up Nginx as a reverse proxy, and running the app with PM2.

---

## 1. Launch EC2 Instance

* **Choose Ubuntu Free Tier (t2.micro)**
* **Allow all ports temporarily** (edit later for security)
* **Create key-pair** and download the `.pem` file for SSH access

---

## 2. Install Nginx

To install Nginx on your EC2 instance, run the following command:

```bash
sudo apt-get install nginx -y
```

Once installed, check if Nginx is running by visiting `http://YOUR_INSTANCE_PUBLIC_IP/`.

---

## 3. Install Node.js and TypeScript

First, update the package list and install `curl`:

```bash
sudo apt-get update -y
sudo apt-get install curl -y
```

Next, install Node.js and PM2 for process management:

```bash
curl -sL https://deb.nodesource.com/setup_22.x | sudo -E bash -
sudo apt-get install -y nodejs
node -v   # should show v22 or above
npm -v    # should show 9 or above
sudo npm install pm2 -g  # Install PM2 for process management
```

Now, install TypeScript globally:

```bash
sudo npm install -g typescript
```

You can verify that TypeScript has been installed by running:

```bash
tsc -v  # should show the installed TypeScript version
```

---

## 4. Deploy Node.js Backend with TypeScript

Navigate to the directory where you want to deploy your project and clone your repository from GitHub:

```bash
cd /var/www/
sudo git clone https://github.com/YOUR_USER/YOUR_REPO.git
cd YOUR_REPO
sudo npm install  # Install project dependencies
```

If your project is written in TypeScript, compile the TypeScript files using:

```bash
tsc
```

Ensure that you have a `tsconfig.json` file in your project root to configure TypeScript compilation. If not, you can generate one by running:

```bash
tsc --init
```

---

## 5. Setup Nginx Reverse Proxy

To configure Nginx as a reverse proxy for your TypeScript-based Node.js application:

1. Navigate to the Nginx configuration directory:

   ```bash
   cd /etc/nginx/sites-available/
   ```

2. Create a new configuration file for your project:

   ```bash
   sudo cp default YOUR_PROJECT_NAME
   sudo nano YOUR_PROJECT_NAME
   ```

3. Update the file to set up the reverse proxy:

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

4. Enable the site by creating a symbolic link:

   ```bash
   sudo ln -s /etc/nginx/sites-available/YOUR_PROJECT_NAME /etc/nginx/sites-enabled/
   ```

5. Update the Nginx configuration file to handle larger file uploads if needed:

   ```bash
   sudo nano /etc/nginx/nginx.conf
   # Add: client_max_body_size 100M;
   ```

6. Test and restart Nginx:

   ```bash
   sudo nginx -t
   sudo systemctl restart nginx
   ```

---

Here’s the updated section with an added point for directly starting the Node.js server without TypeScript compilation:

---

## 6. Start Node.js Server with PM2

To run your TypeScript application, you need to first compile the TypeScript files and then start the compiled JavaScript files with PM2. For a pure Node.js application (without TypeScript), you can start the server directly.

### For TypeScript:

1. Compile TypeScript files:

   ```bash
   tsc
   ```

2. Start the server using PM2:

   ```bash
   pm2 start dist/server.js
   ```

> Make sure your compiled JavaScript files are in the `dist` directory (or the directory you configured in your `tsconfig.json`).

### For Node.js (JavaScript only):

If you're using JavaScript (without TypeScript), you can start the server directly by running:

```bash
pm2 start server.js
```

---

This way, if you're using TypeScript, you need to compile first, while with JavaScript, you can directly run your `server.js` file.


> Make sure your compiled JavaScript files are in the `dist` directory (or the directory you configured in your `tsconfig.json`).

---

This completes the setup for deploying a **Node.js with TypeScript** application on your EC2 instance. You can now access your application via the configured subdomain, and it will be managed by PM2 with Nginx acting as a reverse proxy.
