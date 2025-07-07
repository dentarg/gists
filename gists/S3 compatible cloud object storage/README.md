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

---

From https://wasabi.com/pricing/faq

> For customers using the Wasabi Pay as You Go pricing model, Wasabi has a minimum monthly charge associated with 1 TB of active storage (Note – For Wasabi Cloud NAS product, the min monthly charge is associated with 10TB of active storage). If you store less than 1 TB of active storage in your account, you will still be charged for 1 TB of storage based on the pricing associated with the storage region you are using. For further details, please refer to this knowledge base article.
> 
> Wasabi has a minimum storage duration policy that means if stored objects are deleted before they have been stored with Wasabi for a certain number of days (90 days when using the Wasabi Pay as You Go pricing model), a Timed Deleted Storage charge equal to the storage charge for the remaining days will apply. This policy is comparable to the minimum storage duration policies that exist with some AWS and other hyperscaler storage services. For more details on this policy, please refer to this knowledge base article.

> **How does Wasabi’s free egress policy work?**
>
> Wasabi’s free egress policy is designed for use cases where you store your data with Wasabi, you access this data at a reasonable rate, and your use case does not impose an unreasonable burden on our service. To better understand the definition of ‘reasonable rate’ and ‘unreasonable burden’ in this context, please consider these guidelines.
>
> - If your monthly egress data transfer is less than or equal to your active storage volume, then your storage use case is a good fit for Wasabi’s free egress policy
>
> - If your monthly egress data transfer is greater than your active storage volume, then your storage use case is not a good fit for Wasabi’s free egress policy
>
>For example, if you store 100 TB with Wasabi and download (egress) 100 TB or less within a monthly billing cycle, then your storage use case is a good fit for our policy. If your monthly downloads exceed 100 TB, then your use case is not a good fit.
>
>If your use case exceeds the guidelines of our free egress policy on a regular basis, we reserve the right to limit or suspend your service.
