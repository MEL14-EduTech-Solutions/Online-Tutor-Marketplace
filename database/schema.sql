-- ETS Connect: Database Schema (PostgreSQL)

-- 1. Identity & Access Management
CREATE TYPE user_role AS ENUM ('Student', 'Tutor', 'Admin');

CREATE TABLE users (
    user_id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    email VARCHAR(255) UNIQUE NOT NULL,
    password_hash VARCHAR(255) NOT NULL,
    role user_role NOT NULL DEFAULT 'Student',
    created_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP
);

-- 2. Tutor Professional Profiles
CREATE TYPE kyc_status AS ENUM ('Pending', 'Approved', 'Rejected');

CREATE TABLE tutor_profiles (
    profile_id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    user_id UUID NOT NULL REFERENCES users(user_id) ON DELETE CASCADE,
    bio TEXT,
    subjects TEXT[], -- Array of strings for flexible subject tagging
    hourly_rate DECIMAL(10, 2),
    kyc_approved kyc_status DEFAULT 'Pending',
    wwcc_number VARCHAR(50), -- Should be encrypted at the application level
    updated_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP
);

-- 3. Booking & Scheduling Engine
CREATE TYPE booking_status AS ENUM ('Pending', 'Confirmed', 'Completed', 'Cancelled');

CREATE TABLE bookings (
    booking_id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    student_id UUID NOT NULL REFERENCES users(user_id),
    tutor_id UUID NOT NULL REFERENCES tutor_profiles(profile_id),
    session_start TIMESTAMP WITH TIME ZONE NOT NULL,
    session_end TIMESTAMP WITH TIME ZONE NOT NULL,
    status booking_status DEFAULT 'Pending',
    created_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP,
    
    -- Prevent overlapping sessions for the same tutor
    CONSTRAINT no_overlap EXCLUDE USING gist (
        tutor_id WITH =,
        tstzrange(session_start, session_end) WITH &&
    )
);

-- 4. Audit & Security Logging (D5 Store)
CREATE TABLE audit_logs (
    log_id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    action_type VARCHAR(100) NOT NULL,
    user_id UUID REFERENCES users(user_id),
    ip_address INET,
    metadata JSONB, -- Flexible storage for change details
    created_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP
);
