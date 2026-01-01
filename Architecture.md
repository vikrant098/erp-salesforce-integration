# ERP → Salesforce Integration Architecture

This document describes how the ERP → Salesforce integration works at a system level.

---

## High Level Flow

ERP System (SAP-style)
|
| 1. REST / GET or POST
|
Salesforce Integration Layer
|
| 2. Apex REST API
|
v
Queueable Job
|
| 3. Async buffering & retry handling
|
v
Batch Apex Processor
|
| 4. High-volume processing
|
v
Dynamic Upsert Engine
|
| 5. Metadata-driven field mapping
|
v
Salesforce Objects
(Customer, Order, Partner)

---

## Why Queueable + Batch?

ERP systems often send:
- Large payloads
- Bursts of data
- Retry calls

Queueable ensures:
- Salesforce API responds quickly
- Callouts never block the ERP

Batch ensures:
- Large data volumes are handled safely
- Governor limits are not exceeded

---

## Metadata Driven Design

Two Custom Metadata Types control the system:

### ERP_Object__mdt
Defines:
- Which ERP endpoint maps to which Salesforce object
- Which External ID is used for upsert

Example:

| ERP Endpoint | Salesforce Object | External ID |
|--------------|------------------|-------------|
| CUSTOMER | Customer__c | ERP_Id__c |
| ORDER | Order__c | ERP_Order_Id__c |

---

### ERP_Field_Mapping__mdt
Defines:
- Which ERP field maps to which Salesforce field

Example:

| ERP Field | Salesforce Field |
|----------|------------------|
| erpId | ERP_Id__c |
| name | Name |
| country | Country__c |

---

## Benefits of this Design

- No hardcoding of field mappings
- New objects can be added without code changes
- Supports multiple ERP endpoints
- Easy to maintain and scale
- Works well in regulated environments (Pharma / Healthcare)

---

## Typical Use Cases

- SAP → Salesforce Customer Sync
- ERP → Salesforce Order Ingestion
- Partner Data Synchronization
- Healthcare System Integration

---

This architecture is commonly used in enterprise Salesforce implementations with SAP and other ERP Platform.
