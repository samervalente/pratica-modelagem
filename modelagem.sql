CREATE DATABASE praticaModelagem

CREATE TABLE customers (
    id SERIAL PRIMARY KEY,
    "fullName" VARCHAR(50) NOT NULL,
    cpf VARCHAR(11) NOT NULL UNIQUE,
    email TEXT NOT NULL UNIQUE,
    password TEXT NOT NULL
)

CREATE TABLE bankAccount (
    id SERIAL PRIMARY KEY,
    "customerId" INTEGER NOT NULL REFERENCES customers(id),
    "accountNumber" INTEGER NOT NULL UNIQUE,
    "agency" VARCHAR(4) NOT NULL,
    "openDate" TIMESTAMP WITHOUT TIMEZONE NOT NULL,
    "closeDate" TIMESTAMP WITHOUT TIMEZONE NOT NULL
)

CREATE TABLE transactions (
    id SERIAL PRIMARY KEY,
    "bankAccountId" INTEGER NOT NULL REFERENCES bankAccount(id),
    amount INTEGER NOT NULL,
    type TEXT NOT NULL,
    time DATE NOT NULL DEFAULT NOW(),
    description TEXT,
    cancelled BOOLEAN NOT NULL,
)

CREATE TABLE creditCards(
    id SERIAL PRIMARY KEY,
    "bankAccountId" INTEGER NOT NULL REFERENCES bankAccount(id),
    name TEXT NOT NULL,
    number INTEGER NOT NULL UNIQUE,
    "securityCode" INTEGER VARCHAR(3) NOT NULL UNIQUE,
    "expirationMonth" DATE NOT NULL,
    "expirationYear" DATE NOT NULL,
    password TEXT NOT NULL,
    limit INTEGER NOT NULL DEFAULT 0
)

CREATE TABLE customerAddresses(
    id SERIAL PRIMARY KEY,
    "customerId" INTEGER NOT NULL REFERENCES customers(id),
    street TEXT NOT NULL,
    number INTEGER NOT NULL,
    complement TEXT NOT NULL,
    "postalCode" TEXT NOT NULL,
    "cityId" INTEGER NOT NULL REFERENCES cities(id)
)

CREATE TABLE cities(
    id SERIAL PRIMARY KEY,
    name TEXT NOT NULL,
    "stateId" INTEGER NOT NULL REFERENCES states(id) 
)

CREATE TABLE states(
    id SERIAL PRIMARY KEY,
    name TEXT NOT NULL
)

CREATE TYPE PHONETYPE as ENUM ('landline','mobile')

CREATE TABLE customerPhones(
    id SERIAL PRIMARY KEY,
    "customerId" INTEGER NOT NULL REFERENCES customers(id),
    number VARCHAR(11) NOT NULL UNIQUE,
   type PHONETYPE
)

