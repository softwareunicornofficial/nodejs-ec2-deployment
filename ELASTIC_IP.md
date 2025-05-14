Sure! Here's the updated version with an additional line explaining the importance of an Elastic IP:

---

# Elastic IP Setup for AWS EC2

## Why Use an Elastic IP?

Elastic IPs provide a **static public IP** that doesn’t change when you stop or restart your EC2 instance, ensuring consistent access for applications, DNS, and remote services.

## Step 1: Allocate an Elastic IP

1. Go to your **AWS Management Console**.
2. Navigate to: `EC2 Dashboard → Network & Security → Elastic IPs`.
3. Click **Allocate Elastic IP address**.
4. Choose the default settings (Amazon pool) and click **Allocate**.

## Step 2: Associate Elastic IP with EC2 Instance

1. In the Elastic IP list, select the newly allocated IP.
2. Click **Actions → Associate Elastic IP address**.
3. Choose:

   * **Instance**: Select your EC2 instance.
   * **Private IP**: Leave default (unless you have multiple).
4. Click **Associate**.

✅ Your EC2 instance now has a static public IP address.

> ⚠️ Note: An Elastic IP not associated with a running instance may incur charges.

---
