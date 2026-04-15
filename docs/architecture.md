# Technical Architecture Document: ETS Connect

## 1. Architecture Strategy
**Architecture Style:** Monolithic
**Reasoning:** Given the team size and project timeline, a monolith provides the fastest development cycle and simplest deployment. We have modularized the code by service (Identity, Booking, Auth) to ensure maintainability.

## 2. Technology Stack
| Layer | Selection | Reasoning |
| :--- | :--- | :--- |
| **Frontend** | React.js | Best for dynamic dashboards and state management. |
| **Backend** | Node.js (Express) | High performance for I/O bound tasks like scheduling. |
| **Database** | **PostgreSQL (Relational)** | **Recommendation:** Since your system relies on complex relationships (Users linked to Roles, Bookings linked to Tutors, and Audit Logs linked to everything), a Relational Database (SQL) is much safer and more reliable than MongoDB for this project. |
| **Caching** | Redis (Optional) | For session storage if scaling is required. |

## 3. Component Descriptions
* **Identity Provider:** Manages registration and role assignment.
* **KYC Gateway:** Handles the secure upload and status tracking of WWCC documents.
* **Auth Manager:** Handles JWT generation and password hashing (Bcrypt).
* **Marketplace Engine:** Controls the search logic and tutor filtering.
* **Audit Service:** Background worker that ensures all actions are logged in the D5 store.

## 4. Data Flow Overview
Based on our finalized DFDs:
1. **Registration:** Data flows from User -> Validation -> Role Assignment -> KYC Storage -> D1/D2.
2. **Authentication:** Credentials flow to Auth Manager -> Comparison with D1 -> Session Token -> User.
3. **Audit:** Every critical process sends a "shadow" data flow to the Audit Service -> D5.
