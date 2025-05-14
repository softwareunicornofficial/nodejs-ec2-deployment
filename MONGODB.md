**MongoDB Installation & Configuration on Ubuntu (EC2 or Local) with MongoDB Compass Access**

---

### Step 1: Install Required Packages

```bash
sudo apt-get update -y
sudo apt-get install wget curl gnupg2 software-properties-common apt-transport-https ca-certificates lsb-release -y
```

### Step 2: Import MongoDB Public GPG Key

```bash
curl -fsSL https://www.mongodb.org/static/pgp/server-8.0.asc | \
   sudo gpg -o /usr/share/keyrings/mongodb-server-8.0.gpg \
   --dearmor
```

### Step 3: Create the list file /etc/apt/sources.list.d/mongodb-org-8.0.list for your version of Ubuntu.

```bash
echo "deb [ arch=amd64,arm64 signed-by=/usr/share/keyrings/mongodb-server-8.0.gpg ] https://repo.mongodb.org/apt/ubuntu noble/mongodb-org/8.0 multiverse" | sudo tee /etc/apt/sources.list.d/mongodb-org-8.0.list
```

### Step 4: Update and Install MongoDB (Latest Release)

```bash
sudo apt-get update -y
sudo apt-get install -y mongodb-org
```

### Step 5: Enable and Start MongoDB Service

```bash
sudo systemctl enable --now mongod
sudo systemctl status mongod
```

> ✅ If you see `active (running)` status, MongoDB is successfully installed.

### Step 6: Verify Installation

```bash
mongod --version
```

---

## MongoDB Remote Access Setup

### Step 7: Modify Bind IP (Allow external connections)

```bash
sudo nano /etc/mongod.conf
```

* Locate the `bindIp: 127.0.0.1` line and replace it with:

```
bindIp: 0.0.0.0
```

> ⚠️ Do **NOT** change spacing or formatting in the config file.

### Step 8: Restart MongoDB

```bash
sudo systemctl restart mongod
```

---

## Firewall/Security Group Configuration

### For AWS EC2:

1. Go to EC2 Dashboard → Instances → Select your instance.
2. Scroll to "Security" tab → Click Security Groups → Edit inbound rules.
3. Add Rule:

   * **Type**: Custom TCP
   * **Port Range**: `27017`
   * **Source**: Your Instance IP (or custom IP range or elastic ip)
   * **Description**: Instance IP (MongoDB Access)

4. Add Rule:

   * **Type**: Custom TCP
   * **Port Range**: `27017`
   * **Source**: Your IP (Select My Ip)
   * **Description**: Local IP (MongoDB Access)
---

## Optional: Connect via MongoDB Compass

* Connection String Format:

```
mongodb://<EC2_PUBLIC_IP>:27017
```

* Paste it into MongoDB Compass → Connect.

---

MongoDB is now fully set up on your Ubuntu machine and accessible remotely if firewall rules permit. ✅

















