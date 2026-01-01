# ERP → Salesforce Enterprise Integration

This repository demonstrates a real-world enterprise integration between an ERP system (SAP-style) and Salesforce.

This architecture is used in Pharma, Manufacturing and Healthcare systems where ERP platforms send Customers, Orders and Partner data into Salesforce in real-time.

---
## Cost-Optimized Architecture (No Middleware)

In many enterprise projects, SAP ↔ Salesforce integrations use middleware like:
- MuleSoft
- SAP CPI
- Dell Boomi

While powerful, these add significant licensing and infrastructure cost.

This solution demonstrates a **direct ERP → Salesforce integration** using:
- Apex REST APIs
- Queueable & Batch Apex
- Metadata-driven mapping

This approach:
- Eliminates middleware licensing cost
- Reduces system complexity
- Works well for controlled B2B integrations
- Is suitable for regulated environments where traffic is predictable

This pattern is commonly used when:
- ERP and Salesforce are within the same enterprise
- Data volumes are high but structured
- Cost and simplicity are important factors
- 
## Business Problem

A global pharma company needed to integrate:
- Customers
- Orders
- Business Partners

from an ERP system into Salesforce.

The data volume was high, needed retry handling, and had to support multiple ERP endpoints using one unified framework.

---

## Solution Architecture

ERP → REST API → Queueable → Batch Apex → Dynamic Upsert Engine → Salesforce Objects

All object and field mappings are driven by Custom Metadata.

---

## Key Features

- Apex REST API for ERP
- Metadata-driven endpoint → object mapping
- Metadata-driven field mapping
- Queueable for async buffering
- Batch Apex for bulk processing
- Dynamic upsert using external IDs
- Scalable enterprise design

---

## Tech Stack

- Salesforce Apex
- REST APIs
- Queueable & Batch Apex
- Custom Metadata
- JSON
- Platform Events (optional extension)

---

## Sample ERP Payload

```json
POST /services/apexrest/erp/customers

{
  "erpId": "ERP1001",
  "name": "Test Pharma Ltd",
  "country": "Germany"
}
