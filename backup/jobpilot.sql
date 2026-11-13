BEGIN TRANSACTION;
CREATE TABLE applications (
  id            INTEGER PRIMARY KEY,
  job_id        INTEGER NOT NULL UNIQUE REFERENCES jobs(id),
  status        TEXT NOT NULL DEFAULT 'preparing',
  method        TEXT NOT NULL DEFAULT '',  -- email | website, set when applied
  contact_email TEXT NOT NULL DEFAULT '',
  base_cv       TEXT NOT NULL DEFAULT '',
  template      TEXT NOT NULL DEFAULT '',
  with_letter   INTEGER NOT NULL DEFAULT 0,
  dir           TEXT NOT NULL DEFAULT '',  -- applications/<id>-<slug>, relative to the data repo
  cv_commit     TEXT NOT NULL DEFAULT '',  -- git sha of the CV that was generated last
  checks        TEXT NOT NULL DEFAULT '',  -- JSON, see section 8.5
  created_at    TEXT NOT NULL,
  applied_at    TEXT,
  followup_on   INTEGER NOT NULL,
  followup_days INTEGER NOT NULL,
  followup_max  INTEGER NOT NULL,
  followup_mode TEXT NOT NULL,             -- draft | auto
  notes         TEXT NOT NULL DEFAULT ''
);
INSERT INTO "applications" VALUES(1,1,'preparing','','','ai-ml','cv.docx',1,'applications/1-unnamed-client-via-careerjunct','6d7d312b90e5d5ec3c05a715eea5f8839ce08ded','{"errors": [], "pages": 2, "coverage": 1.0, "not_shown": [], "missing": ["Bachelor''s degree", "SQL", "model training", "deployment", "MLOps practices", "ML infrastructure", "AI-powered applications", "AWS certifications", "AWS Bedrock", "Bedrock AgentCore", "Open-source contributions", "startup experience", "Master''s or PhD"], "gaps": ["Bachelor''s degree in Computer Science, Engineering, Software Engineering, Applied Mathematics, Statistics or related field", "Strong SQL skills", "Developing intelligent agents", "Deploying solutions into an AI marketplace environment", "AWS certifications", "Experience with AWS Bedrock and Bedrock AgentCore", "Master''s or PhD in AI, Machine Learning or related field"]}','2026-11-12T21:48:11Z',NULL,1,7,2,'draft','');
INSERT INTO "applications" VALUES(2,2,'preparing','','','ai-ml','cv.docx',1,'applications/2-sabenza-it-recruitment','5a52847045d385b1a211815be4c4dfd87849bc8d','{"errors": [], "pages": 2, "coverage": 1.0, "not_shown": [], "missing": ["tertiary qualification", "SQL", "API development", "Databricks", "MLflow", "Kubernetes", "AKS", "Spark", "RAG", "AI agents", "Microsoft Azure certifications", "Databricks certifications", "Kubernetes certifications", "DevOps certifications", "MLOps certifications", "AWS certifications", "Google Cloud certifications"], "gaps": ["Matric and tertiary qualification (degree)", "Databricks and MLflow", "Kubernetes and Azure Kubernetes Service (AKS)", "SQL", "Distributed computing and large-scale data processing such as Spark", "RAG solutions and AI agents", "Mentoring junior engineers", "Azure, Databricks, Kubernetes, MLOps, AWS, or Google Cloud certifications"]}','2026-11-13T04:34:11Z',NULL,1,7,2,'draft','');
INSERT INTO "applications" VALUES(3,3,'preparing','','','full-stack','cv.docx',1,'applications/3-data-analytics-solutions-provi','91347ec365b99b89dc2e54d6bd509b44033ebff7','{"errors": [], "pages": 2, "coverage": 1.0, "not_shown": [], "missing": ["Bachelor''s degree or diploma", "software development experience", "Frontend and backend development", "APIs", "integrations", "major cloud platform", "source control", "JavaScript/TypeScript", "SQL", "DevOps practices", "machine learning solutions"], "gaps": ["Bachelor''s degree or diploma in Computer Science, Software Engineering, IT or related field", "SQL, database structure design, stored procedures, migrations, and listed databases (Microsoft SQL Server, PostgreSQL, MySQL, MongoDB) in recorded claims", "Role claims supporting C#, ASP.NET, .NET Core, Flask, Node.js, and NestJS", "Role claims supporting React, Angular, HTML5, and CSS3", "Microsoft Azure, Azure DevOps, Kubernetes, Jenkins, and Git in recorded claims", "RESTful API design"]}','2026-11-13T04:38:09Z',NULL,1,7,2,'draft','');
INSERT INTO "applications" VALUES(4,4,'rejected','email','kenmbi290@gmail.com','full-stack','cv.docx',1,'applications/4-v2-test-company','1f408ee1759782f48a8f98bda20614f662de6354','{"errors": [], "pages": 2, "coverage": 1.0, "not_shown": [], "missing": ["ASP.NET Core", "Microsoft Azure", "leading small engineering teams"], "gaps": ["4+ years building web APIs with C# and ASP.NET Core", "Experience running services on Microsoft Azure", "Experience leading small engineering teams", "Experience building and running payment APIs", "Experience mentoring engineers"]}','2026-11-13T08:54:19Z','2026-11-13T09:00:19Z',1,7,2,'draft','');
INSERT INTO "applications" VALUES(5,5,'assessment','website','','','cv.docx',0,'applications/5-website-test-company','','','2026-11-13T09:01:20Z','2026-11-13T09:02:45Z',1,7,2,'draft','');
CREATE TABLE events (
  id             INTEGER PRIMARY KEY,
  application_id INTEGER REFERENCES applications(id),  -- NULL for run events
  at             TEXT NOT NULL,
  type           TEXT NOT NULL,            -- status | run
  detail         TEXT NOT NULL DEFAULT '', -- status: the new status. run: JSON summary
  cause          TEXT NOT NULL DEFAULT ''  -- manual | rule | message:<messages.id>
);
INSERT INTO "events" VALUES(1,4,'2026-11-13T09:00:19Z','status','applied','manual');
INSERT INTO "events" VALUES(2,5,'2026-11-13T09:02:45Z','status','applied','manual');
INSERT INTO "events" VALUES(3,4,'2026-11-13T09:03:28Z','status','interview','message:2');
INSERT INTO "events" VALUES(4,4,'2026-11-13T09:03:51Z','status','rejected','manual');
INSERT INTO "events" VALUES(5,4,'2026-11-13T09:11:49Z','status','withdrawn','manual');
INSERT INTO "events" VALUES(6,5,'2026-11-13T09:11:50Z','status','withdrawn','manual');
INSERT INTO "events" VALUES(7,4,'2026-11-13T09:40:25Z','status','applied','manual');
INSERT INTO "events" VALUES(8,NULL,'2026-11-13T10:19:56Z','run','{"at": "2026-11-13T09:57:48Z", "errors": [], "mail": {"alerts": 13, "new_jobs": 36, "reply": 0, "review": 1, "ignored": 266}, "adzuna": {"new_jobs": 42}, "score": {"scored": 68}, "followups": {"closed": 0, "drafted": 0, "sent": 0}, "backup": {"file": "jobpilot-20261113.db"}}','');
INSERT INTO "events" VALUES(9,4,'2026-11-13T10:37:42Z','status','acknowledged','message:287');
INSERT INTO "events" VALUES(10,4,'2026-11-13T11:44:09Z','status','assessment','message:297');
INSERT INTO "events" VALUES(11,4,'2026-11-13T11:57:19Z','status','interview','message:300');
INSERT INTO "events" VALUES(12,4,'2026-11-13T12:07:39Z','status','offer','message:303');
INSERT INTO "events" VALUES(13,4,'2026-11-13T12:21:51Z','status','rejected','message:305');
INSERT INTO "events" VALUES(14,5,'2026-11-13T12:23:43Z','status','applied','manual');
INSERT INTO "events" VALUES(15,5,'2026-11-13T12:46:43Z','status','assessment','message:312');
INSERT INTO "events" VALUES(16,NULL,'2026-11-13T12:59:36Z','run','{"at": "2026-11-13T12:59:10Z", "errors": [], "mail": {"alerts": 0, "new_jobs": 0, "reply": 0, "review": 0, "ignored": 0}, "adzuna": {"new_jobs": 0}, "score": {"scored": 3}, "followups": {"closed": 0, "drafted": 0, "sent": 0}, "backup": {"file": "jobpilot-20261113.db"}}','');
INSERT INTO "events" VALUES(17,NULL,'2026-11-13T13:00:00Z','run','{"at": "2026-11-13T12:59:43Z", "errors": [], "mail": {"alerts": 0, "new_jobs": 0, "reply": 0, "review": 0, "ignored": 0}, "adzuna": {"new_jobs": 0}, "score": {"scored": 0}, "followups": {"closed": 0, "drafted": 0, "sent": 0}, "backup": {"file": "jobpilot-20261113.db"}}','');
CREATE TABLE jobs (
  id           INTEGER PRIMARY KEY,
  fingerprint  TEXT NOT NULL UNIQUE,
  title        TEXT NOT NULL,
  company      TEXT NOT NULL DEFAULT '',
  location     TEXT NOT NULL DEFAULT '',
  url          TEXT NOT NULL DEFAULT '',
  sources      TEXT NOT NULL DEFAULT '',   -- comma-separated, sorted: adzuna,linkedin,paste,pnet
  snippet      TEXT NOT NULL DEFAULT '',
  full_text    TEXT NOT NULL DEFAULT '',
  score        INTEGER,                    -- 0-100, NULL = not scored yet
  score_reason TEXT NOT NULL DEFAULT '',
  base_cv      TEXT NOT NULL DEFAULT '',   -- base CV the scorer suggests
  keywords     TEXT NOT NULL DEFAULT '',   -- JSON {"must_have":[],"nice_to_have":[]}, set by analyse_job
  flags        TEXT NOT NULL DEFAULT '',   -- comma-separated: no_company,repost,suspicious
  state        TEXT NOT NULL DEFAULT 'new',-- new | filtered | dismissed | applying
  first_seen   TEXT NOT NULL,
  last_seen    TEXT NOT NULL
);
INSERT INTO "jobs" VALUES(1,'e1a0b35fbbad8d9b979d05b1df4353a0cef7017b','Machine Learning Engineer (Intermediate / Senior)','Unnamed client (via CareerJunction)','Remote, South Africa','https://it-online.co.za/2026/08/14/machine-learning-engineer-intermediate-senior-remote-south-africa/','paste','','Machine Learning Engineer (Intermediate / Senior) - Remote, South Africa

Our client is looking for a Machine Learning Engineer to design, build, deploy and maintain production machine learning solutions.

Responsibilities
- Design, build, deploy and maintain production machine learning solutions
- Develop AI-powered applications, automation tools and intelligent agents
- Build and optimise data pipelines, model training pipelines and inference workflows
- Implement MLOps practices including CI/CD, monitoring, deployment and scaling
- Work with AWS-based cloud infrastructure to support AI applications
- Develop and maintain APIs and AI services
- Collaborate with data scientists, engineers and business stakeholders
- Contribute to AI platform engineering and internal AI product development
- Support deploying solutions into an AI marketplace environment

Essential requirements
- Bachelor''s degree in Computer Science, Engineering, Software Engineering, Applied Mathematics, Statistics or related field
- 2+ years'' experience in machine learning, data science or data engineering
- 2+ years'' software development experience in Python
- Strong SQL skills
- 1+ year hands-on AWS experience
- Experience with model training, deployment, monitoring and MLOps practices
- Experience building scalable ML infrastructure and AI-powered applications
- Strong software engineering principles and coding best practices
- Excellent communication and stakeholder engagement skills

Highly advantageous
- AWS certifications
- Experience with AWS Bedrock and Bedrock AgentCore
- Open-source contributions or startup experience
- Master''s or PhD in AI, Machine Learning or related field

Apply via CareerJunction. Only shortlisted candidates will be contacted.',93,'Excellent match across core technologies, machine learning focus, AWS expertise, and required seniority level.','ai-ml','{"must_have": ["Bachelor''s degree", "machine learning", "Python", "SQL", "AWS", "model training", "deployment", "monitoring", "MLOps practices", "ML infrastructure", "AI-powered applications", "communication skills"], "nice_to_have": ["AWS certifications", "AWS Bedrock", "Bedrock AgentCore", "Open-source contributions", "startup experience", "Master''s or PhD"]}','','applying','2026-11-12T21:48:11Z','2026-11-12T21:48:11Z');
INSERT INTO "jobs" VALUES(2,'5dc9c0a42a5a09e8da6c75c232c53b37d8421527','Senior ML Engineer','Sabenza IT & Recruitment','Johannesburg, Gauteng','https://it-online.co.za/2026/09/07/senior-ml-engineer-at-sabenza-it-recruitment-gauteng-johannesburg/','paste','','Senior ML Engineer - Sabenza IT & Recruitment - Johannesburg, Gauteng

Responsibilities
- Deploy and monitor machine learning models and data science pipelines on Databricks
- Build and support AI agents, generative AI applications and RAG solutions on Databricks
- Develop reusable ML pipelines following MLOps practices: CI/CD, automated testing, monitoring and governance
- Deploy and manage open-source AI and ML models on Azure Kubernetes Service (AKS)
- Build custom APIs and microservices on AKS exposing AI capabilities to business applications
- Containerise solutions with Docker and Kubernetes for scalable, secure deployments
- Track model performance, drift, reliability and operational health in production
- Work with Data Scientists to turn prototypes into production-ready solutions
- Coordinate with platform, security, cloud and infrastructure teams to meet enterprise standards
- Troubleshoot production issues across models, pipelines, APIs and AI applications
- Optimise AI/ML solutions for performance, scalability, cost and reliability
- Contribute to engineering standards, reusable frameworks and best practices
- Mentor junior engineers and encourage knowledge sharing

Requirements
- Matric and a tertiary qualification (degree)
- Experience building, deploying and supporting ML solutions in production
- Proficiency in Python, with SQL and API development experience
- Experience with Databricks, MLflow, Model Serving and cloud-native AI/ML platforms
- Hands-on experience with Kubernetes, Docker and containerised deployments
- Experience deploying ML and GenAI solutions on AKS
- Knowledge of CI/CD pipelines, infrastructure automation and platform monitoring
- Experience with distributed computing and large-scale data processing such as Spark
- Understanding of ML, LLMs, RAG and AI agents
- Experience taking end-to-end AI/ML use cases from development to production
- Strong communication skills for stakeholders and cross-functional teams
- Self-driven and adaptable in a fast-paced environment

Desirable
- Microsoft Azure certifications (AZ-104, AZ-305 or AI-102)
- Databricks certifications
- Kubernetes certifications (CKA or CKAD)
- DevOps, MLOps or platform engineering certifications
- AWS or Google Cloud certifications

Apply via CareerJunction: https://www.careerjunction.co.za/jobs/view/2644736',80,'Strong senior ML, Python, and MLOps match, but lacks stated hands-on Databricks and Azure/AKS experience.','ai-ml','{"must_have": ["tertiary qualification", "Python", "SQL", "API development", "Databricks", "MLflow", "Kubernetes", "Docker", "AKS", "CI/CD pipelines", "Spark", "LLMs", "RAG", "AI agents"], "nice_to_have": ["Microsoft Azure certifications", "Databricks certifications", "Kubernetes certifications", "DevOps certifications", "MLOps certifications", "AWS certifications", "Google Cloud certifications"]}','','applying','2026-11-13T04:34:11Z','2026-11-13T04:34:11Z');
INSERT INTO "jobs" VALUES(3,'cd208fe9f2cf733893e1479f7ecfb6cea5ab1b3b','Full Stack Software Engineer (Python, C#, React)','Data & Analytics Solutions provider (via CareerJunction)','Johannesburg, onsite','https://it-online.co.za/2026/08/25/full-stack-software-engineer-python-c-react-jhb-onsite/','paste','','Full Stack Software Engineer (Python, C#, React) - Johannesburg, onsite

Our client, a provider of Data & Analytics Solutions, is looking for a Full Stack Software Engineer.

Responsibilities
Software development
- Build, test and maintain high-quality frontend and backend applications for web and enterprise systems
- Create secure, scalable APIs; meet performance and security targets; troubleshoot and optimise systems
Systems integration
- Integrate internal and external systems, design RESTful APIs and web services, support third-party integrations
Database management
- Design and maintain database structures, write queries, stored procedures and reports, support migrations
Cloud and deployment
- Deploy and maintain applications in the cloud, implement CI/CD pipelines, support releases and production
DevOps and support
- Monitor application health, resolve production issues, maintain documentation and technical standards
Collaboration
- Gather requirements from business stakeholders, work with project managers, developers and designers, help with planning and estimation

Requirements
- Bachelor''s degree or diploma in Computer Science, Software Engineering, IT or related field
- 3 to 5 years of software development experience, including deploying production-ready applications
- Frontend and backend development experience, APIs, integrations and enterprise applications
- Experience with a major cloud platform (Azure, AWS or Google Cloud)
- Experience with source control and supporting systems in production

Tech stack
- Languages: JavaScript/TypeScript, Python, C#, SQL
- Frontend: React, Angular, HTML5, CSS3
- Backend: Node.js, NestJS, ASP.NET, .NET Core, Flask
- Databases: Microsoft SQL Server, PostgreSQL, MySQL, MongoDB
- Cloud: Microsoft Azure, AWS, Google Cloud Platform
- DevOps: Git, Docker, Kubernetes, Azure DevOps, Jenkins, CI/CD pipelines

Nice to have
- Exposure to DevOps practices and CI/CD pipelines
- Experience with AI, automation or machine learning solutions

Apply via CareerJunction (job 2644253).',95,'Strong match on Python, React, and cloud in Johannesburg, with bonus AI and DevOps experience directly aligning.','full-stack','{"must_have": ["Bachelor''s degree or diploma", "software development experience", "Frontend and backend development", "APIs", "integrations", "major cloud platform", "source control", "Python", "C#", "React", "JavaScript/TypeScript", "SQL"], "nice_to_have": ["DevOps practices", "CI/CD pipelines", "AI", "automation", "machine learning solutions"]}','','applying','2026-11-13T04:38:09Z','2026-11-13T04:38:09Z');
INSERT INTO "jobs" VALUES(4,'5bc687e1b0c8516a2677db4ed100b9cca197b6e4','Backend Engineer (V2 TEST)','V2 Test Company','Remote','https://example.com/v2-test-advert','paste','','V2 TEST ADVERT - not a real job.

V2 Test Company is hiring a Backend Engineer to build and run payment APIs.

Requirements:
- 4+ years building web APIs with C# and ASP.NET Core
- Experience running services on Microsoft Azure
- Experience leading small engineering teams
- Python is a plus

You will improve API performance, migrate services to the cloud and mentor engineers.',50,'Candidate has working C# knowledge and backend leadership, but lacks extensive ASP.NET Core and Azure experience.','full-stack','{"must_have": ["C#", "ASP.NET Core", "Microsoft Azure", "leading small engineering teams"], "nice_to_have": ["Python"]}','','applying','2026-11-13T08:54:19Z','2026-11-13T08:54:19Z');
INSERT INTO "jobs" VALUES(5,'b53d57e440dbe07fa5f04db915b7e1588d376ffe','Website Apply Test Role','Website Test Company','Remote','https://example.com/website-test-advert','paste','','TEST ADVERT - not a real job. Website Test Company is hiring a Python developer to build data pipelines. Requirements: Python, SQL, AWS. Apply on our website.',60,'Matches Python and AWS requirements for data pipelines, but candidate lacks SQL and advert is a test posting.','ai-ml','{"must_have": ["Python", "SQL", "AWS"], "nice_to_have": []}','suspicious','applying','2026-11-13T09:01:19Z','2026-11-13T09:01:19Z');
INSERT INTO "jobs" VALUES(6,'c51b606d669be82ca279f73c25d0bb47860ed3b7','AI Software Engineer (Remote, Durban)','Blacksmith Agency','South Africa (Remote)','https://www.linkedin.com/jobs/view/4488798399','linkedin','','',95,'Excellent match for AI software engineering skills, Python, and remote location in South Africa.','ai-ml','','','new','2026-11-13T09:59:03Z','2026-11-13T10:11:29Z');
INSERT INTO "jobs" VALUES(7,'e5d32d90805587c93dd65dd9b23e142064ddb5a7','AI Agent Engineer (Remote, Gqeberha)','Blacksmith Agency','South Africa (Remote)','https://www.linkedin.com/jobs/view/4488796465','linkedin','','',95,'Strong match for LLM and agent development with Python, AI, and LangChain experience.','ai-ml','','','new','2026-11-13T09:59:03Z','2026-11-13T09:59:03Z');
INSERT INTO "jobs" VALUES(8,'4a05a4e4f551d507d70e21d8f81c4eaeaa6b41a7','Full Stack Developer (C#/.NET & Angular) | Mid to Senior','DT Projects SA','City of Cape Town (On-site)','https://www.linkedin.com/jobs/view/4488860542','linkedin','','',NULL,'','','','','filtered','2026-11-13T09:59:03Z','2026-11-13T10:00:46Z');
INSERT INTO "jobs" VALUES(9,'0b9987b5b3f40302f3d40be1ab72d8557ba7b138','Software Developer – Healthcare Tech','Virtustant','South Africa (Remote)','https://www.linkedin.com/jobs/view/4487130206','linkedin','','',75,'Good fit for general software development background, though specific tech stack is not specified.','full-stack','','','new','2026-11-13T09:59:03Z','2026-11-13T10:06:26Z');
INSERT INTO "jobs" VALUES(10,'939e82e03bff0fd27408d2ae3b2b3f2592aafae8','.NET Fullstack Developer','Samaha Consulting','Sandton (On-site)','https://www.linkedin.com/jobs/view/4487729487','linkedin','','',55,'Candidate only has working knowledge of .NET and C#, though full-stack fundamentals align.','full-stack','','','new','2026-11-13T09:59:03Z','2026-11-13T09:59:03Z');
INSERT INTO "jobs" VALUES(11,'a1ad3126cf14f9d3bdfefece1c701fc3d8db839b','Applied AI Engineer (Remote, Durban)','Blacksmith Agency','South Africa (Remote)','https://www.linkedin.com/jobs/view/4488808025','linkedin','','',95,'Direct match for AI, Machine Learning, Python, and cloud deployment expertise.','ai-ml','','','new','2026-11-13T09:59:03Z','2026-11-13T10:06:26Z');
INSERT INTO "jobs" VALUES(12,'1f495972304e8bfc66c07d3172ead77d9fc07ef5','Senior Linux Embedded Developer','Sedna Inc','Greenstone Hill (Hybrid)','https://www.linkedin.com/jobs/view/4487683360','linkedin','Reports To Principal Embedded…','',NULL,'','','','','filtered','2026-11-13T09:59:56Z','2026-11-13T10:00:46Z');
INSERT INTO "jobs" VALUES(13,'a4ebb55a8e9024ea78a7c43a6d829de1401922b1','Software Developer (C# - FULLY REMOTE)','Network Recruitment','Pretoria (Remote)','https://www.linkedin.com/jobs/view/4472620710','linkedin','','',50,'Candidate''s primary focus is Python and JS, holding only working knowledge of C#.','full-stack','','','new','2026-11-13T10:00:46Z','2026-11-13T10:00:46Z');
INSERT INTO "jobs" VALUES(14,'7449a418ed29281ca17799fe95c0dc13d2a312ee','Java Software Engineer','Samaha Consulting','Johannesburg Metropolitan Area (Hybrid)','https://www.linkedin.com/jobs/view/4488822637','linkedin','','',30,'Candidate lacks professional Java experience, specializing in Python and JavaScript.','general','','','new','2026-11-13T10:00:46Z','2026-11-13T10:00:46Z');
INSERT INTO "jobs" VALUES(15,'afbd9f5d254c7024601b9ad6d1ec843725ef1f83','Snr Java Developer - Fully Remote','Network Recruitment','Pretoria (Remote)','https://www.linkedin.com/jobs/view/4478658357','linkedin','','',25,'Core technology Java is missing from candidate''s profile.','general','','','new','2026-11-13T10:00:46Z','2026-11-13T10:00:46Z');
INSERT INTO "jobs" VALUES(16,'b0f3047c6b0476b17b1cd49f3b5276fd320a50bc','Senior Software Engineer - Frontend - Consumer','Ink Foundation','South Africa (Remote)','https://www.linkedin.com/jobs/view/4489156049','linkedin','','',85,'Strong senior frontend background with React, TypeScript, and JavaScript experience.','full-stack','','','new','2026-11-13T10:02:53Z','2026-11-13T10:07:55Z');
INSERT INTO "jobs" VALUES(17,'459a2a349958c4f483f9987c47d271257d4dfb2e','Senior Software Engineer - React Native - Consumer','Ink Foundation','South Africa (Remote)','https://www.linkedin.com/jobs/view/4489134967','linkedin','','',90,'Excellent senior match with proven proficiency in React Native and mobile application development.','full-stack','','','new','2026-11-13T10:02:53Z','2026-11-13T10:07:55Z');
INSERT INTO "jobs" VALUES(18,'f1a901944ebaf2a2e6301680c1896966a478abf7','Software Engineer: Core','Jobgether','South Africa (Remote)','https://www.linkedin.com/jobs/view/4487451634','linkedin','','',75,'Good alignment with senior backend, architecture, and general software engineering skills.','general','','','new','2026-11-13T10:05:05Z','2026-11-13T10:05:05Z');
INSERT INTO "jobs" VALUES(19,'aa2130e831a5c784fbff0ea1d62eff0c182416c4','Software Engineer','OfferZen','City of Cape Town (Hybrid)','https://www.linkedin.com/jobs/view/4488866818','linkedin','','',NULL,'','','','','filtered','2026-11-13T10:05:05Z','2026-11-13T10:05:05Z');
INSERT INTO "jobs" VALUES(20,'985a6e909ef80477659eb35db212bbc76f79495b','Full Stack Engineer','Mind Detect','City of Cape Town (Hybrid)','https://www.linkedin.com/jobs/view/4487175850','linkedin','','',NULL,'','','','','filtered','2026-11-13T10:05:05Z','2026-11-13T10:05:05Z');
INSERT INTO "jobs" VALUES(21,'509b0627b75609cdf48017f7075c4cc78e826fed','Java Fullstack Software Engineer (Spring Boot / Angular)','Jobgether','South Africa (Remote)','https://www.linkedin.com/jobs/view/4488357247','linkedin','','',30,'Mismatch on core tech stack requiring Java, Spring Boot, and Angular.','full-stack','','','new','2026-11-13T10:05:05Z','2026-11-13T10:05:05Z');
INSERT INTO "jobs" VALUES(22,'c75f8cb97a9d3947d2ffae57d9caa7e46204c2f1','Senior Software Engineer (Golang)','DigiCert','Western Cape, South Africa (Hybrid)','https://www.linkedin.com/jobs/view/4480226972','linkedin','','',25,'Candidate does not know Golang and is based in Johannesburg, not Western Cape.','general','','','new','2026-11-13T10:05:05Z','2026-11-13T10:05:05Z');
INSERT INTO "jobs" VALUES(23,'e63be4c2776a5b102db7cd02920d101064e1e7a8','Senior .NET Engineer','ECM Ground (Pty) Ltd','Sandton (On-site)','https://www.linkedin.com/jobs/view/4487474178','linkedin','','',45,'Candidate possesses only working knowledge of .NET and C#, falling short for a senior role.','general','','','new','2026-11-13T10:05:05Z','2026-11-13T10:05:05Z');
INSERT INTO "jobs" VALUES(24,'d1ef5914db02d54e71b60baf584bd15492bc5013','AI Developer (Remote, Polokwane)','Blacksmith Agency','South Africa (Remote)','https://www.linkedin.com/jobs/view/4489114644','linkedin','','',95,'Exceptional match for AI and machine learning engineering background in Python.','ai-ml','','','new','2026-11-13T10:06:26Z','2026-11-13T10:06:26Z');
INSERT INTO "jobs" VALUES(25,'180c6559914d2836dd0ccaf037b3047a0e679334','Senior Frontend Developer','Stock2Shop','Cape Town','https://www.linkedin.com/jobs/view/4489423508','linkedin','','',NULL,'','','','','filtered','2026-11-13T10:06:26Z','2026-11-13T10:06:26Z');
INSERT INTO "jobs" VALUES(26,'60fb4b117cb5dac8eb9f6ec5b8b87ac85be2efbe','Frontend Developer','Betway Global','City of Cape Town (Hybrid)','https://www.linkedin.com/jobs/view/4488207815','linkedin','','',NULL,'','','','','filtered','2026-11-13T10:10:18Z','2026-11-13T10:14:14Z');
INSERT INTO "jobs" VALUES(27,'98e18f6009fbd489d93d8064b5d41360b78d9fdb','Senior Frontend Developer','Jobgether','South Africa (Remote)','https://www.linkedin.com/jobs/view/4488656890','linkedin','','',72,'Matches senior level and React/JS skills, but candidate''s focus is broader full-stack and AI.','full-stack','','','new','2026-11-13T10:10:18Z','2026-11-13T10:14:14Z');
INSERT INTO "jobs" VALUES(28,'465114dba3b45066d989052c773c47db7c8fb016','Senior Full Stack Engineer (Node/React) - Remote','Kake','South Africa (Remote)','https://www.linkedin.com/jobs/view/4487496418','linkedin','','',92,'Strong match with 8 years experience and proficiency in Node.js, React, and cloud architectures.','full-stack','','','new','2026-11-13T10:10:18Z','2026-11-13T10:14:14Z');
INSERT INTO "jobs" VALUES(29,'da3b09a2d46d39b894a29f99350c041025490602','Senior Software Engineer - Digital Workplace','Canonical','Johannesburg (Remote)','https://www.linkedin.com/jobs/view/4489637388','linkedin','','',82,'Strong senior engineering match in candidate''s location with solid Python, Linux, and backend experience.','general','','','new','2026-11-13T10:10:18Z','2026-11-13T10:14:14Z');
INSERT INTO "jobs" VALUES(30,'acb184751cdf9f78fa5c456d565eda70c6f527d9','Junior Web Developer','Rotate Digital','South Africa (Remote)','https://www.linkedin.com/jobs/view/4489000707','linkedin','','',NULL,'','','','','filtered','2026-11-13T10:11:29Z','2026-11-13T10:11:29Z');
INSERT INTO "jobs" VALUES(31,'668b037caeedbc164782d85aa90eabd2b3c63a37','AI Engineer (Remote, Johannesburg)','Blacksmith Agency','South Africa (Remote)','https://www.linkedin.com/jobs/view/4489636053','linkedin','','',96,'Excellent match; candidate is an expert in Python and Machine Learning with LLM proficiency.','ai-ml','','','new','2026-11-13T10:11:29Z','2026-11-13T10:17:17Z');
INSERT INTO "jobs" VALUES(32,'d3441adafd85433c4ef1dba93571378e0d9d29e7','Intermediate JavaScript Software Engineer','Entelect','City of Johannesburg (Hybrid)','https://www.linkedin.com/jobs/view/4478869227','linkedin','','',58,'Candidate is overqualified with 8 years of experience for an intermediate JavaScript role.','full-stack','','','new','2026-11-13T10:11:29Z','2026-11-13T10:14:14Z');
INSERT INTO "jobs" VALUES(33,'df8eeb40de20705f180c4e573fcaaa45555b6749','Software Engineer, AI Integrations','Jobgether','South Africa (Remote)','https://www.linkedin.com/jobs/view/4488676727','linkedin','','',93,'Superb match for Python, LLM frameworks, API integrations, and cloud software development.','ai-ml','','','new','2026-11-13T10:11:29Z','2026-11-13T10:13:14Z');
INSERT INTO "jobs" VALUES(34,'0c6d7e9d80f20d0edd0cce28b007e9bba1231aac','.NET Developer','Risingsun Softsol','Sandton (On-site)','https://www.linkedin.com/jobs/view/4488225550','linkedin','','',42,'Dot Net and C# are only secondary working skills; core expertise lies in Python and AI.','full-stack','','','new','2026-11-13T10:11:29Z','2026-11-13T10:13:14Z');
INSERT INTO "jobs" VALUES(35,'a2f423af5c19815dafaaae45ec26bb04e7ec3dd2','Staff AI Product Engineer','Jobgether','South Africa (Remote)','https://www.linkedin.com/jobs/view/4488679330','linkedin','','',90,'Strong match for staff-level AI product building, leveraging Python, ML, and full-stack capabilities.','ai-ml','','','new','2026-11-13T10:13:14Z','2026-11-13T10:13:14Z');
INSERT INTO "jobs" VALUES(36,'6e49e6789146cc720d6c037e16faa9ba4d2a3add','Lead Software Engineer / Technical Lead | R120,000–R160,000 CTC per Month | UK Client | January 2027','NOSWEAT.CO.ZA','South Africa (Remote)','https://www.linkedin.com/jobs/view/4488652975','linkedin','','',85,'Matches candidate''s 8 years of experience and Technical Lead skills for remote UK-aligned work.','general','','','new','2026-11-13T10:13:14Z','2026-11-13T10:13:14Z');
INSERT INTO "jobs" VALUES(37,'cab7df11b50f087a1f520598754eaac6eeda1b50','Software Developer – Remote Staffing','Virtustant','South Africa (Remote)','https://www.linkedin.com/jobs/view/4488278646','linkedin','','',72,'General software developer match covering candidate''s broad full-stack, cloud, and engineering background.','general','','','new','2026-11-13T10:16:02Z','2026-11-13T10:16:02Z');
INSERT INTO "jobs" VALUES(38,'7d5d59f8049ec320d77d2c1a5fcfddb8632828f8','Full Stack Software Engineer - AI-First','Jobgether','South Africa (Remote)','https://www.linkedin.com/jobs/view/4489092435','linkedin','','',96,'Ideal match blending candidate''s proficient full-stack skills with expert AI and ML experience.','full-stack','','','new','2026-11-13T10:17:17Z','2026-11-13T11:57:08Z');
INSERT INTO "jobs" VALUES(39,'47fdef3f8d14ffed311183a9582dd379058f16cd','Software Engineer - AI Tooling','Jobgether','South Africa (Remote)','https://www.linkedin.com/jobs/view/4489083872','linkedin','','',94,'Highly aligned with candidate''s ML engineering, Python expertise, and experience with developer tooling.','ai-ml','','','new','2026-11-13T10:17:17Z','2026-11-13T11:57:09Z');
INSERT INTO "jobs" VALUES(40,'74c5779158d34efe5a3bce4c9946b9348206948f','Senior Software Engineer','Acuity Consultants','Johannesburg Metropolitan Area (Hybrid)','https://www.linkedin.com/jobs/view/4488504731','linkedin','','',85,'Fits senior engineering profile and local Johannesburg market with solid software architecture capabilities.','general','','','new','2026-11-13T10:17:17Z','2026-11-13T10:17:17Z');
INSERT INTO "jobs" VALUES(41,'780374a1857624133dda9147cfb48fd82af2b6c3','Software Engineer (Front-End)','DigiOutsource','Cape Town','https://www.linkedin.com/jobs/view/4489026622','linkedin','','',NULL,'','','','','filtered','2026-11-13T10:17:17Z','2026-11-13T10:17:17Z');
INSERT INTO "jobs" VALUES(42,'569a4ef043e13821deb0b7c88dad2772ee820c7c','Junior Software Developer','Network IT','East Johannesburg, Johannesburg','https://www.adzuna.co.za/details/5964325032?utm_medium=api&utm_source=947c6c7e','adzuna','Reference: ITA006580-Rein-1 Our client is looking for a Junior Software Developer with a passion for software development and a solid foundation in the Microsoft technology stack. This is a permanent, full-time position based in Wadeville, Germiston, offering an excellent opportunity for a developer at the start of their career to gain exposure across the full software development lifecycle while working alongside experienced developers. The successful candidate will assist in developing, maint…','',NULL,'','','','','filtered','2026-11-13T10:17:20Z','2026-11-13T13:18:46Z');
INSERT INTO "jobs" VALUES(43,'bb5e6e3c5daf15054d160bf3f2bdbdf0b0c3e490','Senior .NET Developer','Subhujo Technologies','Central Johannesburg, Johannesburg','https://www.adzuna.co.za/details/5964324816?utm_medium=api&utm_source=947c6c7e','adzuna','Introduction Looking for a Senior .NET Developer Duties & Responsibilities Core Development & Architecture: · Build and enhance scalable systems within a distributed microservices architecture. · Design and implement RESTful APIs with strong versioning and documentation standards. · Develop event driven services using message queue technologies to support high volume, asynchronous workloads. · Design and optimize databases, queries, and indexing for ultra high throughput environments. · Impleme…','',45,'Requires senior-level .NET and C# expertise, which are only secondary working skills for candidate.','full-stack','','','new','2026-11-13T10:17:20Z','2026-11-13T13:18:46Z');
INSERT INTO "jobs" VALUES(44,'b27bfbdd33082bc7a4e6105772aa464921c818ca','Full Stack Developer','Network IT','North Johannesburg, Johannesburg','https://www.adzuna.co.za/details/5964323381?utm_medium=api&utm_source=947c6c7e','adzuna','Reference: ITE008277-Bia-1 Are you a skilled Full Stack Developer looking to work on modern web applications within a collaborative and growth-focused environment? We are seeking a developer who can contribute across the full development lifecycle, from building user-facing applications to developing robust APIs and backend services. In this role, you''ll work with a diverse technology stack including React, Web Forms, .NET Core, WCF, SQL Server, JavaScript, and C# , developing scalable solution…','',56,'Matches React and JavaScript skills, but backend emphasizes .NET Core and C# legacy frameworks.','full-stack','','','new','2026-11-13T10:17:20Z','2026-11-13T13:18:46Z');
INSERT INTO "jobs" VALUES(45,'21f3b8631045c1e2758ab06b3b548ceace7461ca','Back End Developer','Network IT','North Johannesburg, Johannesburg','https://www.adzuna.co.za/details/5964322431?utm_medium=api&utm_source=947c6c7e','adzuna','Reference: ITE008274-Bia-1 Are you a Backend C# Developer with a passion for cloud technologies and AI-driven solutions? We are looking for a developer who can build scalable APIs, microservices, and intelligent backend applications while leveraging the power of Azure Cloud Services and Azure OpenAI . In this role, you''ll work with modern .NET technologies, cloud-native architectures, and cutting-edge AI solutions to develop features that enhance automation, analytics, and user experiences. You…','',62,'AI and backend experience align well, but role centers on C# and Azure rather than Python and AWS.','ai-ml','','','new','2026-11-13T10:17:20Z','2026-11-13T13:18:46Z');
INSERT INTO "jobs" VALUES(46,'ac2eac8d1a8b7267300eea05f052efd0abffb8bc','Senior Cloud Devops Engineer Johannesburg North','Communicate IT','North Johannesburg, Johannesburg','https://www.adzuna.co.za/details/5964200252?utm_medium=api&utm_source=947c6c7e','adzuna','Reference: CTI007299-LB-1 If you''re the type of engineer who gets excited about automation, scalable cloud architecture, eliminating manual processes, and building platforms that can support real-world impact at scale, this opportunity is worth exploring. My client is looking for a Senior Cloud DevOps Engineer to join a growing technology business where you''ll have significant influence over cloud infrastructure, deployment strategy, security, reliability, and performance. You''ll work on modern…','',88,'Seniority matches well; expert AWS, CI/CD, automation, and cloud architecture strongly align with the DevOps requirements.','general','','','new','2026-11-13T10:17:20Z','2026-11-13T13:18:46Z');
INSERT INTO "jobs" VALUES(47,'ee07b2587505598b3037de3502fd1a53f5999c9e','Backend Developer Johannesburg North','Network IT','North Johannesburg, Johannesburg','https://www.adzuna.co.za/details/5964200322?utm_medium=api&utm_source=947c6c7e','adzuna','Reference: ITE008274-Bia-1 Are you a Backend C# Developer with a passion for cloud technologies and AI-driven solutions? We are looking for a developer who can build scalable APIs, microservices, and intelligent backend applications while leveraging the power of Azure Cloud Services and Azure OpenAI . In this role, you''ll work with modern .NET technologies, cloud-native architectures, and cutting-edge AI solutions to develop features that enhance automation, analytics, and user experiences. You…','',62,'AI and backend experience align well, but role centers on C# and Azure rather than Python and AWS.','ai-ml','','','new','2026-11-13T10:17:20Z','2026-11-13T13:18:46Z');
INSERT INTO "jobs" VALUES(48,'ae1ddc408b9c0463d2332320e76d4a6b5b31127c','Full Stack .net Developer Johannesburg North','Network IT','North Johannesburg, Johannesburg','https://www.adzuna.co.za/details/5964200323?utm_medium=api&utm_source=947c6c7e','adzuna','Reference: ITE008279-Bia-1 Are you a skilled Full Stack .NET Developer looking to work with a diverse technology stack and contribute to business-critical applications? We are seeking a developer with strong experience in Web Forms, React, .NET Core APIs, and SQL Server to develop, enhance, and maintain modern web solutions. In this role, you''ll work across the full development lifecycle, building responsive front-end applications, developing scalable APIs, integrating backend systems, and supp…','',52,'React fits, but role heavily emphasizes .NET Core, Web Forms, and C# where candidate has limited experience.','full-stack','','','new','2026-11-13T10:17:20Z','2026-11-13T13:18:46Z');
INSERT INTO "jobs" VALUES(49,'8b09e20118a8a51e1a29d15666fcdff436108131','Full Stack Developer Johannesburg North','Network IT','North Johannesburg, Johannesburg','https://www.adzuna.co.za/details/5964200218?utm_medium=api&utm_source=947c6c7e','adzuna','Reference: ITE008277-Bia-1 Are you a skilled Full Stack Developer looking to work on modern web applications within a collaborative and growth-focused environment? We are seeking a developer who can contribute across the full development lifecycle, from building user-facing applications to developing robust APIs and backend services. In this role, you''ll work with a diverse technology stack including React, Web Forms, .NET Core, WCF, SQL Server, JavaScript, and C# , developing scalable solution…','',52,'React and JavaScript match, but the stack heavily requires legacy .NET, C#, and WCF.','full-stack','','','new','2026-11-13T10:17:20Z','2026-11-13T13:18:46Z');
INSERT INTO "jobs" VALUES(50,'ed152559092cf9bf48f0846f47aab5fb54432674','Engineering Lead Sandton','Arid Talent Solutions CC','Sandton, North Johannesburg','https://www.adzuna.co.za/details/5964200038?utm_medium=api&utm_source=947c6c7e','adzuna','Engineering Lead: Banking: Sandton: FTC The call is for an experienced Engineering Lead to join the client and to provide engineering leadership across Digitization and Automation by owning the technical implementation quality, engineering standards, infrastructure planning, development practices, and engineering governance of DnA solutions. The Engineering Lead works across RPA, Power Platform, Intelligent Solutions, AI, integrations, and custom development initiatives to ensure that approved …','',78,'Strong match for leadership, automation, and AI solutions, though some gap in RPA and Power Platform tools.','general','','','new','2026-11-13T10:17:20Z','2026-11-13T13:18:46Z');
INSERT INTO "jobs" VALUES(51,'3ad55fbb12b432d6628ab0ce4959f6e13a1d6693','C# Developer','','Johannesburg, Gauteng','https://www.adzuna.co.za/land/ad/5963994388?se=XvbtZ0vf8RGSOpNojY3DIg&utm_medium=api&utm_source=947c6c7e&v=0BF347C877E9C97728E497A61708AADB20DBB8FF','adzuna','We''re partner with innovative organisations that value engineering excellence, clean architecture, and technical curiosity. If you''re a C# Developer who enjoys solving complex problems, building scalable systems, and collaborating with equally talented engineers, we''d like to connect with you. The best developers aren''t looking for another job. They''re looking for a challenge. We''re looking for: Honours Degree or higher in Computer Science, Software Engineering, Mathematics, Engineering, or a r…','',42,'Role focuses specifically on C# backend development, where the candidate only has working knowledge.','full-stack','','no_company','new','2026-11-13T10:17:20Z','2026-11-13T13:18:46Z');
INSERT INTO "jobs" VALUES(52,'720e6692453a9e7a7f396da9289a8fad02b71d59','Intermediate Full Stack Developer – OutSystems & .NET','Goldman Tech Resourcing','Johannesburg, Gauteng','https://www.adzuna.co.za/land/ad/5963589145?se=XvbtZ0vf8RGSOpNojY3DIg&utm_medium=api&utm_source=947c6c7e&v=E846684AB2B362B0F32211BDDE6CC7130A46BAFD','adzuna','Our client is seeking an Intermediate Full Stack Developer to join their Technology and Product Development team. This is an excellent opportunity for a skilled developer with experience in OutSystems and Microsoft technologies to contribute to the development of enterprise applications, integrations and digital solutions. Key Responsibilities: Develop and maintain OutSystems Reactive applications and reusable components. Manage application deployments and releases using OutSystems LifeTime. Bu…','',35,'Requires OutSystems and .NET; candidate lacks OutSystems experience and has limited .NET background.','full-stack','','','new','2026-11-13T10:17:20Z','2026-11-13T13:18:46Z');
INSERT INTO "jobs" VALUES(53,'8decf94d964bede7a2d88d5941fc36024a4009cb','Electronic Engineer','Network Engineering','Johannesburg, Gauteng','https://www.adzuna.co.za/details/5963351671?utm_medium=api&utm_source=947c6c7e','adzuna','Reference: NES018058-ZAN-1 We are currently recruiting for a skilled Electronic Engineer / Software Developer to join the team. This fully remote position requires a disciplined and self-motivated individual with strong innovation and problem-solving qualities. Duties & Responsibilities Responsibilities: Responsibilities will be diverse; ranging from projects supporting the South African mining industry (including hardware design, software design, and production management), to software product…','',20,'Wrong field; position requires hardware design and electronic engineering rather than software or cloud expertise.','general','','','new','2026-11-13T10:17:20Z','2026-11-13T13:18:46Z');
INSERT INTO "jobs" VALUES(54,'a6d96cad69fe84185dfea81a182254960ec58c42','Senior Full Stack Software Developer - PHP, JavaScript, .net Core, Angular/React - Pretoria','Managed Outsourced Technology Solutions t/a MOTS Recruit','Midrand, North Johannesburg','https://www.adzuna.co.za/details/5962875005?utm_medium=api&utm_source=947c6c7e','adzuna','Introduction Ready to take ownership of software that makes a real difference? Are you an experienced Software Developer who enjoys solving complex technical challenges, improving existing systems and building reliable, high-quality software? We’re looking for a skilled Senior Software Developer to join a development team responsible for maintaining, enhancing and developing business-critical software solutions. This is an opportunity to work across web applications, backend services, databases…','',65,'Seniority and React match, but the role requires PHP and .NET Core where candidate has gaps.','full-stack','','','new','2026-11-13T10:17:20Z','2026-11-13T13:18:46Z');
INSERT INTO "jobs" VALUES(55,'b90c57672ed5a8d2b2a8471ebcf19950301312ff','C# Developer Johannesburg North','Network IT','North Johannesburg, Johannesburg','https://www.adzuna.co.za/details/5962714011?utm_medium=api&utm_source=947c6c7e','adzuna','Reference: ITA006249-Sam-2 Apply now and find your next opportunity! We''re partner with innovative organisations that value engineering excellence, clean architecture, and technical curiosity. If you''re a C# Developer who enjoys solving complex problems, building scalable systems, and collaborating with equally talented engineers, we''d like to connect with you. The best developers aren''t looking for another job. They''re looking for a challenge. We''re looking for: Honours Degree or higher in Com…','',42,'Role is centered on C# development, which is not the candidate''s primary programming language.','full-stack','','','new','2026-11-13T10:17:20Z','2026-11-13T13:18:46Z');
INSERT INTO "jobs" VALUES(56,'24f45afbc59fbaf1e9891d491d4071a0f0035d3e','Technical Lead Johannesburg','Miprint Consulting','Johannesburg, Gauteng','https://www.adzuna.co.za/details/5962713880?utm_medium=api&utm_source=947c6c7e','adzuna','Our client is looking for an Intermediate Technical Solutions Lead to bridge the gap between business requirements, technical teams and enterprise systems. The successful candidate will bring together different technical components, teams and stakeholders to ensure solutions are properly understood, designed and implemented. This is a coordination-focused technical leadership role requiring a solid C#/.NET development background, systems integration experience and practical solution design capa…','',58,'Technical leadership fits candidate''s seniority, but specifically requires a solid C#/.NET development background.','general','','','new','2026-11-13T10:17:20Z','2026-11-13T13:18:46Z');
INSERT INTO "jobs" VALUES(57,'d71f6a33b59a7e5c10c488173d14c377c98c92b2','Full Stack .net Developer Johannesburg','Data Monkey LTD','Johannesburg, Gauteng','https://www.adzuna.co.za/details/5962713853?utm_medium=api&utm_source=947c6c7e','adzuna','Our client is seeking experienced Full Stack .NET Developers to deliver and support .NET applications for a banking client in Sandton, Johannesburg. The role requires strong C# development expertise, hands-on experience with Azure application services and deployment technologies, Azure DevOps pipelines, and Angular or React. Successful candidates will work on-site daily and contribute across front-end and back-end development, cloud integration and containerised delivery. Develop, enhance and m…','',56,'Matches on React and CI/CD concepts, but requires Azure and C# instead of AWS and Python.','full-stack','','','new','2026-11-13T10:17:20Z','2026-11-13T13:18:46Z');
INSERT INTO "jobs" VALUES(58,'073d8d78279673c4c6af087015da0b761a5efc2c','Senior .NET Application Developer','Sabenza IT & Recruitment','Johannesburg, Gauteng','https://www.adzuna.co.za/details/5962560063?utm_medium=api&utm_source=947c6c7e','adzuna','Build software that people actually use. This is a senior seat for a developer who can take a requirement, design the application, and ship it. You will own the work from specification through coding, testing, debugging and release, inside an Agile team that expects clean, documented code. You will design, develop and deploy custom applications, and you will also build eLearning solutions that train and support the people who use them. Plans are coordinated with the development team and the bus…','',45,'Senior level fits, but primary tech stack is .NET/C# where candidate only has working knowledge.','full-stack','','','new','2026-11-13T10:17:20Z','2026-11-13T13:18:46Z');
INSERT INTO "jobs" VALUES(59,'75b0e85eca620d269b855b65a4ebd90c147877cf','Senior .NET Engineer (JHB Hybrid - Contract 12 month renewable)','','Johannesburg, Gauteng','https://www.adzuna.co.za/land/ad/5962471682?se=XvbtZ0vf8RGSOpNojY3DIg&utm_medium=api&utm_source=947c6c7e&v=1F7A0E1F9B80A09D16D07288CB3C7CDDE92613AC','adzuna','Operational Delivery Design, develop, test, deploy and support enterprise applications and systems using Microsoft .NET technologies. Develop and maintain scalable web applications, APIs and integration services using C#, ASP.NET Core, ASP.NET MVC, RESTful APIs, WCF and SOAP services. Develop and maintain data engineering and data analysis pipelines and solutions. Design and implement secure integration solutions between internal and external systems. Collaborate with Software Architects, Busin…','',48,'Data analysis matches, but the role relies heavily on C#, ASP.NET, and legacy WCF services.','full-stack','','no_company','new','2026-11-13T10:17:20Z','2026-11-13T13:18:46Z');
INSERT INTO "jobs" VALUES(60,'606146ad324d166639bfce010c4c96ec46787a59','Back End Developer','','Johannesburg, Gauteng','https://www.adzuna.co.za/land/ad/5962466732?se=XvbtZ0vf8RGSOpNojY3DIg&utm_medium=api&utm_source=947c6c7e&v=625B6B1439A600FB3D65F36CD7A3E32719EA38D8','adzuna','Job Experience and Skills Required Bachelor''s Degree or Diploma in Computer Science, Information Technology, Software Engineering, or a related field. 3-7 years of professional backend development experience. Proven experience developing enterprise applications using C# and .NET technologies. Hands-on experience with Azure cloud services and cloud-native application development. Experience building and supporting microservices and distributed systems. Proven experience integrating AI/LLM servic…','',58,'Requires C# and Azure where candidate has limited experience, though backend and AI/LLM integration match well.','full-stack','','no_company','new','2026-11-13T10:17:20Z','2026-11-13T13:18:46Z');
INSERT INTO "jobs" VALUES(61,'72f618767c623bc731d7d4a89a31bf8cd184adda','Full Stack Developer','','Johannesburg, Gauteng','https://www.adzuna.co.za/land/ad/5962466720?se=XvbtZ0vf8RGSOpNojY3DIg&utm_medium=api&utm_source=947c6c7e&v=D98199C627561C427EE58E62F292B8A87EC5928C','adzuna','Key Responsibilities Develop and maintain web applications using Web Forms (VB.NET) and React . Design, build, and maintain RESTful APIs using .NET Core . Develop and support WCF services for system integrations and communication between applications. Integrate applications with Microsoft SQL Server databases. Write clean, scalable, and maintainable code using C#, VB.NET, JavaScript, and CSS . Conduct code reviews and provide technical guidance to team members. Troubleshoot, debug, and optimize…','',50,'Strong React match, but legacy .NET stack (VB.NET, WCF) does not align well with core Python/cloud background.','full-stack','','no_company','new','2026-11-13T10:17:20Z','2026-11-13T13:18:46Z');
INSERT INTO "jobs" VALUES(62,'8e66def429b3c43a0ea1c3235a1c15355ad5eebf','Full Stack .NET Developer','','Johannesburg, Gauteng','https://www.adzuna.co.za/land/ad/5962466650?se=XvbtZ0vf8RGSOpNojY3DIg&utm_medium=api&utm_source=947c6c7e&v=15C023D1F537CDB4B22FDC5F8159023F7499E91F','adzuna','Key Responsibilities Develop and maintain web applications using Web Forms (VB.NET) and React . Design, build, and maintain RESTful APIs using .NET Core. Implement and support WCF services for communication between applications. Integrate applications with Microsoft SQL Server databases and optimize data access. Write clean, scalable, and maintainable code using C#, VB.NET, JavaScript, and CSS . Conduct code reviews and provide constructive feedback to fellow developers. Troubleshoot, debug, an…','',50,'React matches, but core requirements rely heavily on VB.NET, WCF, and .NET Core.','full-stack','','no_company','new','2026-11-13T10:17:20Z','2026-11-13T13:18:46Z');
INSERT INTO "jobs" VALUES(63,'bf751b8075f934568816c6c5dac5fba59f470e2b','C#/.NET Developer: API Ownership & DB Performance','Tumaini Consulting','Midrand, North Johannesburg','https://www.adzuna.co.za/details/5962331221?utm_medium=api&utm_source=947c6c7e','adzuna','Tumaini Consulting is seeking an experienced C#/.NET Developer to join the development team in a role focused on production applications and API ownership. The ideal candidate will have strong SQL and stored-procedure skills and a proven ability to optimize database queries within complex, database-driven environments. Requirements include 4 years in C#/.NET, proficiency with Oracle or PostgreSQL, and a solid background in testing and troubleshooting. J-18808-Ljbffr','',45,'Heavy focus on C#/.NET and database stored procedures, whereas candidate specializes in Python, AI, and AWS.','full-stack','','','new','2026-11-13T10:17:20Z','2026-11-13T13:18:46Z');
INSERT INTO "jobs" VALUES(64,'9ba868702bfe0d5abbc428a9b62ea1b2bb8aca16','Philanthropy Strategy Advisor for High-Impact Donors Hybrid','Placements24','Sandton, North Johannesburg','https://www.adzuna.co.za/details/5962314674?utm_medium=api&utm_source=947c6c7e','adzuna','Placements24 in Sandton, Gauteng, seeks a Senior Philanthropy Advisor to guide high-net-worth donors in developing and executing philanthropic strategies. The role blends remote work with in-office collaboration to maximize social impact through grantmaking, impact investing and strategic giving. You will conduct due diligence, craft tailored giving programs, and build trusted relationships with clients and advisors. J-18808-Ljbffr','',5,'Completely unrelated non-technical field in philanthropy and donor management.','general','','','new','2026-11-13T10:17:20Z','2026-11-13T13:18:46Z');
INSERT INTO "jobs" VALUES(65,'845bf9c0fe4f575e52a3c44f2394be7026f5a159','Mid-Level Developer','Tumaini Consulting','Midrand, North Johannesburg','https://www.adzuna.co.za/details/5962308049?utm_medium=api&utm_source=947c6c7e','adzuna','Our client is looking for an experienced C#/.NET Developer to join their development team. The ideal candidate will have strong production development experience, with particular emphasis on SQL, stored procedures, testing, and API ownership. Requirements 4 years’ experience in C#/.NET development Strong production experience with C# and .NET Strong SQL knowledge and stored-procedure development skills Ability to understand database structures and optimise query performance Experience with Orac…','',40,'Mid-level role focused on C#/.NET and stored procedures, not matching candidate''s senior profile and Python/AWS expertise.','full-stack','','','new','2026-11-13T10:17:20Z','2026-11-13T13:18:46Z');
INSERT INTO "jobs" VALUES(66,'bf55bd50c192326db8f202f5f9446e8ab1ce3186','Senior Philanthropy Advisor','Placements24','Sandton, North Johannesburg','https://www.adzuna.co.za/details/5962300394?utm_medium=api&utm_source=947c6c7e','adzuna','About the Role Our client, a prestigious philanthropic foundation, is seeking a highly experienced and visionary Senior Philanthropy Advisor to join their team in Sandton, Gauteng . This role is pivotal in guiding high-net-worth individuals and families in developing and implementing their philanthropic strategies. The Senior Philanthropy Advisor will provide expert advice on grantmaking, impact investing, and other forms of charitable giving to maximize social impact. This hybrid position allo…','',5,'Unrelated non-technical role focused on philanthropy and wealth advisory.','general','','','new','2026-11-13T10:17:20Z','2026-11-13T13:18:46Z');
INSERT INTO "jobs" VALUES(67,'09aded4fdb4f787d0e41c93e48e4ec9c73cc5b1a','AI Engineer','Nedbank','Johannesburg, Gauteng','https://www.adzuna.co.za/details/5962297420?utm_medium=api&utm_source=947c6c7e','adzuna','Job Family Information Technology Career Stream IT Technical/Specialists Job Purpose To identify opportunities within our Unit of Work and the respective systems where applicable Automation & Agentic AI can be used to optimize our systems, improve processes and create effeciencies using AI technology. To provide guidance and advice related to the integration of solutions across technologies; ensuing all outputs are following current governance and legislation and provide IT leadership based on …','',95,'Exceptional match for an AI specialist with deep LLM, automation, and solution integration experience in Johannesburg.','ai-ml','','','new','2026-11-13T10:17:20Z','2026-11-13T13:18:46Z');
INSERT INTO "jobs" VALUES(68,'35e80667c35de5866a49c9f0e0f5fda7d1cc5e1b','Senior Dotnet Developer','Zensar Technologies','Johannesburg, Gauteng','https://www.adzuna.co.za/details/5961739924?utm_medium=api&utm_source=947c6c7e','adzuna','.NET Developer Location: Johannesburg Workplace Type: Work from office 5 days a week Employment Type: Contract with possibility to renew Ready to take your .NET career into modern cloud-native development? We''re looking for an experienced .NET Developer who enjoys building scalable, secure and high-performing applications using C#, Microsoft Azure and modern engineering practices. This is a great opportunity for a hands‑on developer who wants to work across back-end development, front-end techn…','',48,'Role centers on .NET/C# and Azure; candidate''s core expertise is Python, AWS, and AI/ML.','full-stack','','','new','2026-11-13T10:17:20Z','2026-11-13T13:18:46Z');
INSERT INTO "jobs" VALUES(69,'2598e40d68eb50c7219323869ba8ab75a6efbc3b','Senior Cloud Engineer – AWS, IaC, CI/CD (Hybrid)','Indsafri India Private Limited','Roodepoort, West Johannesburg','https://www.adzuna.co.za/details/5961731512?utm_medium=api&utm_source=947c6c7e','adzuna','Indsafri India Private Limited in Roodepoort is seeking a senior cloud engineer to design and implement scalable cloud architectures on AWS. The role covers IaC with CloudFormation, CI/CD, containerization, and robust monitoring while enforcing security best practices. This hybrid position requires on-site presence 3 days a week (Tue, Wed, Thu) at the Constantia Kloof location. Ideal candidates have 5–7 years of experience, strong scripting (Python, Bash, PowerShell) and C# .NET development, J-…','',93,'Excellent match with core expertise in AWS, CI/CD, containerization, monitoring, and Python scripting.','general','','','new','2026-11-13T10:17:20Z','2026-11-13T13:18:46Z');
INSERT INTO "jobs" VALUES(70,'cff331bb57ac682096462429e7aeed0e2c37c26b','Senior .NET Developer: Cloud-Native Azure & Full-Stack','Zensar Technologies','Johannesburg, Gauteng','https://www.adzuna.co.za/details/5961731397?utm_medium=api&utm_source=947c6c7e','adzuna','Zensar Technologies in Johannesburg is seeking an experienced .NET Developer to build scalable, secure applications using C#, Azure and modern engineering practices. You will contribute across backend, frontend, cloud services, containers and DevOps, delivering measurable technical impact. The role emphasizes hands-on development, Azure-based delivery, and full lifecycle involvement from design through deployment, with a strong focus on security and performance. J-18808-Ljbffr','',52,'Partial match for senior full-stack and DevOps, but requires core C# and Azure rather than Python and AWS.','full-stack','','','new','2026-11-13T10:17:20Z','2026-11-13T13:18:46Z');
INSERT INTO "jobs" VALUES(71,'62583e051342d235a852446fa810796513663816','Senior Developer','Network IT','North Johannesburg, Johannesburg','https://www.adzuna.co.za/details/5961451223?utm_medium=api&utm_source=947c6c7e','adzuna','Reference: ITA006511-Mel-1 Senior Software Architect / Lead Developer | .NET, Azure & Cloud Technologies A leading financial services organisation is looking for a Senior Software Architect / Lead Developer to drive the technical direction of key business platforms, CRM solutions, and digital services. This is an opportunity for a hands-on technical leader to shape architecture, modernise systems, and work closely with business stakeholders to deliver high-impact solutions. Duties & Responsibil…','',55,'Strong alignment with technical lead and architecture responsibilities, but stack centers on .NET and Azure rather than AWS.','general','','','new','2026-11-13T10:17:20Z','2026-11-13T13:18:46Z');
INSERT INTO "jobs" VALUES(72,'d53062e51d0cfc50033310774dc4d194fca1e0bb','Junior Software Developer Johannesburg East','Network IT','East Johannesburg, Johannesburg','https://www.adzuna.co.za/details/5961251533?utm_medium=api&utm_source=947c6c7e','adzuna','Reference: ITA006580-Rein-1 Our client is looking for a Junior Software Developer with a passion for software development and a solid foundation in the Microsoft technology stack. This is a permanent, full-time position based in Wadeville, Germiston, offering an excellent opportunity for a developer at the start of their career to gain exposure across the full software development lifecycle while working alongside experienced developers. The successful candidate will assist in developing, maint…','',NULL,'','','','','filtered','2026-11-13T10:17:20Z','2026-11-13T13:18:46Z');
INSERT INTO "jobs" VALUES(73,'91eadc140ef95490c003e617cc61ec966ea97156','Senior Software Developer','','Johannesburg, Gauteng','https://www.adzuna.co.za/land/ad/5960981761?se=XvbtZ0vf8RGSOpNojY3DIg&utm_medium=api&utm_source=947c6c7e&v=5A6DC9809600F2C369E8BA0587968FA3AD630C55','adzuna','Job description: A unique opportunity to join a JSE listed financial organisation that continually delivers excellent results and growth that exceed all competitors in the market. Become part of a team working on Key projects in the company in Partnership with business stakeholders to deliver great value with an opportunity to make a real impact in the success story. Design and develop company transactional websites, line-of-business systems and processes that are at the forefront of the digita…','',75,'Good match on seniority and web development scope; lacks detailed technical requirements.','full-stack','','no_company','new','2026-11-13T10:17:20Z','2026-11-13T13:18:46Z');
INSERT INTO "jobs" VALUES(74,'32e1b3f3c7333505686a6ef3bb0716252cca2b03','Senior Full Stack Developer (iOCO0197)','iOCO Digital','Johannesburg, Gauteng','https://www.adzuna.co.za/land/ad/5960639558?se=XvbtZ0vf8RGSOpNojY3DIg&utm_medium=api&utm_source=947c6c7e&v=DBC461F4F8CD80C512332E69ADDBEA736C435AD7','adzuna','The purpose of the Senior Full Stack Developer role is to design, build and maintain high-quality, secure and scalable web applications across the full stack from the database and back-end services through to the user interface for Symplexitys products and client solutions. The role drives technical excellence within the team through quality code, sound design and mentoring of other developers, in accordance with the prescribed architecture and standards, and delivers within the agreed timefram…','',82,'Solid fit for full stack web development and mentoring, matching candidate''s 8 years of software engineering experience.','full-stack','','','new','2026-11-13T10:17:20Z','2026-11-13T13:18:46Z');
INSERT INTO "jobs" VALUES(75,'239457090d5691c34d78af20732e47f43283cec6','Senior .NET Backend Engineer (Remote)','Placements24','Randburg, West Johannesburg','https://www.adzuna.co.za/details/5960423311?utm_medium=api&utm_source=947c6c7e','adzuna','Placements24, a Randburg-based financial technology firm, seeks an experienced Senior Software Engineer with a strong background in C# and the .NET framework to design, develop, and maintain robust backend systems that power critical banking operations. This remote-friendly role offers high autonomy and opportunities to influence architecture. You will work across teams with product managers, frontend developers, and QA to deliver scalable, secure solutions while embracing modern CI/CD practice…','',52,'Senior backend role matches seniority and CI/CD skills, but requires deep C#/.NET rather than Python.','full-stack','','','new','2026-11-13T10:17:20Z','2026-11-13T13:18:46Z');
INSERT INTO "jobs" VALUES(76,'6171bc11ce358e00fe3a9686c3c9a4996ebb976b','Senior Full Stack Developer (iOCO0197)','iOCO','Halfway House, North Johannesburg','https://www.adzuna.co.za/details/5960197878?utm_medium=api&utm_source=947c6c7e','adzuna','Description The purpose of the Senior Full Stack Developer role is to design, build and maintain high-quality, secure and scalable web applications across the full stack – from the database and back-end services through to the user interface – for Symplexity’s products and client solutions. The role drives technical excellence within the team through quality code, sound design and mentoring of other developers, in accordance with the prescribed architecture and standards, and delivers within th…','',88,'Senior full-stack role aligns well with 8 years of experience, modern web dev stack, and mentoring capability.','full-stack','','','new','2026-11-13T10:17:20Z','2026-11-13T13:18:46Z');
INSERT INTO "jobs" VALUES(77,'655fa031b1a0d1229c894a8e219e0f131422bd65','Senior .NET Engineer','FrostByte','Johannesburg, Gauteng','https://www.adzuna.co.za/details/5960197615?utm_medium=api&utm_source=947c6c7e','adzuna','About the role Develop, maintain and support specialized enterprise software applications, APIs, integration services and data pipelines using Microsoft .NET and Azure technologies. Design, develop, test, deploy and support enterprise applications and systems using Microsoft .NET technologies. Develop and maintain scalable web applications, APIs and integration services using C#, ASP.NET Core, ASP.NET MVC, RESTful APIs, WCF and SOAP services. Develop and maintain data engineering and data analy…','',45,'Core requirements focus heavily on Microsoft .NET, C#, and Azure, where candidate only has basic working experience.','full-stack','','','new','2026-11-13T10:17:20Z','2026-11-13T13:18:46Z');
INSERT INTO "jobs" VALUES(78,'e90ff274a749ab02dead0c52cb1cb5a2d51966ac','Senior Developer Johannesburg North','Network IT','North Johannesburg, Johannesburg','https://www.adzuna.co.za/details/5960017351?utm_medium=api&utm_source=947c6c7e','adzuna','Reference: ITA006511-Mel-1 Senior Software Architect / Lead Developer | .NET, Azure & Cloud Technologies A leading financial services organisation is looking for a Senior Software Architect / Lead Developer to drive the technical direction of key business platforms, CRM solutions, and digital services. This is an opportunity for a hands-on technical leader to shape architecture, modernise systems, and work closely with business stakeholders to deliver high-impact solutions. This opportunity is …','',52,'Good seniority match for a lead architect, but core requirements center on .NET and Azure rather than AWS/Python.','general','','','new','2026-11-13T10:17:20Z','2026-11-13T13:18:46Z');
INSERT INTO "jobs" VALUES(79,'00d527a181f0320b82c4c471e502b1cd608af46e','Senior Full Stack Developer Johannesburg','iOCO','Johannesburg, Gauteng','https://www.adzuna.co.za/details/5960015860?utm_medium=api&utm_source=947c6c7e','adzuna','The purpose of the Senior Full Stack Developer role is to design, build and maintain high-quality, secure and scalable web applications across the full stack – from the database and back-end services through to the user interface – for Symplexity''s products and client solutions. The role drives technical excellence within the team through quality code, sound design and mentoring of other developers, in accordance with the prescribed architecture and standards, and delivers within the agreed tim…','',88,'Matches seniority, location, and candidate''s full-stack development experience across backend and frontend systems.','full-stack','','','new','2026-11-13T10:17:20Z','2026-11-13T13:18:46Z');
INSERT INTO "jobs" VALUES(80,'6fdfa176a59e3eda6bb32b62c9382874d076d7d3','Ai Engineering Lead Sandton','Arid Talent Solutions CC','Sandton, North Johannesburg','https://www.adzuna.co.za/details/5960015788?utm_medium=api&utm_source=947c6c7e','adzuna','Engineering Lead: Banking: Sandton: 12 months FTC End-to-end capability required to take solutions from concept through architecture, engineering, governance, implementation, and production support. In practical terms, the Engineering Lead should be equally comfortable reviewing a Blue Prism design, conducting a Power Apps code review, designing a deployment architecture, building a .NET or Java integration service, creating infrastructure diagrams, or guiding teams through complex engineering …','',72,'Strong title, AI, and leadership alignment, though banking role mentions specific RPA tools like Blue Prism.','ai-ml','','','new','2026-11-13T10:17:20Z','2026-11-13T13:18:46Z');
INSERT INTO "jobs" VALUES(81,'a3ec84c13e99becaaed2dbf129a27942e9826bb6','Senior Full-Stack C# ASP.NET Developer','Hire Resolve','Johannesburg, Gauteng','https://www.adzuna.co.za/details/5959789517?utm_medium=api&utm_source=947c6c7e','adzuna','A transformation consultancy that digitizes business operations by combining expert consulting with their proprietary real-time data platform is seeking a Senior Full-Stack C# ASP.NET Developer who will be a key driver in their mission to progressively digitize business operations for global clients. You will work across the full stack to build rapid, affordable, and tactical automation solutions, often bridging the gap between legacy systems and modern cloud environments. Responsibilities: Arc…','',48,'Candidate has full-stack seniority and cloud skills, but primary requirement is C# and ASP.NET.','full-stack','','','new','2026-11-13T10:17:20Z','2026-11-13T13:18:46Z');
INSERT INTO "jobs" VALUES(82,'1cd9f01aed38f9d7c0b5304159a715e0580f8c99','Software Developer','Hire Resolve','Johannesburg, Gauteng','https://www.adzuna.co.za/details/5959788933?utm_medium=api&utm_source=947c6c7e','adzuna','A South African company that develops and sells large-scale, sectional title residential estates, focusing on affordable, quality apartments, is seeking a highly motivated and experienced Software Developer who will be responsible for the entire application lifecycle—from design and development to testing and maintenance. Responsibilities: Design, code, test, and maintain software applications according to project requirements and industry standards. Work with stakeholders (business analysts, p…','',75,'Broad match for software development lifecycle and stakeholder interaction, though specific tech stack is omitted.','full-stack','','','new','2026-11-13T10:17:20Z','2026-11-13T13:18:46Z');
INSERT INTO "jobs" VALUES(83,'5b879d07b931fb9d2b28d677def7d9e4448b8f69','Senior Full Stack Developer (iOCO0197)','iOCO','Johannesburg, Gauteng','https://www.adzuna.co.za/details/5959788480?utm_medium=api&utm_source=947c6c7e','adzuna','The purpose of the Senior Full Stack Developer role is to design, build and maintain high-quality, secure and scalable web applications across the full stack – from the database and back-end services through to the user interface – for Symplexity’s products and client solutions. The role drives technical excellence within the team through quality code, sound design and mentoring of other developers, in accordance with the prescribed architecture and standards, and delivers within the agreed tim…','',88,'Excellent match for full-stack architecture, backend and frontend development, and mentoring junior engineers.','full-stack','','','new','2026-11-13T10:17:20Z','2026-11-13T13:18:46Z');
INSERT INTO "jobs" VALUES(84,'87c98ea3546662601d4af3f3780022704a7e71c7','Python Developer','IT Ridge Technologies','City of Johannesburg (Hybrid)','https://www.linkedin.com/jobs/view/4488282661','linkedin','','',88,'Excellent match for Python expertise and location in Johannesburg.','full-stack','','','new','2026-11-13T11:57:08Z','2026-11-13T11:57:08Z');
INSERT INTO "jobs" VALUES(85,'fa53d986950eee5c75fca7f8786243424b5e12c0','Python Engineer (Backend Platform Engineer)','Skywaves Rise','Johannesburg Metropolitan Area (Hybrid)','https://www.linkedin.com/jobs/view/4490305604','linkedin','','',90,'Great match for senior Python, backend development, and platform engineering skills in Johannesburg.','full-stack','','','new','2026-11-13T11:57:09Z','2026-11-13T11:57:09Z');
INSERT INTO "jobs" VALUES(86,'501568cb1370bcf5d992465519301032c164dcae','Full Stack Software Engineer','PwC South Africa','Midrand (Hybrid)','https://www.linkedin.com/jobs/view/4488293256','linkedin','','',NULL,'','','','','filtered','2026-11-13T11:57:09Z','2026-11-13T11:57:09Z');
INSERT INTO "jobs" VALUES(87,'b4797c6686f07f9932b7823d7deb86b437f7d321','Generative AI Engineer','Beautiful Destinations','South Africa (Remote)','https://www.linkedin.com/jobs/view/4488524053','linkedin','','',95,'Perfect match for Generative AI and LLM expertise, based remotely in South Africa.','ai-ml','','','new','2026-11-13T11:57:09Z','2026-11-13T11:57:09Z');
CREATE TABLE llm_calls (
  id            INTEGER PRIMARY KEY,
  at            TEXT NOT NULL,
  task          TEXT NOT NULL,
  model         TEXT NOT NULL,
  input_tokens  INTEGER NOT NULL DEFAULT 0,
  output_tokens INTEGER NOT NULL DEFAULT 0,
  ms            INTEGER NOT NULL DEFAULT 0,
  ok            INTEGER NOT NULL
);
INSERT INTO "llm_calls" VALUES(1,'2026-11-12T21:27:10Z','import','gemini/gemini-4-carbon',1825,2041,18565,1);
INSERT INTO "llm_calls" VALUES(2,'2026-11-12T21:48:26Z','analyse','gemini/gemini-3.8-flash',870,1385,14622,1);
INSERT INTO "llm_calls" VALUES(3,'2026-11-12T21:50:06Z','tailor','gemini/gemini-4-carbon',4330,6083,60708,1);
INSERT INTO "llm_calls" VALUES(4,'2026-11-12T21:50:49Z','letter','gemini/gemini-4-carbon',1754,4362,43464,1);
INSERT INTO "llm_calls" VALUES(5,'2026-11-13T04:34:25Z','analyse','gemini/gemini-3.8-flash',1016,1141,14280,1);
INSERT INTO "llm_calls" VALUES(6,'2026-11-13T04:36:00Z','tailor','gemini/gemini-4-carbon',4469,7530,64736,1);
INSERT INTO "llm_calls" VALUES(7,'2026-11-13T04:36:49Z','letter','gemini/gemini-4-carbon',1893,5245,49413,1);
INSERT INTO "llm_calls" VALUES(8,'2026-11-13T04:38:22Z','analyse','gemini/gemini-3.8-flash',962,1470,13201,1);
INSERT INTO "llm_calls" VALUES(9,'2026-11-13T04:39:49Z','tailor','gemini/gemini-4-carbon',4438,6552,43826,1);
INSERT INTO "llm_calls" VALUES(10,'2026-11-13T04:40:30Z','tailor','gemini/gemini-4-carbon',4466,4120,40350,1);
INSERT INTO "llm_calls" VALUES(11,'2026-11-13T04:41:16Z','letter','gemini/gemini-4-carbon',1698,5076,45788,1);
INSERT INTO "llm_calls" VALUES(12,'2026-11-13T08:54:36Z','analyse','gemini/gemini-3.8-flash',628,1388,16797,1);
INSERT INTO "llm_calls" VALUES(13,'2026-11-13T08:55:36Z','tailor','gemini/gemini-4-carbon',4096,3598,41508,1);
INSERT INTO "llm_calls" VALUES(14,'2026-11-13T08:56:44Z','tailor','gemini/gemini-4-carbon',4132,5917,67471,1);
INSERT INTO "llm_calls" VALUES(15,'2026-11-13T08:57:01Z','letter','gemini/gemini-4-carbon',1417,871,17404,1);
INSERT INTO "llm_calls" VALUES(16,'2026-11-13T09:02:11Z','analyse','gemini/gemini-3.8-flash',574,5987,51297,1);
INSERT INTO "llm_calls" VALUES(17,'2026-11-13T09:58:07Z','classify','gemini/gemini-3.8-flash',1175,631,10253,1);
INSERT INTO "llm_calls" VALUES(18,'2026-11-13T09:58:15Z','classify','gemini/gemini-3.8-flash',1299,448,7463,1);
INSERT INTO "llm_calls" VALUES(19,'2026-11-13T09:58:22Z','classify','gemini/gemini-3.8-flash',1303,375,6808,1);
INSERT INTO "llm_calls" VALUES(20,'2026-11-13T09:59:03Z','extract','gemini/gemini-3.8-flash',1117,5082,40788,1);
INSERT INTO "llm_calls" VALUES(21,'2026-11-13T09:59:56Z','extract','gemini/gemini-3.8-flash',939,5800,53148,1);
INSERT INTO "llm_calls" VALUES(22,'2026-11-13T10:00:03Z','classify','gemini/gemini-3.8-flash',1958,323,6920,1);
INSERT INTO "llm_calls" VALUES(23,'2026-11-13T10:00:46Z','extract','gemini/gemini-3.8-flash',1110,5088,43061,1);
INSERT INTO "llm_calls" VALUES(24,'2026-11-13T10:00:55Z','classify','gemini/gemini-3.8-flash',1933,622,9211,1);
INSERT INTO "llm_calls" VALUES(25,'2026-11-13T10:01:04Z','classify','gemini/gemini-3.8-flash',2234,569,8473,1);
INSERT INTO "llm_calls" VALUES(26,'2026-11-13T10:01:17Z','classify','gemini/gemini-3.8-flash',2020,558,13033,1);
INSERT INTO "llm_calls" VALUES(27,'2026-11-13T10:01:24Z','classify','gemini/gemini-3.8-flash',1836,349,6607,1);
INSERT INTO "llm_calls" VALUES(28,'2026-11-13T10:01:33Z','classify','gemini/gemini-3.8-flash',1308,578,9076,1);
INSERT INTO "llm_calls" VALUES(29,'2026-11-13T10:01:41Z','classify','gemini/gemini-3.8-flash',1918,585,7690,1);
INSERT INTO "llm_calls" VALUES(30,'2026-11-13T10:01:47Z','classify','gemini/gemini-3.8-flash',852,417,6476,1);
INSERT INTO "llm_calls" VALUES(31,'2026-11-13T10:02:05Z','classify','gemini/gemini-3.8-flash',2039,795,17402,1);
INSERT INTO "llm_calls" VALUES(32,'2026-11-13T10:02:14Z','classify','gemini/gemini-3.8-flash',1632,702,8726,1);
INSERT INTO "llm_calls" VALUES(33,'2026-11-13T10:02:21Z','classify','gemini/gemini-3.8-flash',1448,477,7608,1);
INSERT INTO "llm_calls" VALUES(34,'2026-11-13T10:02:30Z','classify','gemini/gemini-3.8-flash',986,578,8329,1);
INSERT INTO "llm_calls" VALUES(35,'2026-11-13T10:02:38Z','classify','gemini/gemini-3.8-flash',1015,445,7897,1);
INSERT INTO "llm_calls" VALUES(36,'2026-11-13T10:02:53Z','extract','gemini/gemini-3.8-flash',972,1326,15571,1);
INSERT INTO "llm_calls" VALUES(37,'2026-11-13T10:03:00Z','classify','gemini/gemini-3.8-flash',847,419,6297,1);
INSERT INTO "llm_calls" VALUES(38,'2026-11-13T10:05:05Z','extract','gemini/gemini-3.8-flash',1107,16152,124803,1);
INSERT INTO "llm_calls" VALUES(39,'2026-11-13T10:05:12Z','classify','gemini/gemini-3.8-flash',1100,438,6878,1);
INSERT INTO "llm_calls" VALUES(40,'2026-11-13T10:05:24Z','classify','gemini/gemini-3.8-flash',1984,531,11685,1);
INSERT INTO "llm_calls" VALUES(41,'2026-11-13T10:06:26Z','extract','gemini/gemini-3.8-flash',1082,7277,62384,1);
INSERT INTO "llm_calls" VALUES(42,'2026-11-13T10:06:33Z','classify','gemini/gemini-3.8-flash',1386,205,6261,1);
INSERT INTO "llm_calls" VALUES(43,'2026-11-13T10:06:50Z','classify','gemini/gemini-3.8-flash',2276,863,17048,1);
INSERT INTO "llm_calls" VALUES(44,'2026-11-13T10:06:57Z','classify','gemini/gemini-3.8-flash',1951,491,7012,1);
INSERT INTO "llm_calls" VALUES(45,'2026-11-13T10:07:55Z','extract','gemini/gemini-3.8-flash',974,6484,58370,1);
INSERT INTO "llm_calls" VALUES(46,'2026-11-13T10:08:03Z','classify','gemini/gemini-3.8-flash',1923,510,7536,1);
INSERT INTO "llm_calls" VALUES(47,'2026-11-13T10:08:10Z','classify','gemini/gemini-3.8-flash',1777,457,7101,1);
INSERT INTO "llm_calls" VALUES(48,'2026-11-13T10:08:18Z','classify','gemini/gemini-3.8-flash',760,560,8319,1);
INSERT INTO "llm_calls" VALUES(49,'2026-11-13T10:08:27Z','classify','gemini/gemini-3.8-flash',1752,491,8397,1);
INSERT INTO "llm_calls" VALUES(50,'2026-11-13T10:08:34Z','classify','gemini/gemini-3.8-flash',2270,447,6927,1);
INSERT INTO "llm_calls" VALUES(51,'2026-11-13T10:08:42Z','classify','gemini/gemini-3.8-flash',533,602,8421,1);
INSERT INTO "llm_calls" VALUES(52,'2026-11-13T10:08:52Z','classify','gemini/gemini-3.8-flash',621,676,9757,1);
INSERT INTO "llm_calls" VALUES(53,'2026-11-13T10:08:58Z','classify','gemini/gemini-3.8-flash',437,331,6032,1);
INSERT INTO "llm_calls" VALUES(54,'2026-11-13T10:09:08Z','classify','gemini/gemini-3.8-flash',1514,739,9112,1);
INSERT INTO "llm_calls" VALUES(55,'2026-11-13T10:10:18Z','extract','gemini/gemini-3.8-flash',1034,8858,70461,1);
INSERT INTO "llm_calls" VALUES(56,'2026-11-13T10:10:26Z','classify','gemini/gemini-3.8-flash',969,591,7541,1);
INSERT INTO "llm_calls" VALUES(57,'2026-11-13T10:10:32Z','classify','gemini/gemini-3.8-flash',1732,413,6414,1);
INSERT INTO "llm_calls" VALUES(58,'2026-11-13T10:10:39Z','classify','gemini/gemini-3.8-flash',948,378,6369,1);
INSERT INTO "llm_calls" VALUES(59,'2026-11-13T10:11:29Z','extract','gemini/gemini-3.8-flash',1092,5953,49711,1);
INSERT INTO "llm_calls" VALUES(60,'2026-11-13T10:11:39Z','classify','gemini/gemini-3.8-flash',1310,759,9618,1);
INSERT INTO "llm_calls" VALUES(61,'2026-11-13T10:11:48Z','classify','gemini/gemini-3.8-flash',2318,710,9730,1);
INSERT INTO "llm_calls" VALUES(62,'2026-11-13T10:13:14Z','extract','gemini/gemini-3.8-flash',1121,10500,84967,1);
INSERT INTO "llm_calls" VALUES(63,'2026-11-13T10:13:30Z','classify','gemini/gemini-3.8-flash',1926,772,15919,1);
INSERT INTO "llm_calls" VALUES(64,'2026-11-13T10:14:14Z','extract','gemini/gemini-3.8-flash',1054,5003,44355,1);
INSERT INTO "llm_calls" VALUES(65,'2026-11-13T10:14:21Z','classify','gemini/gemini-3.8-flash',1850,469,6756,1);
INSERT INTO "llm_calls" VALUES(66,'2026-11-13T10:14:31Z','classify','gemini/gemini-3.8-flash',1938,522,9535,1);
INSERT INTO "llm_calls" VALUES(67,'2026-11-13T10:14:45Z','classify','gemini/gemini-3.8-flash',1938,738,14102,1);
INSERT INTO "llm_calls" VALUES(68,'2026-11-13T10:14:53Z','classify','gemini/gemini-3.8-flash',2277,440,7751,1);
INSERT INTO "llm_calls" VALUES(69,'2026-11-13T10:15:01Z','classify','gemini/gemini-3.8-flash',1543,485,8416,1);
INSERT INTO "llm_calls" VALUES(70,'2026-11-13T10:16:02Z','extract','gemini/gemini-3.8-flash',952,7100,60342,1);
INSERT INTO "llm_calls" VALUES(71,'2026-11-13T10:16:12Z','classify','gemini/gemini-3.8-flash',1187,372,9664,1);
INSERT INTO "llm_calls" VALUES(72,'2026-11-13T10:17:17Z','extract','gemini/gemini-3.8-flash',1094,8019,64122,1);
INSERT INTO "llm_calls" VALUES(73,'2026-11-13T10:17:42Z','score','gemini/gemini-3.8-flash',1115,2503,21914,1);
INSERT INTO "llm_calls" VALUES(74,'2026-11-13T10:18:16Z','score','gemini/gemini-3.8-flash',1314,4046,33872,1);
INSERT INTO "llm_calls" VALUES(75,'2026-11-13T10:18:51Z','score','gemini/gemini-3.8-flash',2506,4391,34198,1);
INSERT INTO "llm_calls" VALUES(76,'2026-11-13T10:19:28Z','score','gemini/gemini-3.8-flash',2470,4456,37557,1);
INSERT INTO "llm_calls" VALUES(77,'2026-11-13T10:19:54Z','score','gemini/gemini-3.8-flash',1530,2813,25414,1);
INSERT INTO "llm_calls" VALUES(78,'2026-11-13T10:37:42Z','classify','gemini/gemini-3.8-flash',388,733,10365,1);
INSERT INTO "llm_calls" VALUES(79,'2026-11-13T10:37:49Z','classify','gemini/gemini-3.8-flash',1159,367,6615,1);
INSERT INTO "llm_calls" VALUES(80,'2026-11-13T10:38:05Z','classify','gemini/gemini-3.8-flash',1935,645,16317,1);
INSERT INTO "llm_calls" VALUES(81,'2026-11-13T10:57:52Z','classify','gemini/gemini-3.8-flash',395,556,9674,1);
INSERT INTO "llm_calls" VALUES(82,'2026-11-13T11:44:09Z','classify','gemini/gemini-3.8-flash',390,653,10139,1);
INSERT INTO "llm_calls" VALUES(83,'2026-11-13T11:57:08Z','extract','gemini/gemini-3.8-flash',1102,14224,103871,1);
INSERT INTO "llm_calls" VALUES(84,'2026-11-13T11:57:19Z','classify','gemini/gemini-3.8-flash',396,820,10222,1);
INSERT INTO "llm_calls" VALUES(85,'2026-11-13T12:04:41Z','classify','gemini/gemini-3.8-flash',391,575,9261,1);
INSERT INTO "llm_calls" VALUES(86,'2026-11-13T12:07:39Z','classify','gemini/gemini-3.8-flash',389,649,9436,1);
INSERT INTO "llm_calls" VALUES(87,'2026-11-13T12:21:51Z','classify','gemini/gemini-3.8-flash',391,685,10340,1);
INSERT INTO "llm_calls" VALUES(88,'2026-11-13T12:21:57Z','classify','gemini/gemini-3.8-flash',1924,420,6369,1);
INSERT INTO "llm_calls" VALUES(89,'2026-11-13T12:45:56Z','classify','gemini/gemini-3.8-flash',417,630,11241,1);
INSERT INTO "llm_calls" VALUES(90,'2026-11-13T12:56:31Z','classify','gemini/gemini-3.8-flash',410,1144,14600,1);
INSERT INTO "llm_calls" VALUES(91,'2026-11-13T12:59:34Z','score','gemini/gemini-3.8-flash',614,1107,11693,1);
CREATE TABLE messages (
  id             INTEGER PRIMARY KEY,
  msgid          TEXT NOT NULL UNIQUE,     -- Message-ID header. 'local-<uuid>' for drafts and logged rows
  application_id INTEGER REFERENCES applications(id),
  direction      TEXT NOT NULL,            -- in | out
  kind           TEXT NOT NULL,            -- alert | reply | ignored | application | followup | sent
  state          TEXT NOT NULL DEFAULT 'done',  -- done | draft | review
  sender         TEXT NOT NULL DEFAULT '',
  recipient      TEXT NOT NULL DEFAULT '',
  subject        TEXT NOT NULL DEFAULT '',
  body           TEXT NOT NULL DEFAULT '', -- empty for alert and ignored
  refs           TEXT NOT NULL DEFAULT '', -- space-separated Message-IDs from In-Reply-To and References
  at             TEXT NOT NULL,
  category       TEXT NOT NULL DEFAULT '', -- acknowledgement|info_request|assessment|interview|rejection|offer|other
  confidence     REAL,
  summary        TEXT NOT NULL DEFAULT '',
  action_needed  TEXT NOT NULL DEFAULT '',
  handled        INTEGER NOT NULL DEFAULT 0
);
INSERT INTO "messages" VALUES(1,'<179456041084.1.9871907150477346465@gmail.com>',4,'out','application','done','chirombokenny@gmail.com','kenny@dreamverse.co.za','Application: Backend Engineer (V2 TEST)','Dear Hiring Manager,

I am applying for the engineering position advertised by your company. My background in developing services, integrating cloud APIs, running performance benchmarks, and building software in Python aligns well with the core responsibilities of this role.

In my previous API work, I was responsible for integrating a serverless API using AWS API Gateway and AWS Services. Alongside API integration, I have built web and mobile applications for clients where I performed performance benchmarks, ensured high availability and security, and used modern technologies to construct automation pipelines for building and deploying web applications.

My background also includes migrating services and working with Python. Specifically, I participated in migrating machine-generated article descriptions from Toolforge to Liftwing, which ensured the smooth and efficient operation of article-description inference services. Additionally, matching your interest in Python skills, I designed a Python-based GUI Decision Support System for Risk-Based Water Quality Guidelines that improved user accessibility and interaction.

I am drawn to your company because the opportunity to build and run payment APIs while improving API performance and migrating services to the cloud directly connects to the engineering challenges I enjoy solving. I would welcome a conversation to discuss how my API and cloud migration experience can support your engineering goals.

Kind regards,
Kenny Chirombo
+27 81 264 4132','','2026-11-13T09:00:19Z','',NULL,'','',0);
INSERT INTO "messages" VALUES(2,'local-e02f39b0-0432-4cdd-88bf-775d3e903d23',4,'in','reply','done','','','','','','2026-11-13T09:03:28Z','interview',1.0,'','',1);
INSERT INTO "messages" VALUES(3,'<3e719877-1e3d-4c82-a5ca-04d0da9d3628@fra3s50mta0782.xt.local>',NULL,'in','ignored','done','clubcard@email.clicks.co.za','','','','','2026-11-09T15:35:40Z','',NULL,'','',0);
INSERT INTO "messages" VALUES(4,'<20261110001751.af16731ad93abd52@crm.juliangoldie.com>',NULL,'in','ignored','done','me@juliangoldie.com','','','','','2026-11-10T00:17:51Z','',NULL,'','',0);
INSERT INTO "messages" VALUES(5,'<ChiromboKenT/vken-design-engine/check-suites/CS_kwDOSXOco88AAAAa8e14Tw/1794271843@github.com>',NULL,'in','ignored','done','notifications@github.com','','','','','2026-11-10T00:51:05Z','',NULL,'','',0);
INSERT INTO "messages" VALUES(6,'<20261110010459.c2d8967b0f1a66cc@crm.juliangoldie.com>',NULL,'in','ignored','done','me@juliangoldie.com','','','','','2026-11-10T01:04:59Z','',NULL,'','',0);
INSERT INTO "messages" VALUES(7,'<ChiromboKenT/vken-design-engine/check-suites/CS_kwDOSXOco88AAAAa8ppS4Q/1794273003@github.com>',NULL,'in','ignored','done','notifications@github.com','','','','','2026-11-10T01:10:24Z','',NULL,'','',0);
INSERT INTO "messages" VALUES(8,'<codecrafters-io/build-your-own-x/issues/2092/6757278146@github.com>',NULL,'in','ignored','done','notifications@github.com','','','','','2026-11-10T02:40:58Z','',NULL,'','',0);
INSERT INTO "messages" VALUES(9,'<codecrafters-io/build-your-own-x/issues/2092/6757264375@github.com>',NULL,'in','ignored','done','notifications@github.com','','','','','2026-11-10T02:44:13Z','',NULL,'','',0);
INSERT INTO "messages" VALUES(10,'<codecrafters-io/build-your-own-x/issues/2092/6757273497@github.com>',NULL,'in','ignored','done','notifications@github.com','','','','','2026-11-10T02:44:45Z','',NULL,'','',0);
INSERT INTO "messages" VALUES(11,'<20261110030351.fe2c1608bb9c0d2b@em.onedayonly.co.za>',NULL,'in','ignored','done','newsletter@em.onedayonly.co.za','','','','','2026-11-10T03:03:51Z','',NULL,'','',0);
INSERT INTO "messages" VALUES(12,'<68.BB.32564.97092FA6@i-07cad0af1e5f569c8.mta3vrest.sd.prd.sparkpost>',NULL,'in','ignored','done','email@newsroom.news24.com','','','','','2026-11-10T03:33:13Z','',NULL,'','',0);
INSERT INTO "messages" VALUES(13,'<CpSqzkJLSnq_WNVYroPicQ@geopod-ismtpd-116>',NULL,'in','ignored','done','csunderarmour@apollobrands.co.za','','','','','2026-11-10T04:00:32Z','',NULL,'','',0);
INSERT INTO "messages" VALUES(14,'<2038274448.35751191.1794283306069@lva2-app67741.prod.linkedin.com>',NULL,'in','ignored','done','newsletters-noreply@linkedin.com','','','','','2026-11-10T04:01:46Z','',NULL,'','',0);
INSERT INTO "messages" VALUES(15,'<vuh97dZqTLmPdAq7ZaVJkA@geopod-ismtpd-42>',NULL,'in','ignored','done','noreply@medium.com','','','','','2026-11-10T05:10:00Z','',NULL,'','',0);
INSERT INTO "messages" VALUES(16,'<tLpyMU9nTTSjxyCAVGVIHA@geopod-ismtpd-17>',NULL,'in','ignored','done','hello@mail.checkers.co.za','','','','','2026-11-10T06:04:23Z','',NULL,'','',0);
INSERT INTO "messages" VALUES(17,'<79decdc8e2815b6d7dc014d7f865ce51@tracking.awards.co.za>',NULL,'in','ignored','done','rewards@ucount.co.za','','','','','2026-11-10T06:07:36Z','',NULL,'','',0);
INSERT INTO "messages" VALUES(18,'<20261110061601.63f5049e1d662191@perfumology.co.za>',NULL,'in','ignored','done','hello@perfumology.co.za','','','','','2026-11-10T06:16:01Z','',NULL,'','',0);
INSERT INTO "messages" VALUES(19,'<DreamverseHoldings/aidlink/pull/130/c6760725009@github.com>',NULL,'in','ignored','done','notifications@github.com','','','','','2026-11-10T06:29:52Z','',NULL,'','',0);
INSERT INTO "messages" VALUES(20,'<DreamverseHoldings/aidlink/pull/130/c6760725343@github.com>',NULL,'in','ignored','done','notifications@github.com','','','','','2026-11-10T06:29:56Z','',NULL,'','',0);
INSERT INTO "messages" VALUES(21,'<DreamverseHoldings/aidlink/pull/131/c6760725638@github.com>',NULL,'in','ignored','done','notifications@github.com','','','','','2026-11-10T06:29:56Z','',NULL,'','',0);
INSERT INTO "messages" VALUES(22,'<DreamverseHoldings/aidlink/pull/131/c6760726169@github.com>',NULL,'in','ignored','done','notifications@github.com','','','','','2026-11-10T06:29:59Z','',NULL,'','',0);
INSERT INTO "messages" VALUES(23,'<CIoYIPaRS6-PJreeeRMSsQ@geopod-ismtpd-105>',NULL,'in','ignored','done','info@bashafrica.com','','','','','2026-11-10T06:30:20Z','',NULL,'','',0);
INSERT INTO "messages" VALUES(24,'<DreamverseHoldings/aidlink/pull/130/review/5837696281@github.com>',NULL,'in','ignored','done','notifications@github.com','','','','','2026-11-10T06:32:15Z','',NULL,'','',0);
INSERT INTO "messages" VALUES(25,'<7af902c3-ef56-492f-ad93-55e6e31b878e@az.eastus2.microsoft.com>',NULL,'in','ignored','done','microsoft-noreply@microsoft.com','','','','','2026-11-10T06:58:20Z','',NULL,'','',0);
INSERT INTO "messages" VALUES(26,'<20261110070438.e68bad3681eed7e5@crm.juliangoldie.com>',NULL,'in','ignored','done','me@juliangoldie.com','','','','','2026-11-10T07:04:38Z','',NULL,'','',0);
INSERT INTO "messages" VALUES(27,'<61.CC.50226.5B2C2FA6@i-0efe3b5c18928897d.mta3vrest.sd.prd.sparkpost>',NULL,'in','ignored','done','deals@newsletters.takealot.com','','','','','2026-11-10T07:07:33Z','',NULL,'','',0);
INSERT INTO "messages" VALUES(28,'<010001a1c45e427f-d8b6a31a-f659-4767-b9a8-83ccd4a8587e-000000@email.amazonses.com>',NULL,'in','ignored','done','aws-marketing-email-replies@amazon.com','','','','','2026-11-10T07:31:14Z','',NULL,'','',0);
INSERT INTO "messages" VALUES(29,'<_8DAJ7cDQaqpqDab21xRuw@geopod-ismtpd-3>',NULL,'in','ignored','done','noreply@skool.com','','','','','2026-11-10T07:33:50Z','',NULL,'','',0);
INSERT INTO "messages" VALUES(30,'<DreamverseHoldings/aidlink/pull/132/c6761799316@github.com>',NULL,'in','ignored','done','notifications@github.com','','','','','2026-11-10T07:38:35Z','',NULL,'','',0);
INSERT INTO "messages" VALUES(31,'<DreamverseHoldings/aidlink/pull/132/c6761803977@github.com>',NULL,'in','ignored','done','notifications@github.com','','','','','2026-11-10T07:38:52Z','',NULL,'','',0);
INSERT INTO "messages" VALUES(32,'<DreamverseHoldings/aidlink/pull/132/review/5838286579@github.com>',NULL,'in','ignored','done','notifications@github.com','','','','','2026-11-10T07:41:57Z','',NULL,'','',0);
INSERT INTO "messages" VALUES(33,'<1620853596.36043138.1794296738844@lva2-app68796.prod.linkedin.com>',NULL,'in','alert','done','jobalerts-noreply@linkedin.com','','Blacksmith Agency is hiring a AI Software Engineer (Remote, Durban)','','','2026-11-10T07:45:38Z','',NULL,'','',0);
INSERT INTO "messages" VALUES(34,'<20261110074659.375f43986b8d0ab0@scentimental.co.za>',NULL,'in','ignored','done','sales@scentimental.co.za','','','','','2026-11-10T07:46:59Z','',NULL,'','',0);
INSERT INTO "messages" VALUES(35,'<-vS3ilp4QWylKzmI98hhXg@geopod-ismtpd-20>',NULL,'in','ignored','done','noreply@skool.com','','','','','2026-11-10T08:03:22Z','',NULL,'','',0);
INSERT INTO "messages" VALUES(36,'<asFTLSWSjGuB08TqMiqFgn-sq9ROzxWVoQEdI0QkMdlhOKoDKCWojWUuigbAbHjz6PocExqZTeBG4y3tqZQchdIjLrOsSOf3k_kmF9PgSbWSxeyepGgGaC45WcwgO1QSZo3YPgABAgA=@t1.msgid.quoramail.com>',NULL,'in','ignored','done','english-quora-digest@quora.com','','','','','2026-11-10T08:30:27Z','',NULL,'','',0);
INSERT INTO "messages" VALUES(37,'<79.B4.25718.0F6D2FA6@i-0438b888424bc464e.mta3vrest.sd.prd.sparkpost>',NULL,'in','ignored','done','subs@marketing.news24.com','','','','','2026-11-10T08:33:52Z','',NULL,'','',0);
INSERT INTO "messages" VALUES(38,'<e57e39dd-9c30-381d-9c5f-7e9706fe9928@a.europe.nflshop.com>',NULL,'in','ignored','done','nflshop@a.europe.nflshop.com','','','','','2026-11-10T09:01:21Z','',NULL,'','',0);
INSERT INTO "messages" VALUES(39,'<42651b5e-a1bd-4547-88a4-46290a8fd4f7@atl1s07mta0293.xt.local>',NULL,'in','ignored','done','info@mailwoolworths.co.za','','','','','2026-11-10T09:03:57Z','',NULL,'','',0);
INSERT INTO "messages" VALUES(40,'<765639640.38032361.1794303937926@lva2-app68782.prod.linkedin.com>',NULL,'in','alert','done','jobalerts-noreply@linkedin.com','','Sedna Inc Senior Linux Embedded Developer','','','2026-11-10T09:45:37Z','',NULL,'','',0);
INSERT INTO "messages" VALUES(41,'<010001a1c4da880d-74285b1c-35a3-4a15-9dea-37a219fb0d71-000000@email.amazonses.com>',NULL,'in','ignored','done','hello@lottiefiles.com','','','','','2026-11-10T09:46:58Z','',NULL,'','',0);
INSERT INTO "messages" VALUES(42,'<010001a1c4e117c6-ade27985-1e89-4487-9fe5-c9707e940ff2-000000@email.amazonses.com>',NULL,'in','ignored','done','send@sterkinekor.com','','','','','2026-11-10T09:54:08Z','',NULL,'','',0);
INSERT INTO "messages" VALUES(43,'<5SWKH1MNSISLvMynwWRwEw@geopod-ismtpd-23>',NULL,'in','ignored','done','noreply@skool.com','','','','','2026-11-10T10:08:18Z','',NULL,'','',0);
INSERT INTO "messages" VALUES(44,'<C8.16.43894.A3FE2FA6@i-091bc332b909c5cf4.mta3vrest.sd.prd.sparkpost>',NULL,'in','ignored','done','deals@newsletters.takealot.com','','','','','2026-11-10T10:17:30Z','',NULL,'','',0);
INSERT INTO "messages" VALUES(45,'<20261110104819.1660e4b9db4eb485@em.onedayonly.co.za>',NULL,'in','ignored','done','newsletter@em.onedayonly.co.za','','','','','2026-11-10T10:48:19Z','',NULL,'','',0);
INSERT INTO "messages" VALUES(46,'<1566764531.1145555.1794309564069@lva2-app66071.prod.linkedin.com>',NULL,'in','ignored','done','jobs-noreply@linkedin.com','','','','','2026-11-10T11:19:24Z','',NULL,'','',0);
INSERT INTO "messages" VALUES(47,'<010001a1c53b1c83-01531d08-205a-45f1-a23e-8dec2884f275-000000@email.amazonses.com>',NULL,'in','ignored','done','admin@tiptopmeat.co.za','','','','','2026-11-10T11:32:27Z','',NULL,'','',0);
INSERT INTO "messages" VALUES(48,'<4B.E7.20385.A5103FA6@i-03646ee7d575406c2.mta3vrest.sd.prd.sparkpost>',NULL,'in','ignored','done','deals@newsletters.takealot.com','','','','','2026-11-10T11:34:50Z','',NULL,'','',0);
INSERT INTO "messages" VALUES(49,'<6af3027c.be655ef4.e30af.f4edSMTPIN_ADDED_MISSING@mx.google.com>',NULL,'in','ignored','done','info@fatsecret.com','','','','','2026-11-10T11:39:40Z','',NULL,'','',0);
INSERT INTO "messages" VALUES(50,'<1344165981.38514168.1794311139172@lva2-app67744.prod.linkedin.com>',NULL,'in','alert','done','jobalerts-noreply@linkedin.com','','DT Projects SA Full Stack Developer (C#/.NET & Angular) | Mid to
 Senior','','','2026-11-10T11:45:39Z','',NULL,'','',0);
INSERT INTO "messages" VALUES(51,'<202610111202.5v3f8r98st77bj@kd.d.sender-sib.com>',NULL,'in','ignored','done','lucinda@companypartners.co.za','','','','','2026-11-10T12:02:44Z','',NULL,'','',0);
INSERT INTO "messages" VALUES(52,'<1k72n6djep5et800@indeed.com>',NULL,'in','ignored','done','donotreply@jobalert.indeed.com','','','','','2026-11-10T12:33:44Z','',NULL,'','',0);
INSERT INTO "messages" VALUES(53,'<Fky1CTCIQEGlxbjjnFopWg@geopod-ismtpd-42>',NULL,'in','ignored','done','onlineorders@fairprice.co.za','','','','','2026-11-10T12:36:07Z','',NULL,'','',0);
INSERT INTO "messages" VALUES(54,'<1k72ng9okq9sg800@indeed.com>',NULL,'in','ignored','done','donotreply@match.indeed.com','','','','','2026-11-10T12:39:08Z','',NULL,'','',0);
INSERT INTO "messages" VALUES(55,'<wvu60lklwqhgh496eezh7hnneq35vf8h4oldk@kit-mail3.com>',NULL,'in','ignored','done','pat@patdamiano.com','','','','','2026-11-10T12:45:15Z','',NULL,'','',0);
INSERT INTO "messages" VALUES(56,'<371293290.83910.1794318339588@lor1-app163409.prod.linkedin.com>',NULL,'in','ignored','done','groups-noreply@linkedin.com','','','','','2026-11-10T13:45:39Z','',NULL,'','',0);
INSERT INTO "messages" VALUES(57,'<010f01a1c5c72208-e467706a-1fe3-4cf3-ad49-dfa4dfb38bd7-000000@us-east-2.amazonses.com>',NULL,'in','ignored','done','news@alphasignal.ai','','','','','2026-11-10T14:05:24Z','',NULL,'','',0);
INSERT INTO "messages" VALUES(58,'<010001a1c5ced88c-96e26a60-4dcf-4727-b433-bf2a32b1f334-000000@email.amazonses.com>',NULL,'in','ignored','done','noreply@newsletter.journalclub.io','','','','','2026-11-10T14:13:49Z','',NULL,'','',0);
INSERT INTO "messages" VALUES(59,'<20261110141927.8c3e663e180c31fc@crm.juliangoldie.com>',NULL,'in','ignored','done','me@juliangoldie.com','','','','','2026-11-10T14:19:27Z','',NULL,'','',0);
INSERT INTO "messages" VALUES(60,'<6af32e83a1966_1091330127bf@sharedworker-5f9c9cc4bd-jsqpq.mail>',NULL,'in','ignored','done','noreply@github.com','','','','','2026-11-10T14:47:31Z','',NULL,'','',0);
INSERT INTO "messages" VALUES(61,'<447c290e-bb3b-449d-bfe8-1ef66b85b344@cdg3s51mta0444.xt.local>',NULL,'in','ignored','done','deals@marketing.makro.co.za','','','','','2026-11-10T15:01:51Z','',NULL,'','',0);
INSERT INTO "messages" VALUES(62,'<A3.08.56633.EB733FA6@i-0f5d359962ec32d6b.mta3vrest.sd.prd.sparkpost>',NULL,'in','ignored','done','deals@newsletters.takealot.com','','','','','2026-11-10T15:26:54Z','',NULL,'','',0);
INSERT INTO "messages" VALUES(63,'<20261110154216.83fcc2d74d42a2c7@email.claude.com>',NULL,'in','ignored','done','no-reply@email.claude.com','','','','','2026-11-10T15:42:16Z','',NULL,'','',0);
INSERT INTO "messages" VALUES(64,'<1678369857.673376.1794325539700@lor1-app128989.prod.linkedin.com>',NULL,'in','ignored','done','messages-noreply@linkedin.com','','','','','2026-11-10T15:45:39Z','',NULL,'','',0);
INSERT INTO "messages" VALUES(65,'<14230264052.131.1115700298.callme@ret.college.ch>',NULL,'in','ignored','done','zurich@rkc.edu','','','','','2026-11-10T16:17:11Z','',NULL,'','',0);
INSERT INTO "messages" VALUES(66,'<e38507bc-d943-41f4-87a9-6060a5218f54@atl1s07mta0106.xt.local>',NULL,'in','ignored','done','za@e.edreams.com','','','','','2026-11-10T16:24:33Z','',NULL,'','',0);
INSERT INTO "messages" VALUES(67,'<20261110163340.8c68624a5815fa66@cio97766.huntr.co>',NULL,'in','ignored','done','hello@huntr.co','','','','','2026-11-10T16:33:40Z','',NULL,'','',0);
INSERT INTO "messages" VALUES(68,'<1464656531.39374104.1794329384097@lva2-app65290.prod.linkedin.com>',NULL,'in','ignored','done','messages-noreply@linkedin.com','','','','','2026-11-10T16:49:44Z','',NULL,'','',0);
INSERT INTO "messages" VALUES(69,'<000qxZgqYlyZqLRFbJJL-FS24fR-3T67ZST0oDGVHJv50nz7PyU3Ap339CYbFB-c6XCJbDh40UPrfvCpAZ94ljJwjEAMxMv9Hoq4NiETPSC6BOaTOBuceEy0FhUaqpX3pIitygABAgA=@t1.msgid.quoramail.com>',NULL,'in','ignored','done','english-quora-digest@quora.com','','','','','2026-11-10T16:53:03Z','',NULL,'','',0);
INSERT INTO "messages" VALUES(70,'<1694401393.38984930.1794332737764@lva2-app66531.prod.linkedin.com>',NULL,'in','ignored','done','messages-noreply@linkedin.com','','','','','2026-11-10T17:45:37Z','',NULL,'','',0);
INSERT INTO "messages" VALUES(71,'<6af3586f1342c_121a020831f8@6183237705ff.mail>',NULL,'in','ignored','done','no-reply@emails.whop.com','','','','','2026-11-10T17:46:23Z','',NULL,'','',0);
INSERT INTO "messages" VALUES(72,'<303479033.3430449.1794333457507@lva2-app64146.prod.linkedin.com>',NULL,'in','ignored','done','notifications-noreply@linkedin.com','','','','','2026-11-10T17:57:37Z','',NULL,'','',0);
INSERT INTO "messages" VALUES(73,'<zErINAtNTuemehdJsgLFog@geopod-ismtpd-100>',NULL,'in','ignored','done','no-reply@github.com','','','','','2026-11-10T18:00:56Z','',NULL,'','',0);
INSERT INTO "messages" VALUES(74,'<2012192397.73063.1794334168450@service-v2-7ff7944b8d-zgfsz>',NULL,'in','ignored','done','imangadzhi@consulting.com','','','','','2026-11-10T18:09:28Z','',NULL,'','',0);
INSERT INTO "messages" VALUES(75,'<1867915080.71391.1794334177735@service-v2-7ff7944b8d-jgdts>',NULL,'in','ignored','done','imangadzhi@consulting.com','','','','','2026-11-10T18:09:37Z','',NULL,'','',0);
INSERT INTO "messages" VALUES(76,'<1810865093.24618.1794335693103@marketo-platform--email-sender-prod-batch-cluster-568cdc67lz7fq>',NULL,'in','ignored','done','news@nvidia.com','','','','','2026-11-10T18:34:53Z','',NULL,'','',0);
INSERT INTO "messages" VALUES(77,'<1k73cf68qgarl80a@indeed.com>',NULL,'in','ignored','done','donotreply@jobalert.indeed.com','','','','','2026-11-10T18:45:32Z','',NULL,'','',0);
INSERT INTO "messages" VALUES(78,'<rDSpNXLTQ_yqzZyDHRit8g@geopod-ismtpd-24>',NULL,'in','ignored','done','noreply@skool.com','','','','','2026-11-10T19:09:42Z','',NULL,'','',0);
INSERT INTO "messages" VALUES(79,'<610779250.218540041794348889248.JavaMail.tomee@pc33j2wmail01>',NULL,'in','ignored','done','eyjobalerts@noreply12.jobs2web.com','','','','','2026-11-10T22:14:49Z','',NULL,'','',0);
INSERT INTO "messages" VALUES(80,'<20261111001753.f6dcc7fab5597297@crm.juliangoldie.com>',NULL,'in','ignored','done','me@juliangoldie.com','','','','','2026-11-11T00:17:53Z','',NULL,'','',0);
INSERT INTO "messages" VALUES(81,'<ChiromboKenT/vken-design-engine/check-suites/CS_kwDOSXOco88AAAAbEkfzhw/1794358312@github.com>',NULL,'in','ignored','done','notifications@github.com','','','','','2026-11-11T00:52:12Z','',NULL,'','',0);
INSERT INTO "messages" VALUES(82,'<ChiromboKenT/vken-design-engine/check-suites/CS_kwDOSXOco88AAAAbEvaueg/1794359411@github.com>',NULL,'in','ignored','done','notifications@github.com','','','','','2026-11-11T01:10:31Z','',NULL,'','',0);
INSERT INTO "messages" VALUES(83,'<20261111011933.6445a823091b775f@crm.juliangoldie.com>',NULL,'in','ignored','done','me@juliangoldie.com','','','','','2026-11-11T01:19:33Z','',NULL,'','',0);
INSERT INTO "messages" VALUES(84,'<1805686340.1425696.1794364686657@email-sender-8d9f9679c-v6rzk>',NULL,'in','ignored','done','campaigns@msg.smartrecruiters.app','','','','','2026-11-11T02:38:06Z','',NULL,'','',0);
INSERT INTO "messages" VALUES(85,'<20261111030411.fa343d44aedfed60@em.onedayonly.co.za>',NULL,'in','ignored','done','newsletter@em.onedayonly.co.za','','','','','2026-11-11T03:04:11Z','',NULL,'','',0);
INSERT INTO "messages" VALUES(86,'<1058765614.15029926.1794367969160@mob-r1-l-igm-05.x.fnb.co.za>',NULL,'in','ignored','done','incontact@fnb.co.za','','','','','2026-11-11T03:32:49Z','',NULL,'','',0);
INSERT INTO "messages" VALUES(87,'<825038847.13776564.1794367970459@mob-r3-l-igm-04.x.fnb.co.za>',NULL,'in','ignored','done','incontact@fnb.co.za','','','','','2026-11-11T03:32:50Z','',NULL,'','',0);
INSERT INTO "messages" VALUES(88,'<1662124066.12234125.1794367972201@mob-r1-l-igm-01.x.fnb.co.za>',NULL,'in','ignored','done','incontact@fnb.co.za','','','','','2026-11-11T03:32:52Z','',NULL,'','',0);
INSERT INTO "messages" VALUES(89,'<b5e15b07-8d2a-45bf-b690-47aee108d3c9@az.westus3.microsoft.com>',NULL,'in','ignored','done','microsoft-noreply@microsoft.com','','','','','2026-11-11T03:34:44Z','',NULL,'','',0);
INSERT INTO "messages" VALUES(90,'<C5.42.19082.6D3E3FA6@i-01a94a91d7039bc96.mta3vrest.sd.prd.sparkpost>',NULL,'in','ignored','done','email@newsroom.news24.com','','','','','2026-11-11T03:41:10Z','',NULL,'','',0);
INSERT INTO "messages" VALUES(91,'<W__DYtjcTRaFVaqUgs1ofA@geopod-ismtpd-52>',NULL,'in','ignored','done','csunderarmour@apollobrands.co.za','','','','','2026-11-11T04:00:45Z','',NULL,'','',0);
INSERT INTO "messages" VALUES(92,'<ayduDc_MR32kfF1QU-DKMQ@geopod-ismtpd-6>',NULL,'in','ignored','done','noreply@medium.com','','','','','2026-11-11T05:10:00Z','',NULL,'','',0);
INSERT INTO "messages" VALUES(93,'<bLgy-4nSQnWcvbtenUuXPg@geopod-ismtpd-28>',NULL,'in','ignored','done','noreply@skool.com','','','','','2026-11-11T05:30:02Z','',NULL,'','',0);
INSERT INTO "messages" VALUES(94,'<98108347.46348.1794375841428@mob-r4-l-igm-01.x.fnb.co.za>',NULL,'in','ignored','done','incontact@fnb.co.za','','','','','2026-11-11T05:44:01Z','',NULL,'','',0);
INSERT INTO "messages" VALUES(95,'<0E.33.32207.30A04FA6@i-08f9d1b5c9910d8f8.mta3vrest.sd.prd.sparkpost>',NULL,'in','ignored','done','deals@newsletters.takealot.com','','','','','2026-11-11T06:24:03Z','',NULL,'','',0);
INSERT INTO "messages" VALUES(96,'<5BZH.1I507.8452AF7408A451945LAM1JD679DEF34AD02EA3.7f76f4d6-b363-4c58-9c44-a188ed82c492@mailer.mrphome.com>',NULL,'in','ignored','done','home@mailer.mrphome.com','','','','','2026-11-11T06:47:38Z','',NULL,'','',0);
INSERT INTO "messages" VALUES(97,'<a240ebc3-84b9-47ea-b140-588463cf88a8@dfw1s10mta0083.xt.local>',NULL,'in','ignored','done','advertise-noreply@global.metamail.com','','','','','2026-11-11T07:09:54Z','',NULL,'','',0);
INSERT INTO "messages" VALUES(98,'<b3253d502fe7d84298197c561.3939f97812.20261111073241.b9ab5edc21.bd43d3a8@mail104.sea21.rsgsv.net>',NULL,'in','ignored','done','newsletter@joburg.vip','','','','','2026-11-11T07:33:17Z','',NULL,'','',0);
INSERT INTO "messages" VALUES(99,'<424445553.28150657.1794383137317@ltx1-app47450.prod.linkedin.com>',NULL,'in','alert','done','jobalerts-noreply@linkedin.com','','Senior Software Engineer - Frontend - Consumer at Ink Foundation','','','2026-11-11T07:45:37Z','',NULL,'','',0);
INSERT INTO "messages" VALUES(100,'<WSXiSxMxQOa5cVtLdqwoSw@geopod-ismtpd-18>',NULL,'in','ignored','done','noreply@skool.com','','','','','2026-11-11T07:56:14Z','',NULL,'','',0);
INSERT INTO "messages" VALUES(101,'<cH4c2c_jRfWdh3PxuIjrmQ@geopod-ismtpd-31>',NULL,'in','ignored','done','noreply@skool.com','','','','','2026-11-11T08:00:01Z','',NULL,'','',0);
INSERT INTO "messages" VALUES(102,'<f2448fb4-1b01-4001-bcdf-96b6df84000e@cdg3s51mta0675.xt.local>',NULL,'in','ignored','done','orders@sales.netflorist.co.za','','','','','2026-11-11T08:04:26Z','',NULL,'','',0);
INSERT INTO "messages" VALUES(103,'<w13jnn5ecAN0JXx25M11uXbelHiLPu369TXjpxUPAaXPIFSQOpGQME8SNHvJ5YcWVp5gbOLecLQefoaTiQgx9_tjOYIdGB1ysstoReaXm1LcnRB4J6fFmjsM3cS4m3bYgfL9AAECAA==@t1.msgid.quoramail.com>',NULL,'in','ignored','done','english-quora-digest@quora.com','','','','','2026-11-11T08:21:36Z','',NULL,'','',0);
INSERT INTO "messages" VALUES(104,'<20261111083314.4adc2187dcc95937@luvland.co.za>',NULL,'in','ignored','done','no-reply@luvland.co.za','','','','','2026-11-11T08:33:14Z','',NULL,'','',0);
INSERT INTO "messages" VALUES(105,'<731908028.235070591794386855160.JavaMail.tomee@pc33j2wmail02>',NULL,'in','ignored','done','nedbank-jobnotification@noreply12.jobs2web.com','','','','','2026-11-11T08:47:35Z','',NULL,'','',0);
INSERT INTO "messages" VALUES(106,'<20261111085257.23e1a2e847b8f449@em.onedayonly.co.za>',NULL,'in','ignored','done','newsletter@em.onedayonly.co.za','','','','','2026-11-11T08:52:57Z','',NULL,'','',0);
INSERT INTO "messages" VALUES(107,'<c495cd5e-6a14-488c-8b7c-e7de7dc94524@fra3s50mta0772.xt.local>',NULL,'in','ignored','done','clubcard@email.clicks.co.za','','','','','2026-11-11T09:45:28Z','',NULL,'','',0);
INSERT INTO "messages" VALUES(108,'<1528482443.6777455.1794390339148@ltx1-app99904.prod.linkedin.com>',NULL,'in','alert','done','jobalerts-noreply@linkedin.com','','Jobgether Software Engineer: Core and 7 other jobs you may be
 interested in','','','2026-11-11T09:45:39Z','',NULL,'','',0);
INSERT INTO "messages" VALUES(109,'<86ac8ada-913c-4823-86c8-206dd4230353@ind1s01mta0066.xt.local>',NULL,'in','ignored','done','emirates@e.emirates.email','','','','','2026-11-11T09:50:59Z','',NULL,'','',0);
INSERT INTO "messages" VALUES(110,'<761e0327-77e1-4405-bdcc-d5faa0f66aa0@fra3s50mta0159.xt.local>',NULL,'in','ignored','done','noreply-information@standardbank.co.za','','','','','2026-11-11T10:06:04Z','',NULL,'','',0);
INSERT INTO "messages" VALUES(111,'<1775919158.134679.1794392322037@marketo-platform--email-sender-prod-batch-cluster-568cdc67mtb22>',NULL,'in','ignored','done','inceptionprogram@nvidia.com','','','','','2026-11-11T10:18:42Z','',NULL,'','',0);
INSERT INTO "messages" VALUES(112,'<20261111101925.f917d02dfe40dcbe@crm.juliangoldie.com>',NULL,'in','ignored','done','me@juliangoldie.com','','','','','2026-11-11T10:19:25Z','',NULL,'','',0);
INSERT INTO "messages" VALUES(113,'<gGbSo74DRdi3wWKZrviWtA@geopod-ismtpd-63>',NULL,'in','ignored','done','info@iloveboobies.co.za','','','','','2026-11-11T10:20:54Z','',NULL,'','',0);
INSERT INTO "messages" VALUES(114,'<20261111104829.b6145f6a83b7fe3b@em.onedayonly.co.za>',NULL,'in','ignored','done','newsletter@em.onedayonly.co.za','','','','','2026-11-11T10:48:29Z','',NULL,'','',0);
INSERT INTO "messages" VALUES(115,'<010001a1ca3e24a1-7d2e32ba-5364-47f4-8f6a-10e01aeff065-000000@email.amazonses.com>',NULL,'in','ignored','done','orders@dailymaverick.co.za','','','','','2026-11-11T10:53:52Z','',NULL,'','',0);
INSERT INTO "messages" VALUES(116,'<91f0e250-f4ff-4ea3-8a51-43447785e2ac@mtasv.net>',NULL,'in','ignored','done','no-reply@render.com','','','','','2026-11-11T10:56:08Z','',NULL,'','',0);
INSERT INTO "messages" VALUES(117,'<010001a1ca42af1e-55e7f13f-3625-4c5d-b07f-a40cf2156d85-000000@email.amazonses.com>',NULL,'in','ignored','done','send@sterkinekor.com','','','','','2026-11-11T10:58:50Z','',NULL,'','',0);
INSERT INTO "messages" VALUES(118,'<0C.5E.12467.6D354FA6@i-0d67b0256590868d4.mta3vrest.sd.prd.sparkpost>',NULL,'in','ignored','done','deals@newsletters.takealot.com','','','','','2026-11-11T11:39:02Z','',NULL,'','',0);
INSERT INTO "messages" VALUES(119,'<2143547767.10204323.1794397537793@ltx1-app103741.prod.linkedin.com>',NULL,'in','alert','done','jobalerts-noreply@linkedin.com','','Blacksmith Agency AI Developer (Remote, Polokwane)','','','2026-11-11T11:45:37Z','',NULL,'','',0);
INSERT INTO "messages" VALUES(120,'<5bb79d26.BAAACciPZLwAAAAyeLwAANemxfgAAAACJG8ABGR8ACigVQBq9Feb@mailjet.com>',NULL,'in','ignored','done','info@mail.incredible.co.za','','','','','2026-11-11T11:55:07Z','',NULL,'','',0);
INSERT INTO "messages" VALUES(121,'<codecrafters-io/build-your-own-x/issues/2093@github.com>',NULL,'in','ignored','done','notifications@github.com','','','','','2026-11-11T12:02:59Z','',NULL,'','',0);
INSERT INTO "messages" VALUES(122,'<46cf1a16-93dc-4fc4-aa0a-dcddce56376e@fra3s50mta0159.xt.local>',NULL,'in','ignored','done','noreply-information@standardbank.co.za','','','','','2026-11-11T12:09:47Z','',NULL,'','',0);
INSERT INTO "messages" VALUES(123,'<codecrafters-io/build-your-own-x/issues/2093/6795297148@github.com>',NULL,'in','ignored','done','notifications@github.com','','','','','2026-11-11T12:24:56Z','',NULL,'','',0);
INSERT INTO "messages" VALUES(124,'<codecrafters-io/build-your-own-x/pull/2094@github.com>',NULL,'in','ignored','done','notifications@github.com','','','','','2026-11-11T12:27:36Z','',NULL,'','',0);
INSERT INTO "messages" VALUES(125,'<sYjTw7_dSbajW1a0HAi2Lg@geopod-ismtpd-112>',NULL,'in','ignored','done','updates@hello.designcrowd.com','','','','','2026-11-11T12:29:09Z','',NULL,'','',0);
INSERT INTO "messages" VALUES(126,'<1k759sftqiatp802@indeed.com>',NULL,'in','ignored','done','donotreply@match.indeed.com','','','','','2026-11-11T12:38:51Z','',NULL,'','',0);
INSERT INTO "messages" VALUES(127,'<38uorndng4akhr65rxnirh445wmvns7h6gx7w@kit-mail3.com>',NULL,'in','ignored','done','pat@patdamiano.com','','','','','2026-11-11T12:46:00Z','',NULL,'','',0);
INSERT INTO "messages" VALUES(128,'<z7y8nzlgSvCqsMzhcrPQqQ@geopod-ismtpd-29>',NULL,'in','ignored','done','email@email.etsy.com','','','','','2026-11-11T13:07:30Z','',NULL,'','',0);
INSERT INTO "messages" VALUES(129,'<1k75covgvm2fn806@indeed.com>',NULL,'in','ignored','done','donotreply@jobalert.indeed.com','','','','','2026-11-11T13:29:21Z','',NULL,'','',0);
INSERT INTO "messages" VALUES(130,'<1215529719.43251570.1794404736701@ltx1-app61509.prod.linkedin.com>',NULL,'in','alert','done','jobalerts-noreply@linkedin.com','','Ink Foundation is hiring: Senior Software Engineer - Frontend -
 Consumer','','','2026-11-11T13:45:36Z','',NULL,'','',0);
INSERT INTO "messages" VALUES(131,'<isyB1_wq5_QQYotnEVvTQmbiW7N0Q7aipvReAgxVgUp1sNu0kxGM02jm4beaTb57dBgrht9C89KkibG2kEnjYD6cCunP5ouvaka6MjipHp3Sk77pU_Mg-7HCORth2CES4jPgsgABAgA=@t1.msgid.quoramail.com>',NULL,'in','ignored','done','english-quora-digest@quora.com','','','','','2026-11-11T13:55:14Z','',NULL,'','',0);
INSERT INTO "messages" VALUES(132,'<010001a1caf510e2-369b42c1-bb40-46c6-a69f-dfdf98816aae-000000@email.amazonses.com>',NULL,'in','ignored','done','noreply@newsletter.journalclub.io','','','','','2026-11-11T14:13:40Z','',NULL,'','',0);
INSERT INTO "messages" VALUES(133,'<010f01a1caf70618-7a897343-f31d-4a2d-a0fe-72636e3646d8-000000@us-east-2.amazonses.com>',NULL,'in','ignored','done','news@alphasignal.ai','','','','','2026-11-11T14:15:49Z','',NULL,'','',0);
INSERT INTO "messages" VALUES(134,'<20261111141931.10ca4462a63238bc@crm.juliangoldie.com>',NULL,'in','ignored','done','me@juliangoldie.com','','','','','2026-11-11T14:19:31Z','',NULL,'','',0);
INSERT INTO "messages" VALUES(135,'<20261111144017.950744b2439d0f6a@scentimental.co.za>',NULL,'in','ignored','done','sales@scentimental.co.za','','','','','2026-11-11T14:40:17Z','',NULL,'','',0);
INSERT INTO "messages" VALUES(136,'<pmZGO-TMSUG8pESD_kCXJg@geopod-ismtpd-10>',NULL,'in','ignored','done','noreply@skool.com','','','','','2026-11-11T14:46:28Z','',NULL,'','',0);
INSERT INTO "messages" VALUES(137,'<0F.E6.42634.68484FA6@i-00a545066c0d4f1fb.mta1vrest.sd.prd.sparkpost>',NULL,'in','ignored','done','do-not-reply@hello.stackoverflow.email','','','','','2026-11-11T15:06:46Z','',NULL,'','',0);
INSERT INTO "messages" VALUES(138,'<a444b913-c20c-42fa-a00e-f7f94f122c48@cdg3s51mta0454.xt.local>',NULL,'in','ignored','done','deals@marketing.makro.co.za','','','','','2026-11-11T15:29:53Z','',NULL,'','',0);
INSERT INTO "messages" VALUES(139,'<1141010706.485040.1794411139471@mob-r4-l-igm-06.x.fnb.co.za>',NULL,'in','ignored','done','incontact@fnb.co.za','','','','','2026-11-11T15:32:19Z','',NULL,'','',0);
INSERT INTO "messages" VALUES(140,'<ADR510000043683943005254005657771FE1B7BCAD67B2287374@NETCARE.CO.ZA>',NULL,'in','ignored','done','cleopatra.mathatsie@netcare.co.za','','','','','2026-11-11T15:34:28Z','',NULL,'','',0);
INSERT INTO "messages" VALUES(141,'<20261111155422.7ae6cb690f7664cb@em.onedayonly.co.za>',NULL,'in','ignored','done','newsletter@em.onedayonly.co.za','','','','','2026-11-11T15:54:22Z','',NULL,'','',0);
INSERT INTO "messages" VALUES(142,'<rg9wL6tLSouJs2sOGa-szQ@geopod-ismtpd-6>',NULL,'in','ignored','done','noreply@skool.com','','','','','2026-11-11T16:21:21Z','',NULL,'','',0);
INSERT INTO "messages" VALUES(143,'<codecrafters-io/build-your-own-x/issues/2095@github.com>',NULL,'in','ignored','done','notifications@github.com','','','','','2026-11-11T16:40:06Z','',NULL,'','',0);
INSERT INTO "messages" VALUES(144,'<codecrafters-io/build-your-own-x/issue/2095/issue_event/35822472120@github.com>',NULL,'in','ignored','done','notifications@github.com','','','','','2026-11-11T17:13:11Z','',NULL,'','',0);
INSERT INTO "messages" VALUES(145,'<16.07.12153.A93A4FA6@i-0a88d5ab26e1c0cbd.mta3vrest.sd.prd.sparkpost>',NULL,'in','ignored','done','deals@newsletters.takealot.com','','','','','2026-11-11T17:19:22Z','',NULL,'','',0);
INSERT INTO "messages" VALUES(146,'<codecrafters-io/build-your-own-x/issue/2095/issue_event/35822515849@github.com>',NULL,'in','ignored','done','notifications@github.com','','','','','2026-11-11T17:20:17Z','',NULL,'','',0);
INSERT INTO "messages" VALUES(147,'<1k75qhjv8macg807@indeed.com>',NULL,'in','ignored','done','donotreply@jobalert.indeed.com','','','','','2026-11-11T17:30:00Z','',NULL,'','',0);
INSERT INTO "messages" VALUES(148,'<1015524975.4912276.1794419139209@lor1-app139100.prod.linkedin.com>',NULL,'in','ignored','done','messages-noreply@linkedin.com','','','','','2026-11-11T17:45:39Z','',NULL,'','',0);
INSERT INTO "messages" VALUES(149,'<codecrafters-io/build-your-own-x/issues/2095/6802828376@github.com>',NULL,'in','ignored','done','notifications@github.com','','','','','2026-11-11T17:49:34Z','',NULL,'','',0);
INSERT INTO "messages" VALUES(150,'<1944763966.4582221.1794419858690@lor1-app171571.prod.linkedin.com>',NULL,'in','ignored','done','updates-noreply@linkedin.com','','','','','2026-11-11T17:57:38Z','',NULL,'','',0);
INSERT INTO "messages" VALUES(151,'<NMFFDA2ec5ca46-f55f-430b-bc8d-21d430dd15b9006C8B1Dlnkd_mid_prod2@em.linkedin.com>',NULL,'in','ignored','done','linkedin@em.linkedin.com','','','','','2026-11-11T18:03:55Z','',NULL,'','',0);
INSERT INTO "messages" VALUES(152,'<929169418.61110.1794431918175@lva2-app64867.prod.linkedin.com>',NULL,'in','ignored','done','security-noreply@linkedin.com','','','','','2026-11-11T21:18:38Z','',NULL,'','',0);
INSERT INTO "messages" VALUES(153,'<codecrafters-io/build-your-own-x/pull/2096@github.com>',NULL,'in','ignored','done','notifications@github.com','','','','','2026-11-11T22:35:54Z','',NULL,'','',0);
INSERT INTO "messages" VALUES(154,'<20261112001754.8b102b1cdd9b793b@crm.juliangoldie.com>',NULL,'in','ignored','done','me@juliangoldie.com','','','','','2026-11-12T00:17:54Z','',NULL,'','',0);
INSERT INTO "messages" VALUES(155,'<191dd829-8844-4585-bea6-9b710f537ef2@atl1s11mta1186.xt.local>',NULL,'in','ignored','done','donotreply@e.godaddy.com','','','','','2026-11-12T00:43:37Z','',NULL,'','',0);
INSERT INTO "messages" VALUES(156,'<ChiromboKenT/vken-design-engine/check-suites/CS_kwDOSXOco88AAAAbMXpdnw/1794444773@github.com>',NULL,'in','ignored','done','notifications@github.com','','','','','2026-11-12T00:53:13Z','',NULL,'','',0);
INSERT INTO "messages" VALUES(157,'<ChiromboKenT/vken-design-engine/check-suites/CS_kwDOSXOco88AAAAbMhxUBQ/1794445876@github.com>',NULL,'in','ignored','done','notifications@github.com','','','','','2026-11-12T01:11:38Z','',NULL,'','',0);
INSERT INTO "messages" VALUES(158,'<codecrafters-io/build-your-own-x/pull/2097@github.com>',NULL,'in','ignored','done','notifications@github.com','','','','','2026-11-12T01:19:17Z','',NULL,'','',0);
INSERT INTO "messages" VALUES(159,'<20261112011943.f734bdfc2a8a7e18@crm.juliangoldie.com>',NULL,'in','ignored','done','me@juliangoldie.com','','','','','2026-11-12T01:19:43Z','',NULL,'','',0);
INSERT INTO "messages" VALUES(160,'<codecrafters-io/build-your-own-x/pull/2098@github.com>',NULL,'in','ignored','done','notifications@github.com','','','','','2026-11-12T01:29:31Z','',NULL,'','',0);
INSERT INTO "messages" VALUES(161,'<codecrafters-io/build-your-own-x/pull/2099@github.com>',NULL,'in','ignored','done','notifications@github.com','','','','','2026-11-12T01:31:39Z','',NULL,'','',0);
INSERT INTO "messages" VALUES(162,'<9A.49.43047.24815FA6@i-08f9d1b5c9910d8f8.mta3vrest.sd.prd.sparkpost>',NULL,'in','ignored','done','info@jobalerts.pnet.co.za','','','','','2026-11-12T01:37:06Z','',NULL,'','',0);
INSERT INTO "messages" VALUES(163,'<codecrafters-io/build-your-own-x/pull/2100/review/5868158462@github.com>',NULL,'in','ignored','done','notifications@github.com','','','','','2026-11-12T03:02:41Z','',NULL,'','',0);
INSERT INTO "messages" VALUES(164,'<codecrafters-io/build-your-own-x/pull/2100@github.com>',NULL,'in','ignored','done','notifications@github.com','','','','','2026-11-12T03:03:13Z','',NULL,'','',0);
INSERT INTO "messages" VALUES(165,'<20261112030653.e23755b24d05024b@em.onedayonly.co.za>',NULL,'in','ignored','done','newsletter@em.onedayonly.co.za','','','','','2026-11-12T03:06:53Z','',NULL,'','',0);
INSERT INTO "messages" VALUES(166,'<BC.70.14253.E3335FA6@i-0dcae1139d500ecaf.mta3vrest.sd.prd.sparkpost>',NULL,'in','ignored','done','email@newsroom.news24.com','','','','','2026-11-12T03:32:14Z','',NULL,'','',0);
INSERT INTO "messages" VALUES(167,'<kUAIBRNWREOYg8bLuoDs0Q@geopod-ismtpd-33>',NULL,'in','ignored','done','noreply@skool.com','','','','','2026-11-12T03:56:45Z','',NULL,'','',0);
INSERT INTO "messages" VALUES(168,'<6iEU7-_RRQK8o6QUDpy22A@geopod-ismtpd-81>',NULL,'in','ignored','done','csunderarmour@apollobrands.co.za','','','','','2026-11-12T04:00:42Z','',NULL,'','',0);
INSERT INTO "messages" VALUES(169,'<dnko59TTSNuvICfjLrRRDA@geopod-ismtpd-78>',NULL,'in','ignored','done','noreply@medium.com','','','','','2026-11-12T05:10:00Z','',NULL,'','',0);
INSERT INTO "messages" VALUES(170,'<x-g_qwHCHQ7JAcUdxrA32g@notifications.google.com>',NULL,'in','ignored','done','no-reply@accounts.google.com','','','','','2026-11-12T05:28:30Z','',NULL,'','',0);
INSERT INTO "messages" VALUES(171,'<S7sTepsQRTzxStYVo3AdaA@notifications.google.com>',NULL,'in','ignored','done','no-reply@accounts.google.com','','','','','2026-11-12T05:30:18Z','',NULL,'','',0);
INSERT INTO "messages" VALUES(172,'<6af54fa36938c_296556497506c@system-sidekiq-default-5959d97d68-zdpd5.mail>',NULL,'in','ignored','done','no-reply@3scale.redhat.com','','','','','2026-11-12T05:33:23Z','',NULL,'','',0);
INSERT INTO "messages" VALUES(173,'<6af54fa35af9b_29d8294966711@system-sidekiq-default-5959d97d68-g6qcv.mail>',NULL,'in','ignored','done','no-reply@3scale.redhat.com','','','','','2026-11-12T05:33:23Z','',NULL,'','',0);
INSERT INTO "messages" VALUES(174,'<010001a1ce442930-fa2bc2db-d1ea-4335-8dd5-99e7929147e0-000000@email.amazonses.com>',NULL,'in','ignored','done','notifications@link.com','','','','','2026-11-12T05:38:55Z','',NULL,'','',0);
INSERT INTO "messages" VALUES(175,'<6af551a5b294f_29e274496750@system-sidekiq-default-5959d97d68-g6qcv.mail>',NULL,'in','ignored','done','no-reply@3scale.redhat.com','','','','','2026-11-12T05:41:57Z','',NULL,'','',0);
INSERT INTO "messages" VALUES(176,'<6af552682d6ce_12c133853699f@sharedworker-54c577d995-7797n.mail>',NULL,'in','ignored','done','noreply@github.com','','','','','2026-11-12T05:45:12Z','',NULL,'','',0);
INSERT INTO "messages" VALUES(177,'<20261112054546.6c47d6591f971b04@perfumology.co.za>',NULL,'in','ignored','done','hello@perfumology.co.za','','','','','2026-11-12T05:45:46Z','',NULL,'','',0);
INSERT INTO "messages" VALUES(178,'<-ONHpyvoQg2Is9pFb5AO_Q@geopod-ismtpd-5>',NULL,'in','ignored','done','hello@talent500.co','','','','','2026-11-12T06:01:07Z','',NULL,'','',0);
INSERT INTO "messages" VALUES(179,'<96e23f20-0e0a-4a21-80cc-4c7fe8ef3a89@cdg3s51mta0673.xt.local>',NULL,'in','ignored','done','orders@sales.netflorist.co.za','','','','','2026-11-12T06:03:57Z','',NULL,'','',0);
INSERT INTO "messages" VALUES(180,'<0D.C1.48234.C8755FA6@i-07cad0af1e5f569c8.mta3vrest.sd.prd.sparkpost>',NULL,'in','ignored','done','deals@newsletters.takealot.com','','','','','2026-11-12T06:07:08Z','',NULL,'','',0);
INSERT INTO "messages" VALUES(181,'<02d7c390-9397-4339-badc-68eec11d1ce6@cdg3s51mta0450.xt.local>',NULL,'in','ignored','done','deals@marketing.makro.co.za','','','','','2026-11-12T06:19:28Z','',NULL,'','',0);
INSERT INTO "messages" VALUES(182,'<179446624454.128.15615255303803059317@gmail.com>',NULL,'out','ignored','done','chirombokenny@gmail.com','','','','','2026-11-12T06:50:46Z','',NULL,'','',0);
INSERT INTO "messages" VALUES(183,'<DreamverseHoldings/dreamverse-image-studio/pull/1/c6816950114@github.com>',NULL,'in','ignored','done','notifications@github.com','','','','','2026-11-12T06:54:17Z','',NULL,'','',0);
INSERT INTO "messages" VALUES(184,'<DreamverseHoldings/dreamverse-image-studio/pull/1/review/5870415813@github.com>',NULL,'in','ignored','done','notifications@github.com','','','','','2026-11-12T06:58:26Z','',NULL,'','',0);
INSERT INTO "messages" VALUES(185,'<20261112070428.2f51ca2ada262c11@crm.juliangoldie.com>',NULL,'in','ignored','done','me@juliangoldie.com','','','','','2026-11-12T07:04:28Z','',NULL,'','',0);
INSERT INTO "messages" VALUES(186,'<1k7796cvqoeua802@indeed.com>',NULL,'in','ignored','done','donotreply@jobalert.indeed.com','','','','','2026-11-12T07:05:16Z','',NULL,'','',0);
INSERT INTO "messages" VALUES(187,'<1200944532.213439.1794469228961@mob-r3-l-igm-05.x.fnb.co.za>',NULL,'in','ignored','done','incontact@fnb.co.za','','','','','2026-11-12T07:40:28Z','',NULL,'','',0);
INSERT INTO "messages" VALUES(188,'<vaWSK5VFM_oeW2OllBnL_A@notifications.google.com>',NULL,'in','ignored','done','firebase-noreply@google.com','','','','','2026-11-12T07:41:02Z','',NULL,'','',0);
INSERT INTO "messages" VALUES(189,'<1688643172.3501292.1794469539420@ltx1-app51272.prod.linkedin.com>',NULL,'in','alert','done','jobalerts-noreply@linkedin.com','','Betway Global Frontend Developer and 3 other jobs you may be
 interested in','','','2026-11-12T07:45:39Z','',NULL,'','',0);
INSERT INTO "messages" VALUES(190,'<5325f3ceffdf8653227ab3250c9a05c1ab08c449-516505-100075571@google.com>',NULL,'in','ignored','done','payments-noreply@google.com','','','','','2026-11-12T07:46:03Z','',NULL,'','',0);
INSERT INTO "messages" VALUES(191,'<8a9dd299b6bda0cadf6b6f91e390f7ebb6fc12a9-20129745-110799938@google.com>',NULL,'in','ignored','done','cloudplatform-noreply@google.com','','','','','2026-11-12T07:50:18Z','',NULL,'','',0);
INSERT INTO "messages" VALUES(192,'<010001a1cec3d3fc-b5f4dbf4-e830-4ba4-af86-7060561f01ea-000000@email.amazonses.com>',NULL,'in','ignored','done','insiders@dailymaverick.co.za','','','','','2026-11-12T07:58:22Z','',NULL,'','',0);
INSERT INTO "messages" VALUES(193,'<6e3c1481bb07ba7cb94e41fd036507007c0a6c99-20391127-111823075@google.com>',NULL,'in','ignored','done','payments-noreply@google.com','','','','','2026-11-12T08:12:02Z','',NULL,'','',0);
INSERT INTO "messages" VALUES(194,'<852e7f0ebda2a4b8b93b1fec47d2aa16bc5d7ea7-20392238-337030291@google.com>',NULL,'in','ignored','done','googleaistudio-noreply@google.com','','','','','2026-11-12T08:15:43Z','',NULL,'','',0);
INSERT INTO "messages" VALUES(195,'<JiPtcw5Lyp80d_SAt1enBq4PTM9gFIBYyPpRhxXgVBxTH25RiQBUELba2UdWkg3WFguD5Hmkd7rcnZY9MQbkDPP-1g9p9lsCdRqYy0Il6PbVihmRiWyanRHn1tdq12SBXCyZAAECAA==@t1.msgid.quoramail.com>',NULL,'in','ignored','done','english-quora-digest@quora.com','','','','','2026-11-12T08:16:13Z','',NULL,'','',0);
INSERT INTO "messages" VALUES(196,'<codecrafters-io/build-your-own-x/pull/2003/c6818176659@github.com>',NULL,'in','ignored','done','notifications@github.com','','','','','2026-11-12T08:16:33Z','',NULL,'','',0);
INSERT INTO "messages" VALUES(197,'<4f4044138c0f00b3dc173cd76ee3b582e4ebcd17-541308-100150090@google.com>',NULL,'in','ignored','done','payments-noreply@google.com','','','','','2026-11-12T08:17:13Z','',NULL,'','',0);
INSERT INTO "messages" VALUES(198,'<179447245817.79.11368283267207636444@gmail.com>',NULL,'out','ignored','done','chirombokenny@gmail.com','','','','','2026-11-12T08:34:19Z','',NULL,'','',0);
INSERT INTO "messages" VALUES(199,'<codecrafters-io/build-your-own-x/pull/2003/c6818619238@github.com>',NULL,'in','ignored','done','notifications@github.com','','','','','2026-11-12T08:46:09Z','',NULL,'','',0);
INSERT INTO "messages" VALUES(200,'<codecrafters-io/build-your-own-x/pull/2003/c6818630792@github.com>',NULL,'in','ignored','done','notifications@github.com','','','','','2026-11-12T08:46:21Z','',NULL,'','',0);
INSERT INTO "messages" VALUES(201,'<wwYojATaHGITSLiIuizyXrbzwMRvtAcFKUUi@notify.cloudflare.com>',NULL,'in','ignored','done','noreply@notify.cloudflare.com','','','','','2026-11-12T08:51:13Z','',NULL,'','',0);
INSERT INTO "messages" VALUES(202,'<CmzwXWEJ3EUqJ4Dzdjz0nxNHPyfxTR4pvkUn@notify.cloudflare.com>',NULL,'in','ignored','done','noreply@notify.cloudflare.com','','','','','2026-11-12T08:51:43Z','',NULL,'','',0);
INSERT INTO "messages" VALUES(203,'<fnEU2efRRqyugs2dbqCmWQ@geopod-ismtpd-39>',NULL,'in','ignored','done','noreply@techexpress.co.za','','','','','2026-11-12T08:59:33Z','',NULL,'','',0);
INSERT INTO "messages" VALUES(204,'<db4edde4-40e5-34e6-b8f1-9fc1b6b4815d@a.europe.nflshop.com>',NULL,'in','ignored','done','nflshop@a.europe.nflshop.com','','','','','2026-11-12T09:00:55Z','',NULL,'','',0);
INSERT INTO "messages" VALUES(205,'<010001a1cf02d941-ccbc1734-b119-4b4a-8c08-94804007df0c-000000@email.amazonses.com>',NULL,'in','ignored','done','send@sterkinekor.com','','','','','2026-11-12T09:07:12Z','',NULL,'','',0);
INSERT INTO "messages" VALUES(206,'<1381656751.255120.1794476133036@mob-r3-l-igm-06.x.fnb.co.za>',NULL,'in','ignored','done','incontact@fnb.co.za','','','','','2026-11-12T09:35:33Z','',NULL,'','',0);
INSERT INTO "messages" VALUES(207,'<1715218636.3837461.1794476738045@ltx1-app113011.prod.linkedin.com>',NULL,'in','alert','done','jobalerts-noreply@linkedin.com','','Junior Web Developer role paying up to $1.8K/month','','','2026-11-12T09:45:38Z','',NULL,'','',0);
INSERT INTO "messages" VALUES(208,'<codecrafters-io/build-your-own-x/pull/2043/review/5872226268@github.com>',NULL,'in','ignored','done','notifications@github.com','','','','','2026-11-12T09:55:44Z','',NULL,'','',0);
INSERT INTO "messages" VALUES(209,'<20261112104813.47ed661ba13d2f7c@em.onedayonly.co.za>',NULL,'in','ignored','done','newsletter@em.onedayonly.co.za','','','','','2026-11-12T10:48:13Z','',NULL,'','',0);
INSERT INTO "messages" VALUES(210,'<1739667611.4154203.1794482365556@ltx1-app94768.prod.linkedin.com>',NULL,'in','ignored','done','jobs-noreply@linkedin.com','','','','','2026-11-12T11:19:25Z','',NULL,'','',0);
INSERT INTO "messages" VALUES(211,'<1801417417.8401751.1794483938193@lva2-app63400.prod.linkedin.com>',NULL,'in','reply','review','inmail-hit-reply@linkedin.com','','Hiring Python Developer for a client in Cape Town','Hiring Python Developer for a client in Cape Town
Hiring Python Developer for a client in Cape Town

        Veeresh Talanki

        Reply
        https://www.linkedin.com/messaging/thread/2-MWQwM2UwMGUtYjViNi00YjYxLWI1YTktNWQzZWYwMjllMTQ0XzEwMA==/

Good Day !

I am Veeresh - Associate Manager - Zensar Technologies, South Africa.

We are hiring Python Developer  for a client in Cape Town. Please let me know if interested

Job Spec as below
Job Purpose

The role of the Python developer of Reports and Interfaces is to

Create files with reports based on data from an Oracle DB or other data source
Create Interfaces that will transform incoming files from any format into xml compatible with Way4.
Job Accountabilities

Develop python applications for transformation CSV/JSON/XML files into CSV/JSON/XML/XLSX/PPTX/PDF according to the requirements from BA.
Prepare delivery for deployment.
Deployment to the regions.
Clarification and support testers.
Analysis and fixing defects.
Experience/ Skills Required

Mandatory requirements:

Good English speaking and writing skills.
Python 3.xx:
Knowledge of Python’s types (int/str/list/set/dict and etc) and manipulation with each of them
Loops, array comprehension
Standard Python functionality + standard modules for working with files/streams
ANSI SQL: selection, joining, updating
MS Office: excel, word, outlook
Windows: command line: dir/cd/md/rd/del/copy/xcopy/type and etc, bat language
Linux: command line: ls/find/sudo/cat and etc, gnu utilities: curl/grep/awk/sed and etc, bash/shell language
CSV, JSON, XML, XSD, XPATH.
Optional requirements:

Big plus: Have an own account at https://py.checkio.org/ with minimum 30 points in array HOME (skip points in ELEMENTARY array).
Talend– will be not used, but good to know how it works
Python 3.xx: pandas, numpy, jinja2, requests
PyCharm
Scrum Framework from Developer’s perspective
SDLC (Software Development Life Cycle)
PL/SQL + hints
VBA for MS Excel
PowerPoint
GIT + SourceTree + Bitbucket: clone, pull, commit, push, merge, conflicts resolving
JIRA/Confluence: creating/updating, searching
Bamboo
Far Manager
Notepad++
RDP

Best Regards
Veeresh Talanki
Assistant Manager - Talent Acquisition
South Africa

    

----------------------------------------

This email was intended for Kenny Chirombo (Full Stack JavaScript Engineer | Multi Cloud | Systems and IoT Architect | I Build Software the Way I Live. I’m a gamer and one day I’ll build my own GTA You can’t tell me otherwise)
Learn why we included this: https://www.linkedin.com/help/linkedin/answer/4788?lang=en&lipi=urn%3Ali%3Apage%3Aemail_email_hire_inmail_initial_single_01%3BuYJt9OeQSmy%2BOpeJoF4b2Q%3D%3D&midToken=AQFy004RwMkY-Q&midSig=374kQQdfNxncw1&trk=eml-email_hire_inmail_initial_single_01-SecurityHelp-0-textfooterglimmer&trkEmail=eml-email_hire_inmail_initial_single_01-SecurityHelp-0-textfooterglimmer-null-41naie~mwdheivv~3i-null-null&eid=41naie-mwdheivv-3i
You are receiving LinkedIn notification emails.


Unsubscribe: https://www.linkedin.com/comm/mypreferences/u/emailunsub?action=updateEmailSubscription&lipi=urn%3Ali%3Apage%3Aemail_email_hire_inmail_initial_single_01%3BuYJt9OeQSmy%2BOpeJoF4b2Q%3D%3D&midToken=AQFy004RwMkY-Q&midSig=374kQQdfNxncw1&trk=eml-email_hire_inmail_initial_single_01-unsubscribe-0-textfooterglimmer&trkEmail=eml-email_hire_inmail_initial_single_01-unsubscribe-0-textfooterglimmer-null-41naie~mwdheivv~3i-null-null&eid=41naie-mwdheivv-3i&loid=AQF56d-Q036U-wAAAaHPk-KOsgi6nDn4dlL6H6WHm-lHABwTkXoTVK3-5TOlbAt6E2tRIBCaX1IU8rHXxBMg5lNL8rT3k9JtSCJkCw
Help: https://www.linkedin.com/help/linkedin/answer/67?lang=en&lipi=urn%3Ali%3Apage%3Aemail_email_hire_inmail_initial_single_01%3BuYJt9OeQSmy%2BOpeJoF4b2Q%3D%3D&midToken=AQFy004RwMkY-Q&midSig=374kQQdfNxncw1&trk=eml-email_hire_inmail_initial_single_01-help-0-textfooterglimmer&trkEmail=eml-email_hire_inmail_initial_single_01-help-0-textfooterglimmer-null-41naie~mwdheivv~3i-null-null&eid=41naie-mwdheivv-3i

© 2026 LinkedIn Corporation, 1zwnj000 West Maude Avenue, Sunnyvale, CA 94085.
LinkedIn and the LinkedIn logo are registered trademarks of LinkedIn.','','2026-11-12T11:45:38Z','other',0.95,'A recruiter from Zensar Technologies reached out via LinkedIn regarding a Python Developer position in Cape Town.','Reply to the recruiter on LinkedIn if interested in the position.',0);
INSERT INTO "messages" VALUES(212,'<179448556696.113.8378480044389952526@gmail.com>',NULL,'out','ignored','done','chirombokenny@gmail.com','','','','','2026-11-12T12:12:48Z','',NULL,'','',0);
INSERT INTO "messages" VALUES(213,'<N6L9U161nSovlvOTQfT4k6469M6QydRo3XN5@notify.cloudflare.com>',NULL,'in','ignored','done','noreply@notify.cloudflare.com','','','','','2026-11-12T12:18:28Z','',NULL,'','',0);
INSERT INTO "messages" VALUES(214,'<D4BaEpPx0HZB63DMeflEYH1BFX7XXFqScfFq@notify.cloudflare.com>',NULL,'in','ignored','done','noreply@notify.cloudflare.com','','','','','2026-11-12T12:19:06Z','',NULL,'','',0);
INSERT INTO "messages" VALUES(215,'<1k77rqoq3k59j806@indeed.com>',NULL,'in','ignored','done','donotreply@jobalert.indeed.com','','','','','2026-11-12T12:30:57Z','',NULL,'','',0);
INSERT INTO "messages" VALUES(216,'<1k77s8s74io7d801@indeed.com>',NULL,'in','ignored','done','donotreply@match.indeed.com','','','','','2026-11-12T12:38:40Z','',NULL,'','',0);
INSERT INTO "messages" VALUES(217,'<d0u7prkrmxc0hkzl8q9amhzzm6e6galhopg8q@kit-mail3.com>',NULL,'in','ignored','done','pat@patdamiano.com','','','','','2026-11-12T12:45:31Z','',NULL,'','',0);
INSERT INTO "messages" VALUES(218,'<R121zx79RumbgSz51RufCw@geopod-ismtpd-9>',NULL,'in','ignored','done','noreply@skool.com','','','','','2026-11-12T13:08:34Z','',NULL,'','',0);
INSERT INTO "messages" VALUES(219,'<b3e76cec1956feaf5bc4ca16b6628756d94d92bd5c7d934eaf89cbf35028f939@dineplan.com>',NULL,'in','ignored','done','hello@dineplan.com','','','','','2026-11-12T13:21:48Z','',NULL,'','',0);
INSERT INTO "messages" VALUES(220,'<43109ee0eaf018c2e15518243.e8210e1244.20261112133349.0c65cc8780.5eac84ae@mail212.suw241.rsgsv.net>',NULL,'in','ignored','done','noreply@flysafairmail.co.za','','','','','2026-11-12T13:35:47Z','',NULL,'','',0);
INSERT INTO "messages" VALUES(221,'<1419971150.4664613.1794491139142@ltx1-app37022.prod.linkedin.com>',NULL,'in','alert','done','jobalerts-noreply@linkedin.com','','Software Engineer, AI Integrations at Jobgether','','','2026-11-12T13:45:39Z','',NULL,'','',0);
INSERT INTO "messages" VALUES(222,'<52eb745e55409323b4e9f68ed.e8bce18f74.20261112140208.9e84c9e7b3.10d4e587@mail129.wdc02.mcdlv.net>',NULL,'in','ignored','done','sales@brisco.co.za','','','','','2026-11-12T14:02:40Z','',NULL,'','',0);
INSERT INTO "messages" VALUES(223,'<codecrafters-io/build-your-own-x/pull/2098/c6825522425@github.com>',NULL,'in','ignored','done','notifications@github.com','','','','','2026-11-12T14:07:19Z','',NULL,'','',0);
INSERT INTO "messages" VALUES(224,'<codecrafters-io/build-your-own-x/pull/2099/c6825522831@github.com>',NULL,'in','ignored','done','notifications@github.com','','','','','2026-11-12T14:08:42Z','',NULL,'','',0);
INSERT INTO "messages" VALUES(225,'<codecrafters-io/build-your-own-x/pull/2097/c6825521971@github.com>',NULL,'in','ignored','done','notifications@github.com','','','','','2026-11-12T14:09:04Z','',NULL,'','',0);
INSERT INTO "messages" VALUES(226,'<010f01a1d01a33f2-2dc875ab-c0a0-4f9f-bc03-0ae0a38f46b9-000000@us-east-2.amazonses.com>',NULL,'in','ignored','done','news@alphasignal.ai','','','','','2026-11-12T14:12:20Z','',NULL,'','',0);
INSERT INTO "messages" VALUES(227,'<010001a1d01b5337-b89ff45e-f4dc-4bcb-b937-acf686f6400b-000000@email.amazonses.com>',NULL,'in','ignored','done','noreply@newsletter.journalclub.io','','','','','2026-11-12T14:13:34Z','',NULL,'','',0);
INSERT INTO "messages" VALUES(228,'<20261112141952.e23d48ff3a1498d3@crm.juliangoldie.com>',NULL,'in','ignored','done','me@juliangoldie.com','','','','','2026-11-12T14:19:52Z','',NULL,'','',0);
INSERT INTO "messages" VALUES(229,'<coCBs_cxRwWISc2ruDd05A@geopod-ismtpd-71>',NULL,'in','ignored','done','steve@joburg.co.za','','','','','2026-11-12T14:53:18Z','',NULL,'','',0);
INSERT INTO "messages" VALUES(230,'<20261112150324.3.9a9488210ab87bca@mg-d0.substack.com>',NULL,'in','ignored','done','behavioralosfortechies@substack.com','','','','','2026-11-12T15:03:24Z','',NULL,'','',0);
INSERT INTO "messages" VALUES(231,'<010001a1d04a60f5-15ab8c4c-ce76-4a51-9e28-db56c5c0abcb-000000@email.amazonses.com>',NULL,'in','ignored','done','login@us.greenhouse-jobs.com','','','','','2026-11-12T15:04:57Z','',NULL,'','',0);
INSERT INTO "messages" VALUES(232,'<xCIFGAg_S-W2B32j4K_JzQ@geopod-ismtpd-26>',NULL,'in','ignored','done','noreply@skool.com','','','','','2026-11-12T15:05:12Z','',NULL,'','',0);
INSERT INTO "messages" VALUES(233,'<1886560499.20664024.1794496003883@mob-r1-l-igm-04.x.fnb.co.za>',NULL,'in','ignored','done','incontact@fnb.co.za','','','','','2026-11-12T15:06:43Z','',NULL,'','',0);
INSERT INTO "messages" VALUES(234,'<pcW9S7dxRAe5TTiZ3NbmsA@geopod-ismtpd-41>',NULL,'in','ignored','done','noreply@medium.com','','','','','2026-11-12T15:15:22Z','',NULL,'','',0);
INSERT INTO "messages" VALUES(235,'<959123082.5344320.1794498338502@ltx1-app82780.prod.linkedin.com>',NULL,'in','alert','done','jobalerts-noreply@linkedin.com','','Betway Global is hiring a Frontend Developer','','','2026-11-12T15:45:38Z','',NULL,'','',0);
INSERT INTO "messages" VALUES(236,'<7WIL.32WUF.9209FB3FBB3F4D684MWJ9D61065065C12D5D1B.2c02fd8a-8a9a-49b4-bdfc-b5a8dd61a397@info.sarugby.co.za>',NULL,'in','ignored','done','noreply@info.sarugby.co.za','','','','','2026-11-12T16:31:18Z','',NULL,'','',0);
INSERT INTO "messages" VALUES(237,'<ff08e4b91b782efe466b56b634653e1fe7647b36-20419424-111923721@google.com>',NULL,'in','ignored','done','googleaistudio-noreply@google.com','','','','','2026-11-12T16:43:08Z','',NULL,'','',0);
INSERT INTO "messages" VALUES(238,'<b2e39921-e4e6-3011-9ee6-1643a8e7439f@service.paypal.com>',NULL,'in','ignored','done','noreply@service.paypal.com','','','','','2026-11-12T17:04:01Z','',NULL,'','',0);
INSERT INTO "messages" VALUES(239,'<422224843.10137520.1794505539731@lor1-app101427.prod.linkedin.com>',NULL,'in','ignored','done','messages-noreply@linkedin.com','','','','','2026-11-12T17:45:39Z','',NULL,'','',0);
INSERT INTO "messages" VALUES(240,'<735100698.1687909.1794506148991@service-v2-7ff7944b8d-cjs4q>',NULL,'in','ignored','done','imangadzhi@consulting.com','','','','','2026-11-12T17:55:48Z','',NULL,'','',0);
INSERT INTO "messages" VALUES(241,'<926440318.10168664.1794506259858@lva2-app65887.prod.linkedin.com>',NULL,'in','ignored','done','messages-noreply@linkedin.com','','','','','2026-11-12T17:57:39Z','',NULL,'','',0);
INSERT INTO "messages" VALUES(242,'<ChiromboKenT/JobCopilot/pull/1/c6832460673@github.com>',NULL,'in','ignored','done','notifications@github.com','','','','','2026-11-12T18:33:58Z','',NULL,'','',0);
INSERT INTO "messages" VALUES(243,'<XZUj7FezpabA4I8E8xABgQxDNvbT6rjV1CDX@notify.cloudflare.com>',NULL,'in','ignored','done','noreply@notify.cloudflare.com','','','','','2026-11-12T19:12:32Z','',NULL,'','',0);
INSERT INTO "messages" VALUES(244,'<63Ktr7P8ojZ5OlGJNMvcQwLgavQqGuscx5HB@notify.cloudflare.com>',NULL,'in','ignored','done','noreply@notify.cloudflare.com','','','','','2026-11-12T21:24:33Z','',NULL,'','',0);
INSERT INTO "messages" VALUES(245,'<jUlLhDpmRBLRQht1XKGEWb9gAglQK7IBk0EDKLiNYpgYwtn419iv0NWObQRJ8iMGWldhMuc-b1NvCRgk8KuXHXY1_lBkuHZuFYFN3A1RyibWBZC2ELyOEummMx_y8HBDLNgfAAECAA==@t1.msgid.quoramail.com>',NULL,'in','ignored','done','english-quora-digest@quora.com','','','','','2026-11-12T22:11:49Z','',NULL,'','',0);
INSERT INTO "messages" VALUES(246,'<1k78ujbli2ghc007@indeed.com>',NULL,'in','ignored','done','donotreply@jobalert.indeed.com','','','','','2026-11-12T22:38:35Z','',NULL,'','',0);
INSERT INTO "messages" VALUES(247,'<6af640a41072b_153121094310@sharedworker-d9c99ccfb-t2h28.mail>',NULL,'in','ignored','done','noreply@github.com','','','','','2026-11-12T22:41:40Z','',NULL,'','',0);
INSERT INTO "messages" VALUES(248,'<20261112230402.aab0dc7cfa4d5a7b@cio8.devpost.com>',NULL,'in','ignored','done','darlyze@devpost.com','','','','','2026-11-12T23:04:02Z','',NULL,'','',0);
INSERT INTO "messages" VALUES(249,'<6af649468c1f3_d612101135c3@sharedworker-d9c99ccfb-pl9zx.mail>',NULL,'in','ignored','done','noreply@github.com','','','','','2026-11-12T23:18:30Z','',NULL,'','',0);
INSERT INTO "messages" VALUES(250,'<20261113000024.0d45775c59dd14d9@crm.juliangoldie.com>',NULL,'in','ignored','done','me@juliangoldie.com','','','','','2026-11-13T00:00:24Z','',NULL,'','',0);
INSERT INTO "messages" VALUES(251,'<ChiromboKenT/vken-design-engine/check-suites/CS_kwDOSXOco88AAAAbUyMTJQ/1794531196@github.com>',NULL,'in','ignored','done','notifications@github.com','','','','','2026-11-13T00:53:36Z','',NULL,'','',0);
INSERT INTO "messages" VALUES(252,'<ChiromboKenT/vken-design-engine/check-suites/CS_kwDOSXOco88AAAAbU8rgXw/1794532194@github.com>',NULL,'in','ignored','done','notifications@github.com','','','','','2026-11-13T01:10:14Z','',NULL,'','',0);
INSERT INTO "messages" VALUES(253,'<20261113011956.f4bfb87a7d84491c@crm.juliangoldie.com>',NULL,'in','ignored','done','me@juliangoldie.com','','','','','2026-11-13T01:19:56Z','',NULL,'','',0);
INSERT INTO "messages" VALUES(254,'<codecrafters-io/build-your-own-x/issues/2101@github.com>',NULL,'in','ignored','done','notifications@github.com','','','','','2026-11-13T02:36:49Z','',NULL,'','',0);
INSERT INTO "messages" VALUES(255,'<20261113030437.9596a3a78378e9d9@em.onedayonly.co.za>',NULL,'in','ignored','done','newsletter@em.onedayonly.co.za','','','','','2026-11-13T03:04:37Z','',NULL,'','',0);
INSERT INTO "messages" VALUES(256,'<58.BB.22795.FEF76FA6@i-0b79ca83edd840b20.mta3vrest.sd.prd.sparkpost>',NULL,'in','ignored','done','info@jobalerts.pnet.co.za','','','','','2026-11-13T03:11:43Z','',NULL,'','',0);
INSERT INTO "messages" VALUES(257,'<EF.25.00719.16686FA6@i-0f652b6bbdbb08330.mta3vrest.sd.prd.sparkpost>',NULL,'in','ignored','done','email@newsroom.news24.com','','','','','2026-11-13T03:39:13Z','',NULL,'','',0);
INSERT INTO "messages" VALUES(258,'<0MeCdC3YQO-inzi47B25-Q@geopod-ismtpd-14>',NULL,'in','ignored','done','csunderarmour@apollobrands.co.za','','','','','2026-11-13T04:01:17Z','',NULL,'','',0);
INSERT INTO "messages" VALUES(259,'<010001a1d33c27a2-a892eaa6-6082-4d4a-b520-161186d2066c-000000@email.amazonses.com>',NULL,'in','ignored','done','hello@ollama.com','','','','','2026-11-13T04:48:17Z','',NULL,'','',0);
INSERT INTO "messages" VALUES(260,'<rxJLJSD0RYqVBvQilIHGUA@geopod-ismtpd-24>',NULL,'in','ignored','done','noreply@skool.com','','','','','2026-11-13T04:50:40Z','',NULL,'','',0);
INSERT INTO "messages" VALUES(261,'<20261113050050.617b1c9ed7dbaa17@luvland.co.za>',NULL,'in','ignored','done','no-reply@luvland.co.za','','','','','2026-11-13T05:00:50Z','',NULL,'','',0);
INSERT INTO "messages" VALUES(262,'<Y4px3ZVsTUmzXcrPqY1hWQ@geopod-ismtpd-46>',NULL,'in','ignored','done','noreply@medium.com','','','','','2026-11-13T05:10:00Z','',NULL,'','',0);
INSERT INTO "messages" VALUES(263,'<B6.31.28484.20C96FA6@i-07f3594aa66d93530.mta3vrest.sd.prd.sparkpost>',NULL,'in','ignored','done','subs@marketing.news24.com','','','','','2026-11-13T05:11:30Z','',NULL,'','',0);
INSERT INTO "messages" VALUES(264,'<67827ff5-5445-405a-8a25-3f49df6eb39b@cdg3s51mta0442.xt.local>',NULL,'in','ignored','done','deals@marketing.makro.co.za','','','','','2026-11-13T05:35:38Z','',NULL,'','',0);
INSERT INTO "messages" VALUES(265,'<bbd4df58-919d-46ac-ae7a-d493d18f90f6@az.northcentralus.microsoft.com>',NULL,'in','ignored','done','microsoft-noreply@microsoft.com','','','','','2026-11-13T06:09:02Z','',NULL,'','',0);
INSERT INTO "messages" VALUES(266,'<pE8xQ8bMTziLiMhYFz8xOg@geopod-ismtpd-10>',NULL,'in','ignored','done','info@bashafrica.com','','','','','2026-11-13T06:30:15Z','',NULL,'','',0);
INSERT INTO "messages" VALUES(267,'<8f24e7fd-c75c-4830-a62b-1b5570892bf7@fra3s50mta0051.xt.local>',NULL,'in','ignored','done','noreply-information@standardbank.co.za','','','','','2026-11-13T06:37:01Z','',NULL,'','',0);
INSERT INTO "messages" VALUES(268,'<MmDqxPbyRE-wz80Fb_eNTA@geopod-ismtpd-14>',NULL,'in','ignored','done','hello@mail.checkers.co.za','','','','','2026-11-13T07:02:56Z','',NULL,'','',0);
INSERT INTO "messages" VALUES(269,'<1k79s5esvg1rj801@indeed.com>',NULL,'in','ignored','done','donotreply@jobalert.indeed.com','','','','','2026-11-13T07:15:17Z','',NULL,'','',0);
INSERT INTO "messages" VALUES(270,'<1842139370.8870323.1794555938717@ltx1-app24708.prod.linkedin.com>',NULL,'in','alert','done','jobalerts-noreply@linkedin.com','','Virtustant is hiring a Software Developer – Remote Staffing','','','2026-11-13T07:45:38Z','',NULL,'','',0);
INSERT INTO "messages" VALUES(271,'<be3786d420d977c08ed6506b0366ee197effd580-20398624-337030291@google.com>',NULL,'in','ignored','done','noreply-phone-verification@google.com','','','','','2026-11-13T07:54:06Z','',NULL,'','',0);
INSERT INTO "messages" VALUES(272,'<E9.DB.14578.CF2C6FA6@i-0193f0517f454ad98.mta3vrest.sd.prd.sparkpost>',NULL,'in','ignored','done','deals@newsletters.takealot.com','','','','','2026-11-13T07:57:48Z','',NULL,'','',0);
INSERT INTO "messages" VALUES(273,'<084a3faf-fab4-4a77-b60e-29529249203f@mtasv.net>',NULL,'in','ignored','done','auctions@oldjwauctioneers.com','','','','','2026-11-13T08:05:11Z','',NULL,'','',0);
INSERT INTO "messages" VALUES(274,'<JnTWceEGKZezZ3zfAp4vwTrFbl8sm6nNgRPnkBRjQZV9zynvI-hN4S08mWfLLKROCsUIkMg6GDuSqWU0f4YPxjyVmF0jB6icaltRtdYZCplqamtPaxiKTsIv-YT7ahMpOBe9AAECAA==@t1.msgid.quoramail.com>',NULL,'in','ignored','done','english-quora-digest@quora.com','','','','','2026-11-13T08:12:35Z','',NULL,'','',0);
INSERT INTO "messages" VALUES(275,'<DreamverseHoldings/aidlink/pull/133/c6847817156@github.com>',NULL,'in','ignored','done','notifications@github.com','','','','','2026-11-13T08:19:49Z','',NULL,'','',0);
INSERT INTO "messages" VALUES(276,'<DreamverseHoldings/aidlink/pull/133/c6847819029@github.com>',NULL,'in','ignored','done','notifications@github.com','','','','','2026-11-13T08:19:52Z','',NULL,'','',0);
INSERT INTO "messages" VALUES(277,'<DreamverseHoldings/aidlink/pull/133/review/5888079591@github.com>',NULL,'in','ignored','done','notifications@github.com','','','','','2026-11-13T08:22:07Z','',NULL,'','',0);
INSERT INTO "messages" VALUES(278,'<5BZH.1I6IW.8452AF7408A451945LAM1JD679DEF34AD02EA3.982d133e-e23d-4a6c-b4f2-2ec4eb7a9b4f@mailer.mrphome.com>',NULL,'in','ignored','done','home@mailer.mrphome.com','','','','','2026-11-13T08:31:57Z','',NULL,'','',0);
INSERT INTO "messages" VALUES(279,'<b3253d502fe7d84298197c561.3939f97812.20261113084231.a4cf12875d.7b7de9d5@mail179.atl221.rsgsv.net>',NULL,'in','ignored','done','newsletter@joburg.vip','','','','','2026-11-13T08:42:53Z','',NULL,'','',0);
INSERT INTO "messages" VALUES(280,'<EeOnQHELgj50oL9V1Qqfp2f184vuHLJXHfsl@notify.cloudflare.com>',NULL,'in','ignored','done','noreply@notify.cloudflare.com','','','','','2026-11-13T08:53:00Z','',NULL,'','',0);
INSERT INTO "messages" VALUES(281,'<9d8d1319-302d-3454-abd4-953a400f4107@a.europe.nflshop.com>',NULL,'in','ignored','done','nflshop@a.europe.nflshop.com','','','','','2026-11-13T09:01:44Z','',NULL,'','',0);
INSERT INTO "messages" VALUES(282,'<8E.18.37553.708D6FA6@i-0a06df6a8c8da5ab7.mta3vrest.sd.prd.sparkpost>',NULL,'in','ignored','done','deals@newsletters.takealot.com','','','','','2026-11-13T09:27:35Z','',NULL,'','',0);
INSERT INTO "messages" VALUES(283,'<cm.2031544094949.viryulk.wkhjjhtiy.i@cmail19.com>',NULL,'in','ignored','done','noreply@parkrun.com','','','','','2026-11-13T09:31:54Z','',NULL,'','',0);
INSERT INTO "messages" VALUES(284,'<1583927965.797968.1794563138583@ltx1-app61588.prod.linkedin.com>',NULL,'in','alert','done','jobalerts-noreply@linkedin.com','','Jobgether Full Stack Software Engineer - AI-First','','','2026-11-13T09:45:38Z','',NULL,'','',0);
INSERT INTO "messages" VALUES(285,'<0e4ba6c3.CAAACcql1asAAAAyeMAAANemxfgAAAACJG8ABGR8ACigVQBq9txj@mailjet.com>',NULL,'in','ignored','done','info@mail.incredible.co.za','','','','','2026-11-13T09:46:11Z','',NULL,'','',0);
INSERT INTO "messages" VALUES(286,'<CANwOQ0c_yZXQ2MjX_pcpoXFrAikixxZcGAj2jHYUj=nkCBXc5A@mail.gmail.com>',NULL,'out','ignored','done','chirombokenny@gmail.com','','','','','2026-11-13T09:52:18Z','',NULL,'','',0);
INSERT INTO "messages" VALUES(287,'<CANwOQ0e114ehU3tQcSBAY5UWFvvaao=grxZ=NDbnzix=hfNx4g@mail.gmail.com>',4,'in','reply','done','kenmbi290@gmail.com','','Application','Thank you. We have received your application.
','','2026-11-13T09:57:29Z','acknowledgement',0.8,'Confirmation that an application has been received.','',0);
INSERT INTO "messages" VALUES(288,'<1683633156.150494.1794564060462@marketo-platform--email-sender-prod-batch-cluster-6fbf4d48mdwrl>',NULL,'in','ignored','done','ibm@email.ibm.com','','','','','2026-11-13T10:01:00Z','',NULL,'','',0);
INSERT INTO "messages" VALUES(289,'<1a387e25e8af204d6d158f757.1f0aad597b.20261113100755.74b655313e.ae85c08d@mail177.atl61.mcsv.net>',NULL,'in','ignored','done','karabo@outsized.com','','','','','2026-11-13T10:08:14Z','',NULL,'','',0);
INSERT INTO "messages" VALUES(290,'<20261113101949.a0c97dbb4a3eb171@crm.juliangoldie.com>',NULL,'in','ignored','done','me@juliangoldie.com','','','','','2026-11-13T10:19:49Z','',NULL,'','',0);
INSERT INTO "messages" VALUES(291,'<179456519681.1.14401659565971744627@gmail.com>',NULL,'out','ignored','done','chirombokenny@gmail.com','','','','','2026-11-13T10:19:58Z','',NULL,'','',0);
INSERT INTO "messages" VALUES(292,'<20261113104735.87e1cceb13d1cbe0@em.onedayonly.co.za>',NULL,'in','ignored','done','newsletter@em.onedayonly.co.za','','','','','2026-11-13T10:47:35Z','',NULL,'','',0);
INSERT INTO "messages" VALUES(293,'<CANwOQ0fzeG_iFBgp5VrNqUvYAhpjJU-EUAzrdEBg7ZzZgOuFhA@mail.gmail.com>',4,'in','reply','done','kenmbi290@gmail.com','','Application Response','  Please send a copy of your ID and your salary expectation by Friday.
','','2026-11-13T10:51:03Z','info_request',0.9,'The sender is requesting a copy of your ID and salary expectations by Friday regarding your application.','Send a copy of your ID and your salary expectation by Friday.',0);
INSERT INTO "messages" VALUES(294,'<21339dcb.CAAACcrTGjAAAAAyeMIAANemxfgAAAACJG8ABGR8ACigVQBq9u76@mailjet.com>',NULL,'in','ignored','done','info@mail.incredible.co.za','','','','','2026-11-13T11:05:30Z','',NULL,'','',0);
INSERT INTO "messages" VALUES(295,'<20261113.111130.eb38b679@mta12>',NULL,'in','ignored','done','juries-newsletter@mail.beehiiv.com','','','','','2026-11-13T11:11:30Z','',NULL,'','',0);
INSERT INTO "messages" VALUES(296,'<CAD5JBR0YEeXpcFr3fh26H7odHVYvsXpXGMV5RVA1+0e=UHBCpA@mail.gmail.com>',4,'out','sent','done','chirombokenny@gmail.com','','Re: Application Response','Hi,

Please find attached a copy of my ID. My salary expectation is [SALARY
EXPECTATION].

Regards,
Kenny

On Fri, 13 Nov 2026 at 12:51, Kenny Chirombo <kenmbi290@gmail.com> wrote:

>   Please send a copy of your ID and your salary expectation by Friday.
>
','<CANwOQ0fzeG_iFBgp5VrNqUvYAhpjJU-EUAzrdEBg7ZzZgOuFhA@mail.gmail.com> <CANwOQ0fzeG_iFBgp5VrNqUvYAhpjJU-EUAzrdEBg7ZzZgOuFhA@mail.gmail.com>','2026-11-13T11:21:58Z','',NULL,'','',0);
INSERT INTO "messages" VALUES(297,'<CANwOQ0fayzuj6eVgQfEy5w6S5gkuSrDos5ELtc5-f2_uh2MhSg@mail.gmail.com>',4,'in','reply','done','kenmbi290@gmail.com','','Assessment','  Please complete this technical assessment within 3 days.
','','2026-11-13T11:40:19Z','assessment',0.9,'You have received a request to complete a technical assessment within 3 days.','Complete the technical assessment within 3 days.',0);
INSERT INTO "messages" VALUES(298,'<1713970008.9618615.1794570338730@ltx1-app95106.prod.linkedin.com>',NULL,'in','alert','done','jobalerts-noreply@linkedin.com','','Jobgether is hiring a Full Stack Software Engineer - AI-First','','','2026-11-13T11:45:38Z','',NULL,'','',0);
INSERT INTO "messages" VALUES(299,'<E6.8F.27835.9C8F6FA6@i-0ac12410f251e75d8.mta3vrest.sd.prd.sparkpost>',NULL,'in','ignored','done','deals@newsletters.takealot.com','','','','','2026-11-13T11:47:21Z','',NULL,'','',0);
INSERT INTO "messages" VALUES(300,'<CANwOQ0cRhmh=VV-ptGusM0DH82BX+3yi8+i-UroyRwo38-eRhQ@mail.gmail.com>',4,'in','reply','done','kenmbi290@gmail.com','','Any','  We would like to interview you on Tuesday at 10:00.
','','2026-11-13T11:49:33Z','interview',0.85,'The sender is inviting you to an interview on Tuesday at 10:00.','Respond to confirm or reschedule the interview for Tuesday at 10:00.',0);
INSERT INTO "messages" VALUES(301,'<codecrafters-io/build-your-own-x/pull/2102@github.com>',NULL,'in','ignored','done','notifications@github.com','','','','','2026-11-13T11:50:37Z','',NULL,'','',0);
INSERT INTO "messages" VALUES(302,'<CANwOQ0cxKpd7D7nHkuOzPu2WgHKFGeWB2cU=aBAL+riHPehFcg@mail.gmail.com>',4,'in','reply','done','kenmbi290@gmail.com','','Apply','  Thank you for applying. We have received your application.
','','2026-11-13T11:59:41Z','acknowledgement',0.9,'The sender confirms receipt of your job application.','',0);
INSERT INTO "messages" VALUES(303,'<CANwOQ0dgGy5j16uMnHiuY7FNjYJVhgTS+a_YH0NVvuyyVwBATA@mail.gmail.com>',4,'in','reply','done','kenmbi290@gmail.com','','Offer','  We are pleased to offer you the position.
','','2026-11-13T12:06:07Z','offer',0.85,'The sender has extended a job offer for a position.','',0);
INSERT INTO "messages" VALUES(304,'<b3e2081c-0285-4b20-84ce-262a6c7423a4@cdg3s51mta0448.xt.local>',NULL,'in','ignored','done','deals@marketing.makro.co.za','','','','','2026-11-13T11:43:59Z','',NULL,'','',0);
INSERT INTO "messages" VALUES(305,'<CANwOQ0dyXsb6Tz72tdwGLWYHiWZv7q-WbhB4dkCfagUo02jZ1Q@mail.gmail.com>',4,'in','reply','done','kenmbi290@gmail.com','','Application Rejected','  Unfortunately we will not be taking your application further.
','','2026-11-13T12:13:57Z','rejection',0.9,'The sender informed the applicant that their application will not be moving forward.','',0);
INSERT INTO "messages" VALUES(306,'<1k7adeudpkft3803@indeed.com>',NULL,'in','ignored','done','donotreply@jobalert.indeed.com','','','','','2026-11-13T12:17:33Z','',NULL,'','',0);
INSERT INTO "messages" VALUES(307,'<uid-169704@jobpilot.local>',NULL,'in','ignored','done','','','','','','1899-12-31T22:30:00Z','',NULL,'','',0);
INSERT INTO "messages" VALUES(308,'<uid-169703@jobpilot.local>',NULL,'in','ignored','done','','','','','','1899-12-31T22:30:00Z','',NULL,'','',0);
INSERT INTO "messages" VALUES(309,'<uid-169701@jobpilot.local>',NULL,'in','ignored','done','','','','','','1899-12-31T22:30:00Z','',NULL,'','',0);
INSERT INTO "messages" VALUES(310,'<LDTBOIRcTgeGJ1ZAdo3AmA@geopod-ismtpd-109>',NULL,'in','ignored','done','offers@hello.designcrowd.com','','','','','2026-11-13T12:29:16Z','',NULL,'','',0);
INSERT INTO "messages" VALUES(311,'<CAPnbK3sSBGLUCQ0F4pL6UD-Os60suj43_Nxqd5twyKfWJq5zUQ@mail.gmail.com>',NULL,'in','ignored','done','kenny@hooligan.co.za','','','','','2026-11-13T12:39:57Z','',NULL,'','',0);
INSERT INTO "messages" VALUES(312,'<CANwOQ0dfkOhR3B12HVWFHVd4AGhjXjokdt8BwL1PnMX6T1YFZg@mail.gmail.com>',5,'in','reply','done','kenmbi290@gmail.com','','Assessment for your application at Website Test Company','  Please complete the attached assessment.
','','2026-11-13T12:44:05Z','assessment',1.0,'Website Test Company has sent an assessment to complete for your job application.','Complete the attached assessment.',0);
INSERT INTO "messages" VALUES(313,'<CANwOQ0fOJHecB=6m+g=DCG+KPZfmQ5QAAY_G_aaTbUUViFeQDA@mail.gmail.com>',4,'in','reply','done','kenmbi290@gmail.com','','','  Following up on our call.
','','2026-11-13T12:51:40Z','other',0.9,'The sender is following up on a previous call without providing further details or job context.','',0);
INSERT INTO "messages" VALUES(314,'<ab8cb963.EAAACcoaMR4AAAAyeMgAANemxfgAAAACJG8ABGR8ACigVQBq9wiy@mailjet.com>',NULL,'in','ignored','done','info@mail.incredible.co.za','','','','','2026-11-13T12:55:14Z','',NULL,'','',0);
INSERT INTO "messages" VALUES(315,'<179457477692.3256.7650982778759805621@gmail.com>',NULL,'out','ignored','done','chirombokenny@gmail.com','','','','','2026-11-13T12:59:38Z','',NULL,'','',0);
INSERT INTO "messages" VALUES(316,'<179457480089.3256.359584962521100639@gmail.com>',NULL,'out','ignored','done','chirombokenny@gmail.com','','','','','2026-11-13T13:00:02Z','',NULL,'','',0);
CREATE INDEX messages_app ON messages(application_id);
CREATE INDEX events_app ON events(application_id);
CREATE VIEW v_applications AS
SELECT
  a.*,
  j.title, j.company, j.location, j.url, j.sources, j.score,
  (SELECT COUNT(*) FROM messages m WHERE m.application_id = a.id AND m.direction = 'in'
      AND m.state = 'done') AS responses,
  (SELECT COUNT(*) FROM messages m WHERE m.application_id = a.id AND m.direction = 'in'
      AND m.state = 'done' AND m.category <> 'acknowledgement') AS real_responses,
  (SELECT MIN(m.at) FROM messages m WHERE m.application_id = a.id AND m.direction = 'in'
      AND m.state = 'done' AND m.category <> 'acknowledgement') AS first_response_at,
  (SELECT MAX(m.at) FROM messages m WHERE m.application_id = a.id AND m.direction = 'in'
      AND m.state = 'done') AS last_response_at,
  (SELECT COUNT(*) FROM messages m WHERE m.application_id = a.id AND m.kind = 'followup'
      AND m.state = 'done') AS followups_sent,
  (SELECT MIN(m.at) FROM messages m WHERE m.application_id = a.id AND m.kind = 'followup'
      AND m.state = 'done') AS first_followup_at,
  (SELECT MAX(m.at) FROM messages m WHERE m.application_id = a.id AND m.direction = 'out'
      AND m.state = 'done') AS last_out_at,
  EXISTS (SELECT 1 FROM events e WHERE e.application_id = a.id AND e.type = 'status'
      AND e.detail IN ('assessment', 'interview', 'offer')) AS progressed,
  EXISTS (SELECT 1 FROM events e WHERE e.application_id = a.id AND e.type = 'status'
      AND e.detail IN ('interview', 'offer')) AS got_interview,
  EXISTS (SELECT 1 FROM events e WHERE e.application_id = a.id AND e.type = 'status'
      AND e.detail = 'offer') AS got_offer
FROM applications a JOIN jobs j ON j.id = a.job_id;
COMMIT;