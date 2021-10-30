

CREATE TABLE IF NOT EXISTS Customer(
    id INT AUTO_INCREMENT,
    orgnr VARCHAR(12),
    name VARCHAR(100),
    PRIMARY KEY(id)
)ENGINE=INNODB;

CREATE TABLE IF NOT EXISTS Contact(
    id INT AUTO_INCREMENT,
    customer_id INT NOT NULL,
    firstname VARCHAR(30),
    lastname VARCHAR(60),
    email VARCHAR(50),
    fixednumber VARCHAR(25),
    mobilenumber VARCHAR(25),
    FOREIGN KEY(customer_id) REFERENCES Customer(id),
    PRIMARY KEY(id)
)ENGINE=INNODB;

CREATE TABLE IF NOT EXISTS SLA(
    id INT AUTO_INCREMENT,
    slalevel INT NOT NULL,
    slatype VARCHAR(20) NOT NULL,
    PRIMARY KEY(id)
)ENGINE=INNODB;

CREATE TABLE IF NOT EXISTS TicketStatus(
    id INT AUTO_INCREMENT,
    statusname VARCHAR(30),
    PRIMARY KEY(id)
)ENGINE=INNODB;

CREATE TABLE IF NOT EXISTS Flow(
    id INT AUTO_INCREMENT,
    flowname VARCHAR(32),
    PRIMARY KEY(id)
)ENGINE=INNODB;

CREATE TABLE IF NOT EXISTS StatusFlow(
    flow_id INT NOT NULL,
    current_status_id INT NOT NULL,
    next_status_id INT NOT NULL,
    FOREIGN KEY(flow_id) REFERENCES Flow(id),
    FOREIGN KEY(current_status_id) REFERENCES TicketStatus(id),
    FOREIGN KEY(next_status_id) REFERENCES TicketStatus(id),
    PRIMARY KEY(flow_id, current_status_id, next_status_id)
)ENGINE=INNODB;

CREATE TABLE IF NOT EXISTS Ticket(
    id INT AUTO_INCREMENT,
    status_id INT NOT NULL,
    title VARCHAR(100) NOT NULL,
    issuer_id INT NOT NULL,
    created TIMESTAMP DEFAULT NOW(),
    reacted TIMESTAMP,
    resolved TIMESTAMP,
    sla_id INT,
    FOREIGN KEY(status_id) REFERENCES TicketStatus(id),
    FOREIGN KEY(issuer_id) REFERENCES Contact(id),
    FOREIGN KEY(sla_id) REFERENCES SLA(id),
    PRIMARY KEY(id)
)ENGINE=INNODB;

CREATE TABLE IF NOT EXISTS Post(
    id INT AUTO_INCREMENT,
    ticket_id INT NOT NULL,
    body TEXT NOT NULL,
    created TIMESTAMP DEFAULT NOW(),
    updated TIMESTAMP DEFAULT NOW() ON UPDATE NOW(),
    public TINYINT(1) DEFAULT 1,
    FOREIGN KEY(ticket_id) REFERENCES Ticket(id),
    PRIMARY KEY(id)
)ENGINE=INNODB;

