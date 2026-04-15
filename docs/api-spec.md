# API Specification

## 1. Authentication & Identity
| Method | Endpoint | Description |
| :--- | :--- | :--- |
| **POST** | `/api/auth/register` | Create a new user account (Student/Tutor). |
| **POST** | `/api/auth/login` | Authenticate credentials and return a JWT. |
| **POST** | `/api/kyc/upload` | (Tutors only) Submit WWCC and ID for verification. |

## 2. Tutor Marketplace
| Method | Endpoint | Description |
| :--- | :--- | :--- |
| **GET** | `/api/tutors` | Search and filter tutors by subject, price, and location. |
| **GET** | `/api/tutors/:id` | Retrieve full profile details for a specific tutor. |

## 3. Bookings & Scheduling
| Method | Endpoint | Description |
| :--- | :--- | :--- |
| **POST** | `/api/bookings` | Create a new lesson booking request. |
| **GET** | `/api/bookings/my-sessions` | Retrieve upcoming lessons for the logged-in user. |
| **PATCH** | `/api/bookings/:id` | Update booking status (e.g., Cancel or Mark Complete). |

## 4. System Administration (Audit)
| Method | Endpoint | Description |
| :--- | :--- | :--- |
| **GET** | `/api/admin/audit-logs` | Retrieve system-wide activity logs (Admin only). |

---

# Data Validation Rules

To ensure system integrity and security, the following validations will be enforced:

1.  **Email Validation:** All emails must follow standard format and be checked for uniqueness in the database.
2.  **KYC Document Lock:** Tutors cannot be displayed in search results (`GET /api/tutors`) if their `kyc_status` is not "Approved".
3.  **Booking Conflict Check:** The backend must verify that a tutor does not have an overlapping session in the `bookings` table before allowing a `POST /api/bookings` request to succeed.
4.  **Password Strength:** Minimum 8 characters, including 1 uppercase, 1 number, and 1 special character.
