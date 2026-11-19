-- Taxi-Duudlaga database schema (PostgreSQL)

CREATE TABLE passenger (
    passenger_id SERIAL PRIMARY KEY,
    full_name    VARCHAR(100) NOT NULL,
    phone        VARCHAR(20)  NOT NULL UNIQUE,
    created_at   TIMESTAMP    NOT NULL DEFAULT NOW()
);

CREATE TABLE driver (
    driver_id  SERIAL PRIMARY KEY,
    full_name  VARCHAR(100) NOT NULL,
    phone      VARCHAR(20)  NOT NULL UNIQUE,
    car_plate  VARCHAR(20)  NOT NULL UNIQUE,
    status     VARCHAR(20)  NOT NULL DEFAULT 'offline',  -- offline, free, busy
    lat        NUMERIC(9,6),
    lng        NUMERIC(9,6)
);

CREATE TABLE ride (
    ride_id         SERIAL PRIMARY KEY,
    passenger_id    INT NOT NULL REFERENCES passenger(passenger_id),
    driver_id       INT REFERENCES driver(driver_id),    -- empty until a driver accepts
    pickup_address  VARCHAR(255) NOT NULL,
    dropoff_address VARCHAR(255) NOT NULL,
    status          VARCHAR(20)  NOT NULL DEFAULT 'requested', -- requested, accepted, completed, cancelled
    fare            NUMERIC(10,2),
    requested_at    TIMESTAMP    NOT NULL DEFAULT NOW()
);

CREATE TABLE payment (
    payment_id SERIAL PRIMARY KEY,
    ride_id    INT NOT NULL UNIQUE REFERENCES ride(ride_id),
    amount     NUMERIC(10,2) NOT NULL,
    method     VARCHAR(20)   NOT NULL,                   -- cash, qpay
    status     VARCHAR(20)   NOT NULL DEFAULT 'pending',
    paid_at    TIMESTAMP
);

-- Indexes for the performance NFR (fast driver search)
CREATE INDEX idx_driver_status ON driver(status);
CREATE INDEX idx_ride_status   ON ride(status);