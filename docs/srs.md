# Software Requirements Specification (SRS)

## 1. Introduction

### 1.1 Purpose
This Software Requirements Specification defines the core product features and system requirements for the **Online Tutor Marketplace (ETS Connect)**. It captures the Week 3 requirements gathering deliverables, including user personas, functional requirements, non-functional requirements, user stories, and acceptance criteria.

### 1.2 Product Overview
The product is a secure, centralized marketplace designed to connect students with verified academic tutors in Australia. It streamlines the process of finding tutors, verifying credentials (KYC/WWCC), and managing lesson bookings through a transparent and automated system.

### 1.3 Scope
The system will support:
- Tutor search by subject, level (K-12/Higher Ed), and local Australian curriculum.
- Identity and academic verification (KYC) for all tutor accounts.
- Automated scheduling and lesson booking workflows.
- Secure session management and dashboard redirects.
- Audit logging for all security-sensitive transactions (NFR. 27).

The system will not initially include:
- In-platform video conferencing (will link to external tools like Zoom/Teams).
- Complex payroll/tax management for tutors.
- Automated grading or AI-based content generation.

## 2. Primary Users and Goals

### 2.1 Primary Users
- **Parents:** Seeking safe and verified academic support for their children.
- **Students (K-12 & Higher Ed):** Looking for targeted assistance with schoolwork and assignments.
- **Tutors:** Looking for a secure platform to find students and manage their teaching business.

### 2.2 Secondary Users
- **System Administrators:** Responsible for manual verification of KYC documents.
- **Academic Institutions:** Seeking to recommend vetted resources to their student body.

### 2.3 User Goals
- Find verified tutors who understand local Australian curriculum standards (VCE, HSC, etc.).
- Ensure student safety through mandatory Working with Children Checks (WWCC).
- Simplify the booking and payment process to avoid coordination errors.
- Track academic progress and maintain a clear history of lessons.
- Establish trust through a transparent review and rating system.

### 2.4 User Actions
Users will perform actions such as:
- Register an account and undergo KYC verification (Tutors).
- Search for tutors using advanced filters (Subject, Price, Availability).
- Book lesson slots via an integrated calendar.
- Receive success notifications and dashboard redirects upon login.
- Review and rate tutors after completed sessions.

## 3. User Personas

### Persona 1: Concerned Parent
- **Name:** Linda
- **Age:** 42
- **Background:** A busy mother of two in Melbourne looking for a VCE Math tutor.
- **Goals:** Find a tutor who is safe (WWCC verified) and affordable.
- **Pain Points:** Hard to verify the credentials of tutors found on Facebook; tired of manual bank transfers and "no-shows."

### Persona 2: University Student
- **Name:** Julian
- **Age:** 22
- **Background:** A third-year Engineering student needing help with advanced fluid mechanics.
- **Goals:** Find a tutor with specific technical expertise who can meet on short notice.
- **Pain Points:** Generic platforms don't filter well for specific engineering subjects; difficult to manage multiple tutors for different subjects.

### Persona 3: Expert Tutor
- **Name:** Marcus
- **Age:** 31
- **Background:** A secondary school teacher moonlighting as a chemistry and physics tutor.
- **Goals:** Find a steady stream of students and have a secure way to get paid.
- **Pain Points:** Dealing with payment disputes and spending too much time on administrative scheduling.

## 4. Functional Requirements

### 4.1 Account Management & Security
- **FR1:** The system shall allow users to register as either a Student or a Tutor.
- **FR2:** The system shall require Tutors to upload KYC documents (ID and WWCC) for verification.
- **FR3:** The system shall authenticate users against hashed credentials stored in the database.

### 4.2 Search and Discovery
- **FR4:** The system shall allow users to search for tutors by subject, price range, and curriculum type.
- **FR5:** The system shall display verified badges on tutor profiles once KYC is approved.

### 4.3 Booking and Scheduling
- **FR6:** The system shall provide an integrated calendar for tutors to set availability.
- **FR7:** The system shall allow students to book specific time slots and receive automated confirmations.

### 4.4 Audit and Logging
- **FR8:** The system shall record all registration and authentication attempts in a secure audit log (D5).
- **FR9:** The system shall log all changes to user roles and KYC status for security monitoring.

## 5. Non-Functional Requirements

### 5.1 Usability
- **NFR1:** The interface shall be simple enough for K-12 students and parents to navigate without training.
- **NFR2:** The system shall support a professional, minimalist branding aesthetic.

### 5.2 Performance
- **NFR3:** The authentication process (login to dashboard) shall complete within 2 seconds.
- **NFR4:** Tutor search results should update in under 3 seconds after a filter is applied.

### 5.3 Reliability
- **NFR5:** The system shall maintain 99.5% uptime during peak tutoring hours (4 PM – 9 PM AEST).
- **NFR6:** The system shall handle database connection drops gracefully without losing user session data.

### 5.4 Security and Privacy
- **NFR7:** All passwords must be hashed before storage in the User Account database (D1).
- **NFR8:** Sensitive KYC documents must be encrypted and accessible only to authorized administrators.
- **NFR27:** The system must maintain a comprehensive audit trail for all security-relevant events.

## 6. User Stories

### Registration & Trust
- As a tutor, I want to upload my WWCC and ID so that parents know I am a verified and safe educator.
- As a parent, I want to see a "Verified" badge on a tutor's profile so that I can trust them with my child’s learning.

### Discovery & Booking
- As a student, I want to filter tutors by "VCE Specialist" so that I can find someone who knows my specific curriculum.
- As a parent, I want to book and pay for a session through the platform so that I am protected from payment disputes.

### Session Management
- As a user, I want to be redirected to my specific dashboard after logging in so that I can immediately see my upcoming lessons.
- As a tutor, I want to see an audit log of my session history so that I can keep track of my completed work and payments.

## 7. Acceptance Criteria

### For Identity & KYC
- Tutors cannot be searched or booked until their KYC status is marked as "Approved" by an admin.
- The system must capture metadata (timestamp, user ID) for every registration attempt.

### For Authentication
- Users must be redirected to the "Student Dashboard" if they have a student role and "Tutor Dashboard" if they have a tutor role.
- Failed login attempts must be logged in the Audit Log (D5) for security purposes.

### For Search & Booking
- Filtering for "Math" must hide all tutors who do not have "Math" listed in their subject expertise.
- A booked slot must become "Unavailable" for other users immediately upon successful transaction.

## 8. Summary
The primary users are students and parents in Australia seeking high-quality, verified academic support. Their goals are to find tutors who align with local curriculum standards and operate within a safe, transparent ecosystem. This SRS provides the requirements baseline for the development of the ETS Connect platform, ensuring that safety (KYC) and efficiency (automated booking) remain core project priorities.
