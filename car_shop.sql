-- create database

CREATE DATABASE car_shop;

USE car_shop;

-- create clients table

CREATE TABLE IF NOT EXISTS clients (
	idClient INT AUTO_INCREMENT PRIMARY KEY,
    clientName VARCHAR(45),
    cpf VARCHAR(11),
    phoneNum VARCHAR(45),
    CONSTRAINT unique_client_cpf UNIQUE (cpf)
);

-- create team table

CREATE TABLE IF NOT EXISTS team (
	idTeam INT AUTO_INCREMENT PRIMARY KEY
);

-- create car table

CREATE TABLE IF NOT EXISTS car (
	idCar INT AUTO_INCREMENT PRIMARY KEY,
    idCarClient INT,
	idCarTeam INT,
    model VARCHAR(45) NOT NULL,
	manufacturer VARCHAR(45) NOT NULL,
    color VARCHAR(45),
    carYear VARCHAR(4) NOT NULL,
    registrationPlate VARCHAR(20) NOT NULL,
    vin VARCHAR(45) NOT NULL,
    CONSTRAINT unique_car_registrationPlate UNIQUE (registrationPlate),
    CONSTRAINT unique_car_vin UNIQUE (vin),
    CONSTRAINT fk_car_client FOREIGN KEY (idCarClient) REFERENCES clients (idClient),
    CONSTRAINT fk_car_team FOREIGN KEY (idCarTeam) REFERENCES team (idTeam)
);

-- create workers table

CREATE TABLE IF NOT EXISTS workers (
	idWorker INT AUTO_INCREMENT PRIMARY KEY,
    workerCode VARCHAR(45) NOT NULL, 
    workerName VARCHAR(45) NOT NULL,
    cpf VARCHAR(11) NOT NULL,
    address VARCHAR(45) NOT NULL,
    specialty VARCHAR(45) NOT NULL,
    CONSTRAINT unique_worker_code UNIQUE (workerCode),
    CONSTRAINT unique_worker_cpf UNIQUE (cpf)
);

-- create revision table

CREATE TABLE IF NOT EXISTS revision (
	idRevision INT AUTO_INCREMENT PRIMARY KEY,
    idRevisionClient INT,
    revisionNum INT NOT NULL,
    revisionDescription VARCHAR(500) NOT NULL,
    initial_date DATETIME,
    delivery_date DATETIME,
    total_cost FLOAT,
    delivery_status VARCHAR(45) NOT NULL,
    payment_status VARCHAR(45) NOT NULL,
    CONSTRAINT fk_revision_client FOREIGN KEY (idRevisionClient) REFERENCES clients (idClient)
);

-- create service table

CREATE TABLE IF NOT EXISTS service (
	idService INT AUTO_INCREMENT PRIMARY KEY,
    serviceName VARCHAR(45) NOT NULL,
    serviceDescription VARCHAR(500) NOT NULL,
    costPerHour FLOAT NOT NULL
);

-- create item supplier table

CREATE TABLE IF NOT EXISTS itemSupplier (
	idItemSupplier INT AUTO_INCREMENT PRIMARY KEY,
    supplierName VARCHAR(45) NOT NULL,
    phone VARCHAR(45) NOT NULL,
    address VARCHAR(45) NOT NULL,
    email VARCHAR(45) NOT NULL
);

-- create table item

CREATE TABLE IF NOT EXISTS item (
	idItem INT AUTO_INCREMENT PRIMARY KEY,
    itemName VARCHAR(45) NOT NULL,
    itemDescription VARCHAR(500) NOT NULL,
    itemSupplier VARCHAR(45) NOT NULL,
    price FLOAT NOT NULL,
    amountInStock INT NOT NULL
);

-- create table teamWorker

CREATE TABLE IF NOT EXISTS teamWorker (
	idTeam INT,
    idWorker INT,
    PRIMARY KEY (idTeam, idWorker),
    CONSTRAINT fk_teamWorker_team FOREIGN KEY (idTeam) REFERENCES team (idTeam),
    CONSTRAINT fk_teamWorker_worker FOREIGN KEY (idWorker) REFERENCES workers (idWorker)
);

-- create table revisionService

CREATE TABLE IF NOT EXISTS revisionService (
	idRevision INT,
    idService INT,
    quantity INT NOT NULL DEFAULT 0,
    PRIMARY KEY (idRevision, idService),
    CONSTRAINT fk_revisionService_revision FOREIGN KEY (idRevision) REFERENCES revision(idRevision),
    CONSTRAINT fk_revisionService_service FOREIGN KEY (idService) REFERENCES service(idService)
);

-- create table revisionItem 

CREATE TABLE IF NOT EXISTS revisionItem (
	idRevision INT,
    idItem INT,
    quantity INT NOT NULL DEFAULT 0,
    PRIMARY KEY (idRevision, idItem),
    CONSTRAINT fk_revisionItem_revision FOREIGN KEY (idRevision) REFERENCES revision(idRevision),
    CONSTRAINT fk_revisionItem_item FOREIGN KEY (idItem) REFERENCES item(idItem)
);

-- create table item_and_itemSupplier

CREATE TABLE IF NOT EXISTS item_and_itemSupplier (
	idItem INT,
    idItemSupplier INT,
    PRIMARY KEY (idItem, idItemSupplier),
    CONSTRAINT fk_item_and_itemSupplier_item FOREIGN KEY (idItem) REFERENCES item(idItem),
    CONSTRAINT fk_item_and_itemSupplier_itemSupplier FOREIGN KEY (idItemSupplier) REFERENCES itemSupplier(idItemSupplier)
);