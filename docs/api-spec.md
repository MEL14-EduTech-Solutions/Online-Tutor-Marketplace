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

# Database Schema

## 1. Entity Descriptions

### 1.1 Users Table (`users`)
Stores core identity data for both Students and Tutors.
- `user_id`: UUID (Primary Key)
- `email`: String (Unique)
- `password_hash`: String
- `role`: Enum (Student, Tutor, Admin)
- `created_at`: Timestamp

### 1.2 Tutor Profiles Table (`tutor_profiles`)
Extends the User table with professional data for Tutors.
- `profile_id`: UUID (Primary Key)
- `user_id`: UUID (Foreign Key -> users.user_id)
- `bio`: Text
- `subjects`: Array[String]
- `hourly_rate`: Decimal
- `kyc_status`: Enum (Pending, Approved, Rejected)
- `wwcc_number`: String (Encrypted)

### 1.3 Bookings Table (`bookings`)
Manages the relationship between a student and a tutor for a specific time.
- `booking_id`: UUID (Primary Key)
- `student_id`: UUID (Foreign Key -> users.user_id)
- `tutor_id`: UUID (Foreign Key -> tutor_profiles.profile_id)
- `session_start`: Timestamp
- `session_end`: Timestamp
- `status`: Enum (Confirmed, Pending, Completed, Cancelled)

### 1.4 Audit Logs Table (`audit_logs`)
The dedicated **D5** store for system-wide security tracking.
- `log_id`: UUID (Primary Key)
- `action_type`: String (e.g., "LOGIN_SUCCESS", "KYC_UPLOAD")
- `user_id`: UUID (Foreign Key -> users.user_id)
- `ip_address`: String
- `timestamp`: Timestamp
- `metadata`: JSONB (Stores specific details of the change)
