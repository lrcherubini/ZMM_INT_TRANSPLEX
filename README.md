# Custom Purchase Order Creation API (TRANSPLEX)

This project provides a custom API for creating purchase orders in SAP, designed to overcome limitations of standard SAP APIs and adhere to SAP's Clean Core extensibility principles and the 3-tier software architecture model.

## Project Overview

The standard `API_PURCHASEORDER_2` in SAP S/4HANA Cloud is limited to creating purchase orders of type 'NB' (Standard Purchase Order) or its derivations. This project addresses the need for creating other purchase order types by providing a custom API that wraps the `BAPI_PO_CREATE1` function module.

The development follows a 3-tier model approach, separating concerns into Presentation, Application, and Data tiers, and strives to maintain a "Clean Core" by isolating custom logic from the standard SAP core.

## Architecture and Clean Core Principles

This project is built with the following architectural principles in mind:

### 1. 3-Tier Model Software Architecture

The project's design aligns with the 3-tier architecture concept, which promotes a clear separation of concerns:

* **Presentation Tier (Frontend/API Consumer):** Represented by the `ZAPI_TRANSPLEX` OData V4 service. This is the interface that external systems or applications interact with to create purchase orders. The `TRANSPLEX.postman_collection.json` file demonstrates how to interact with this tier.
* **Application Tier (Business Logic/Middle Layer):** This tier encapsulates the custom business logic and orchestrates calls to standard SAP functionalities.
    * ABAP RAP (Restful ABAP Programming) entities (`ZI_PURCHASEORDER`, `ZA_PURCHASEORDER`, `ZAE_PURCHASEORDERHEADERDATA`, `ZAE_PURCHASEORDERITEMDATA`) define the data model and behavior.
    * ABAP classes and interfaces within the `src/wrp` folder (e.g., `ZCL_WRAP_BAPI_PO_CREATE`, `ZIF_WRAP_BAPI_PO_CREATE`) act as wrappers around the standard `BAPI_PO_CREATE1` function module. This layer handles the processing of requests from the presentation tier and prepares data for the data tier.
* **Data Tier (Database Layer/Backend):** This represents the underlying SAP database and standard SAP functionalities. The `BAPI_PO_CREATE1` function module (`src/wrp/zfm_bapi_po_create1 rf.sush.xml`, `src/wrp/zgrmm_async_bapi.fugr.xml`) directly interacts with the SAP database to create purchase orders.

### 2. SAP Clean Core Practices

The project aims to adhere to SAP Clean Core principles, ensuring the core SAP system remains standard and easily upgradable:

* **No Modifications to SAP Standard:** Custom logic and functionality are built as extensions rather than modifying existing SAP standard code. This is evident in the use of custom ABAP development objects (`Z*` objects) that wrap standard BAPIs.
* **Leveraging Released APIs:** The project utilizes `BAPI_PO_CREATE1`, which is a released BAPI, to interact with the SAP core. This ensures stable interfaces even across SAP upgrades.
* **Side-by-Side Extensibility (Conceptual):** While the code resides within the SAP system, the architectural separation into a custom API and wrapper classes for standard functionality aligns with the concept of isolating custom logic, akin to side-by-side extensions typically deployed on SAP Business Technology Platform (BTP).
* **Modularity and Maintainability:** The structured approach with separate packages (`src/`, `src/wrp/`) and distinct ABAP development objects (CDS views, behavior definitions, classes, function groups) promotes modularity and easier maintenance of the custom solution.

## Technical Details and Challenges

### Custom API `ZAPI_TRANSPLEX`

* **Service Definition:** `zapi_transplex.srvd.xml` and `zapi_transplex.srvb.xml` define the OData V4 service, exposing functionalities to create purchase orders.
* **Behavior Definition:** `zi_purchaseorder.bdef.xml` and `za_purchaseorder.bdef.xml` define the behavior for the purchase order entity.
* **Action Parameters:** `zae_purchaseorderheaderdata.ddls.xml` and `zae_purchaseorderitemdata.ddls.xml` define the structure for the action parameters used in the custom API.

### Challenges Encountered:

During development, specific challenges were identified:

1.  **`BAPI_PO_CREATE1` Authority Check:** Despite attempts to bypass authority checks via BAPI parameters (`NO_AUTHORITY`), the `BAPI_PO_CREATE1` function module internally calls other functions that still perform authorization validations. This required careful handling of authorizations outside the direct BAPI call.
2.  **Synchronous RAP Action Limitations:** Within the RAP (Restful ABAP Programming) framework, direct database operations like `UPDATE` are not permitted in synchronous actions. This constraint prevented direct, synchronous calls to `BAPI_PO_CREATE1` that would immediately commit changes.

### Solutions Implemented:

