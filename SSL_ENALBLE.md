Here's the updated `CERTBOT_SSL.md` with the auto-renewal and logging instructions appended:

````markdown
# Enable SSL (HTTPS) for Nginx with Certbot

This guide will walk you through enabling SSL (HTTPS) for your Nginx server using Certbot, a free tool to obtain and manage SSL certificates.

## Step 1: Install Certbot

First, install Certbot and the Nginx plugin for automatic certificate installation:

```bash
sudo snap install --classic certbot
````

## Step 2: Obtain and Install SSL Certificate

Run Certbot to automatically configure SSL with Nginx:

```bash
sudo certbot --nginx
```

* **Enter your email address** for renewal and security notices.
* Agree to the terms and conditions.
* **Choose your domain** to configure SSL.

Certbot will automatically update your Nginx configuration to use HTTPS.

## Step 3: Test SSL Certificate Renewal

To ensure your certificate will renew automatically, run the following command to simulate a renewal process:

```bash
sudo certbot renew --dry-run
```

## Step 4: Renew SSL Certificate

Certbot will automatically renew your SSL certificate before it expires. To manually renew it, run:

```bash
sudo certbot renew
```

> ⚠️ Ensure that your Nginx configuration allows the renewal process to update the SSL certificate without errors.

---

## Step 5: Auto-Renewal Setup with Logging

To set up automatic SSL certificate renewal with logging, create a cron job that will attempt renewal twice a day and log the output.

### Edit the Cron Table:

Run the following command to open the cron configuration file:

```bash
sudo crontab -e
```

### Add the Following Line to the Cron Job:

```bash
0 0,12 * * * certbot renew --quiet >> /var/log/certbot-renewal.log 2>&1 && systemctl reload nginx >> /var/log/certbot-renewal.log 2>&1
```

### Explanation of the Command:

* `>> /var/log/certbot-renewal.log`: Appends the output of the command to the log file.
* `2>&1`: Redirects both standard output (`stdout`) and standard error (`stderr`) to the log file.
* `&& systemctl reload nginx >> /var/log/certbot-renewal.log 2>&1`: Reloads Nginx after a successful certificate renewal and logs the result.

## Step 6: Create and Set Permissions for the Log File

To make sure Certbot can write to the log file, create the log file manually and set appropriate permissions:

```bash
sudo touch /var/log/certbot-renewal.log
sudo chmod 644 /var/log/certbot-renewal.log
```

This ensures that the log file is writable by the system and readable for monitoring.

---

This completes the process of securing your site with SSL and ensuring automatic certificate renewal with logging!


```

This version includes the auto-renewal setup and instructions for logging the renewal process for better monitoring over time.
```
