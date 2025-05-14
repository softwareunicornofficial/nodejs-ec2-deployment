
# Setup AWS S3 Bucket and IAM User Access

## Setup AWS S3 Bucket

Follow these steps to create and configure an S3 bucket for your application:

### Step 1: Create a New S3 Bucket

1. Go to the **AWS S3 Console**.
2. Click on **Create Bucket**.
3. Enter a unique bucket name (e.g., `your-bucket-name`).
4. Choose a region for the bucket.
5. Click **Create** to create the bucket.

### Step 2: Disable Block All Public Access

1. In the **Bucket Settings**, uncheck the option **Block all public access**.
2. Confirm the action in the popup window.

### Step 3: Configure Bucket Policy

Go to the **Permissions** tab, and then to **Bucket Policy**. Add the following JSON policy to allow public access to your S3 bucket contents:

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

> ⚠️ Replace `your-bucket-name` with the actual name of your S3 bucket.

### Step 4: Configure CORS (Cross-Origin Resource Sharing)

Go to the **Permissions** tab, then select **CORS configuration**, and set the following JSON configuration:

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

This configuration allows your S3 bucket to serve content to any origin.

---

## 12. Setup IAM User for S3 Access

### Step 1: Create an IAM User

1. Go to **IAM Console** > **Users** > **Add User**.
2. Name the user (e.g., `S3BucketAccess`).
3. Choose **Access Type**: **Programmatic Access**.

### Step 2: Attach Policies

1. Under **Set Permissions**, choose **Attach existing policies directly**.
2. Search for and select the policy: **AmazonS3FullAccess**.

### Step 3: Generate Access Keys

1. After setting permissions, click **Next: Tags** and **Next: Review**.
2. Create the user, and on the final screen, you'll be provided with **Access Key ID** and **Secret Access Key**.
3. Download the `.csv` file that contains the credentials and store it securely.

> **Note:** Store your `ACCESS_KEY` and `SECRET_KEY` in a safe place and use them to authenticate your app's access to the S3 bucket.

---

You have now successfully set up an AWS S3 bucket and IAM user with the required permissions for accessing and managing your bucket.
