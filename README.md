# ERP → Salesforce Enterprise Integration

This repository demonstrates a real-world enterprise integration between an ERP system (SAP-style) and Salesforce.

This architecture is commonly used in **Pharma, Manufacturing, and Healthcare** systems where ERP platforms send **Customers, Orders, and Partner data** into Salesforce in near real-time.

---

## Cost-Optimized Architecture (No Middleware)

In many enterprise projects, ERP ↔ Salesforce integrations use middleware platforms such as:
- MuleSoft
- SAP CPI
- Dell Boomi

While powerful, these introduce **high licensing and infrastructure costs**.

This solution demonstrates a **direct ERP → Salesforce integration** using:
- Apex REST APIs  
- Queueable & Batch Apex  
- Metadata-driven field and object mapping  

This approach:
- Eliminates middleware licensing costs  
- Reduces system complexity  
- Works well for controlled B2B integrations  
- Is suitable for regulated environments where traffic is predictable  

This pattern is commonly used when:
- ERP and Salesforce are within the same enterprise  
- Data volumes are high but structured  
- Cost and operational simplicity are important  

---

## Business Problem

A global pharma company needed to integrate:
- Customers  
- Orders  
- Business Partners  

from an ERP system into Salesforce.

The solution needed to handle:
- High data volumes  
- Multiple ERP endpoints  
- Retry and recovery  
- Unified configuration-based mapping  

---

## Solution Architecture

ERP → Apex REST API → Queueable → Batch Apex → Dynamic Upsert Engine → Salesforce Objects  

All object and field mappings are driven by **Custom Metadata**, allowing configuration without code changes.

---

## Key Features

- Apex REST API for ERP ingestion  
- Metadata-driven endpoint → object mapping  
- Metadata-driven field mapping  
- Queueable for async buffering  
- Batch Apex for bulk processing  
- Dynamic upsert using External IDs  
- Scalable enterprise-grade design  

---

## Tech Stack

- Salesforce Apex  
- REST APIs  
- Queueable & Batch Apex  
- Custom Metadata  
- JSON  

 ---
###

Developed by  
Vikrant Kumar Gupta  
Senior Salesforce Engineer  
Healthcare & Enterprise Integrations


## Sample ERP Payload

```json
POST /services/apexrest/erp/customers

{
  "erpId": "ERP1001",
  "name": "Test Pharma Ltd",
  "country": "Germany"
}

