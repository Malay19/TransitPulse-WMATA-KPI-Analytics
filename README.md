# TransitPulse: Public Transit KPI & Incident Monitoring System

## Overview
TransitPulse is a SQL-based analytics system that integrates public transit ridership, service incidents, on-time performance, and crime data into a unified relational model.  

The system enables multi-dimensional KPI analysis to support operational reliability, safety monitoring, and demand planning.

---

## Business Problem
Transit agencies often track ridership, crime, and service performance separately.  
This project integrates these datasets into a single schema to enable:

- Station-level safety analysis  
- Line-level reliability tracking  
- Ridership trend monitoring  
- Crime normalization (per million riders)

---

## Technical Architecture
- Designed 9 core tables + bridge tables
- Implemented star-schema structure
- Enforced referential integrity via foreign keys
- Created SQL views for derived KPIs

### Key KPIs Built
- Year-over-Year Ridership Change
- On-Time Performance by Line
- Crime Rate per Million Riders
- Incident Frequency by Line

---

## Tools Used
- SQL (MySQL/Oracle)
- Relational Schema Design
- ERD Modeling
- Tableau (for visualization layer)

---

## Key Insights
- High-ridership transfer stations do not necessarily have higher normalized crime rates.
- Operational delays were more strongly tied to infrastructure issues than rider volume.
- Crime normalization revealed different hotspot priorities than raw counts.

<!--  ---

## Repository Structure
- `/schema` – SQL table creation scripts
- `/views` – SQL KPI calculation views
- `/analysis` – Sample queries
- `/erd` – Database schema diagram -->