* **Asynchronous Processing:** To circumvent the synchronous RAP action limitation for database operations, the solution leverages asynchronous processing for the purchase order creation. This is indicated by the use of `zcl_wrap_bapi_po_create_async.clas.xml` and the function group `zgrmm_async_bapi.fugr.xml`, allowing the `BAPI_PO_CREATE1` call to be executed asynchronously. The Postman collection's "Action Return Create" example demonstrates an asynchronous call.
* **Wrapper Classes:** The `zcl_wrap_bapi_po_create.clas.xml` and `zcl_wrap_bapi_po_create_fac.clas.xml` (factory class) provide a structured way to encapsulate the `BAPI_PO_CREATE1` call, adhering to object-oriented principles and further abstracting the core SAP function.

## Test Scenarios

The `TRANSPLEX.postman_collection.json` file includes test scenarios for interacting with the `ZAPI_TRANSPLEX` API:

* **`ZAPI_TRANSPLEX metadata`:** Retrieves the service metadata, including the CSRF token essential for POST requests.
* **`A_PurchaseOrder` (GET):** An example GET request to retrieve existing purchase orders, demonstrating data retrieval from the API.
* **`A_PurchaseOrder` (POST):** This example demonstrates a synchronous POST request for creating a purchase order. The `500 RAP Auth-Check Dump` response indicates the authority check issue encountered when the API is not properly authorized.
* **`Action Return Create` (POST):** This is the key test scenario for creating purchase orders asynchronously using the `createReturnOrderViaBapi` action. The `200 RAP Action` response shows a successful creation, including messages returned by the BAPI. The `400 RAP Action Bus. Error` illustrates a business error (e.g., invalid plant) returned by the API during asynchronous processing.

To run these tests, ensure you have a Postman environment configured with `host`, `client`, `user`, and `password` variables for your SAP system. The pre-request script in the Postman collection handles CSRF token fetching for POST requests.

## References

1.  [RISE with SAP | Estratégia Clean Core ERP](https://www.sap.com/brazil/products/erp/rise/methodology/clean-core.html)
2.  [SAP S/4HANA Cloud: Clean Core, Fit to Standard e Industry Solutions - Ramo Sistemas](https://ramo.com.br/clean-core-fit-to-standard-e-industry-solutions-s-4hana-cloud/)
3.  [SAP Clean Core: What It Is and How to Apply It in Practice - Cromos IT](https://cromosit.com.br/sap-clean-core-what-it-is-and-how-to-apply/)
4.  [Clean core strategy: How to keep your SAP S/4HANA system clean - IBsolution](https://www.ibsolution.com/academy/blog_en/smart-enterprise/platform/clean-core-strategy-how-to-keep-your-sap-s4hana-system-clean)
5.  [Introducing the Clean Core Approach - SAP Learning](https://learning.sap.com/learning-journeys/practicing-clean-core-extensibility-for-sap-s-4hana-cloud/introducing-the-clean-core-approach_fcb6c662-7041-4c99-88bd-345636fae7f3)
6.  [The Importance of Clean Core in Modern SAP Extension Strategies - B2RISE](https://www.b2rise.com/post/the-importance-of-clean-core-in-sap-extension-implementation)
7.  [Maximizing SAP Clean Core Strategy with RTC Solutions on SAP BTP](https://rtcsuite.com/sap-clean-core-strategy/)
8.  [SAP Clean Core-1.pdf - ASUG Insights](https://blog.asug.com/hubfs/Chapter%20Events/SAP%20Clean%20Core-1.pdf)
9.  [Clean Core – o que é, onde estudar (SAP Learning), como acompanhar (SAP for Me)](https://www.youtube.com/watch?v=Zv0BecqOe7o)
10. [The future of ERP: SAP's “clean core” approach makes Application Management Services a success factor - NTT DATA Business Solutions](https://nttdata-solutions.com/br/blog/saps-clean-core-approach-makes-ams-a-success-factor/)
11. [O que é: 3-tier architecture (Arquitetura em 3 camadas) - Nobug Tecnologia](https://nobug.com.br/glossario/o-que-e-3-tier-architecture-arquitetura-em-3-camadas/)
12. [Introduction of 3-Tier Architecture in DBMS - GeeksforGeeks](https://www.geeksforgeeks.org/introduction-of-3-tier-architecture-in-DBMS-set-2/)
13. [O que é arquitetura de três camadas (tiers) - IBM](https://www.ibm.com/br-pt/topics/three-tier-architecture)
14. [What Is Three-Tier Architecture? - IBM](https://www.ibm.com/think/topics/three-tier-architecture)
15. [N-tier architecture style - Azure - Learn Microsoft](https://learn.microsoft.com/en-us/azure/architecture/guide/architecture-styles/n-tier)
16. [Understanding the architecture of a 3-tier application - vFunction](https://vfunction.com/blog/3-tier-application/)
17. [3 Tier Architecture - Geekster Article](https://www.geekster.in/articles/3-tier-architecture/)
18. [Multitier architecture - Wikipedia](https://en.wikipedia.org/wiki/Multitier_architecture)
19. [Back To Basics: Tiers in Software Architecture - DEV Community](https://dev.to/skylinecodes/back-to-basics-tiers-in-software-architecture-4eg6)