# S3 compatible cloud object storage

From ChatGPT: https://chatgpt.com/share/686bec7a-b64c-8000-9ce3-eccfea9f2dff

| Provider              | Storage Cost (per **TB/month**) | Egress Cost                       | API/Request Fees | Notes                                                            |
| --------------------- | ------------------------------- | --------------------------------- | ---------------- | ---------------------------------------------------------------- |
| **Backblaze B2**      | **\$5.00 – \$6.00**             | **\$10.00/TB** (3× free)          | Low              | Cheapest storage; free egress up to 3× stored data.              |
| **Wasabi**            | **\$5.99**                      | **Free**                          | None             | Free egress, but **90-day minimum retention**.                   |
| **Cloudflare R2**     | **\$15.00**                     | **Free**                          | Per request      | Egress-free; good for CDN/static assets.                         |
| **Hetzner**           | **\$5.50 – \$7.70**             | **\~\$1.30/TB**                   | Low              | Extremely cheap in EU; limited regions.                          |
| **DigitalOcean**      | **\$20.00** (flat rate)         | **1 TB free**, then \$10.00/TB    | None             | \$5/month for 250 GB + 1 TB egress. Good for dev/test.           |
| **Linode**            | **\$20.00** (flat rate)         | **1 TB free**, then \$10.00/TB    | None             | Same as DigitalOcean.                                            |
| **Scaleway**          | **\$13.00**                     | **75 GB free**, then \~\$22.00/TB | Low              | EU-based; includes cold storage tiers.                           |
| **AWS S3 (Standard)** | **\$23.00**                     | **\$90.00/TB**                    | Medium–High      | Most mature platform; expensive.                                 |
| **Google Cloud**      | **\$20.00 – \$23.00**           | **\$90.00/TB**                    | Medium–High      | Slightly cheaper than AWS; same pricing model.                   |
| **Azure Blob (Hot)**  | **\$20.00 – \$23.00**           | **\$87.00 – \$90.00/TB**          | Medium–High      | Similar to AWS and GCP; tightly integrated with Azure ecosystem. |
