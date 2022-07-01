CREATE TABLE patients (
    id INT GENERATED ALWAYS AS IDENTITY,
    name VARCHAR(190),
    date_of_birth date,
    PRIMARY KEY (id)
);

CREATE TABLE medical_histories (
    id INT GENERATED ALWAYS AS IDENTITY,
    admitted_at TIMESTAMP,
    patient_id INT,
    status VARCHAR(256),
    PRIMARY KEY (id),

    CONSTRAINT fk_patient
      FOREIGN KEY(patient_id) 
	    REFERENCES patients(id)
);

CREATE TABLE treatments (
    id INT GENERATED ALWAYS AS IDENTITY,
    type VARCHAR(256),
    name VARCHAR(256),
    PRIMARY KEY (id)
);

CREATE TABLE invoices (
    id INT GENERATED ALWAYS AS IDENTITY,
    total_amount NUMERIC(8,2),
    generated_at TIMESTAMP,
    payed_at TIMESTAMP,

    PRIMARY KEY (id),
    medical_history_id INT,

    CONSTRAINT fk_medical_history
      FOREIGN KEY(medical_history_id) 
	    REFERENCES medical_histories(id)

);

CREATE TABLE invoice_items (
    id INT GENERATED ALWAYS AS IDENTITY,
    unit_price NUMERIC(8,2),
    quantity INT,
    total_price NUMERIC(8,2),
    invoice_id INT,
    treatment_id INT,
    
    PRIMARY KEY (id),

    CONSTRAINT fk_invoice
      FOREIGN KEY(invoice_id) 
	    REFERENCES invoices(id),

    CONSTRAINT fk_treatment
      FOREIGN KEY(treatment_id) 
	    REFERENCES treatments(id)
);


-- junction table for medical histories and treatments in a many-to-many relationship
CREATE TABLE medical_histories_treatments (
    id INT GENERATED ALWAYS AS IDENTITY,
    medical_history_id INT,
    treatment_id INT,
    
    PRIMARY KEY (id),

    CONSTRAINT fk_medical_history_jn
      FOREIGN KEY(medical_history_id) 
	    REFERENCES medical_histories(id),

    CONSTRAINT fk_treatment_id_jn
      FOREIGN KEY(treatment_id) 
	    REFERENCES treatments(id)
);