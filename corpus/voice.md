# How Kenny writes

The tailor and the letter prompt read this file. It describes tone only. It never adds facts.

## Tone
- Plain, confident and specific. Write like an engineer explaining their work to another engineer, not like a brochure.
- South African / British spelling: organise, behaviour, optimise, modelling.
- Prefer the concrete noun to the abstract one: "gift-code redemption endpoints", not "solutions"; "the bank's on-premise runtime", not "the infrastructure".
- Vary sentence length. One short sentence in a paragraph is good.
- Verbs I use: built, shipped, designed, fixed, traced, moved, wrote, ran, cut, added, tested, kept.
- Verbs I never use: spearheaded, leveraged, utilised, orchestrated, championed, drove (as in "drove initiatives"), harnessed, delved.

## Letters and emails
- First person, warm but brief. No flattery of the company, no "I am thrilled / excited to apply".
- Open with the role and one specific reason this team's work matches something I have actually built.
- Each proof is one piece of work and what it changed. Say how, not how much I care.
- Close with one plain line offering to talk or send more. No "I look forward to the opportunity to discuss how I can add value".

## Samples of my own writing
•	Designed and built scalable batch and streaming ingestion pipelines from relational databases and event streams into AWS-based data lakes, leveraging S3, AWS Glue, Lake Formation, and Athena with data stored in Parquet format.
•	Played a key role in the evolution of the data lake architecture, supporting the introduction of Databricks and Apache Iceberg alongside AWS-native services to improve performance, schema evolution, and analytical workloads.
•	Developed and optimised ETL and data transformation jobs using PySpark and Spark SQL (with limited Scala where required), including tuning for partitioning, data skew, and query performance.
•	Implemented near–real-time data pipelines using Amazon Kinesis and Spark Structured Streaming to support operational and analytical use cases.
•	Contributed to data governance and platform reliability initiatives, including data lineage, metadata management, and data quality checks using AWS Glue Data Catalog and custom validation frameworks.
•	Collaborated with cloud and security teams to operate within BMW’s AWS landing zone, working with IAM, VPCs, and encryption standards to ensure compliant and secure data infrastructure.

Cool, we're working on Qwen 27B to specialize it in coding with a new algorithmic architecture improvement (discrete latent planning) that can cut planning/reasoning tokens up to 98% and get it close to Opus 5.5 performance. I think the paper should be published in a few weeks.

Also working on compute optimization side, potentially fitting the 27B model on a 8GB vRAM card with acceptable speed and the same performance.

Fair question... and my 2 cents answer is that most routers never get tested on borderline prompts. The cheap test: score every prompt with a difficulty-only baseline that never sees your model. If your router matches it, it's guessing how hard the question looks, not predicting where the small model fails. Also worth knowing that "borderline" is not a property of the prompt: the same vague ticket scored 0.25 on one small classifier and 0.80 on a bigger one. There's a checklist for exactly this (arXiv:2610.07354).

