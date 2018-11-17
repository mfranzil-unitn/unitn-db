# ESERCIZI DI CONVERSIONE DA ER A RELATIONAL CON SQL

> * [click_here_for_some_SPAM](http://www.milliondollarhomepage.com)
> * _In questa pagina di esercizi ci potrebbero esserre degli errori, quindi se qualcuno li dovesse trovare, o avessi migliori consigli di come implementare i seguenti ER diagrams si faccia avanti che così magari inizio a capirci qualcosa anch'io._
> * __HO INTESO TUTTE LE FRECIE COME FRECIE SOTILI PERCHE' PER ME NON ERANO ABBASTANZA GROSE DA ESSERE CONSIDERATE TALI...QUINDI SOLO A SCOPO DIMOSTRATIVO L'HO FATTO GIUSTO NELL'ES 4 F.T.S.__

# 1° Esercizio

> ![Immagine Primo Esercizio](https://image.ibb.co/ez1CAL/Schermata-2018-11-15-alle-17-28-43.png)

``` SQL
CREATE TABLE Professors (
    ssn TEXT,
    age INTEGER,
    p_rank INTEGER, 
    speciallity TEXT,
    PRIMARY KEY (ssn)
)

CREATE TABLE Dept (
    dno INTEGER, 
    dname TEXT, 
    office TEXT,
    PRIMARY KEY (dno)
)

CREATE TABLE Runs (
    dno INTEGER, 
    ssn TEXT,
    PRIMARY KEY (ssn),
    FOREIGN KEY (dno) REFERENCES (Dept),
    FOREIGN KEY (ssn) REFERENCES (Professors)
)

CREATE TABLE Work_dept (
    dno INTEGER, 
    ssn TEXT, 
    pc_time TIME,
    PRIMARY KEY (dno, ssn),
    FOREIGN KEY (dno) REFERENCES (Dept),
    FOREIGN KEY (ssn) REFERENCES (Professors)
)

CREATE TABLE Projects (
    pid TEXT,
    sponsor TEXT,
    start_data DATE,
    end_date DATE,
    budjet INTEGER,
    PRIMARY KEY (pid)
)

CREATE TABLE work_in (
    pid TEXT,
    ssn TEXT, 
    PRIMARY KEY (pid, ssn),
    FOREIGN KEY (pid) REFERENCES (Projects),
    FOREIGN KEY (ssn) REFERENCES (Professors)
)

CREATE TABLE Manages (
    pid TEXT,
    ssn TEXT, 
    PRIMARY KEY (ssn),
    FOREIGN KEY (pid) REFERENCES (Projects),
    FOREIGN KEY (ssn) REFERENCES (Professors)
)

CREATE TABLE Work_project (
    ssn_w_p TEXT,
    pid TEXT, 
    ssn_g TEXT,
    PRIMARY KEY (pid, ssn_g),
    FOREIGN KEY (pid) REFERENCES (Projects),
    FOREIGN KEY (ssn_g) REFERENCES (Graduates)
)

CREATE TABLE Graduates (
    ssn_g TEXT, 
    age INTEGER, 
    deg_prog TEXT,
    nome TEXT,
    PRIMARY KEY (ssn_g)
)

CREATE TABLE Advisor (
    ssn_g TEXT,
    PRIMARY KEY (ssn_g),
    FOREIGN KEY (ssn_g) REFERENCES (Graduates)
)

CREATE TABLE Major (
    ssn TEXT,
    dno INTEGER,
    PRIMARY KEY (ssn),
    FOREIGN KEY (ssn_g) REFERENCES (Graduate),
    FOREIGN KEY (dno) REFERENCES (Dept)
 )

 CREATE TABLE Supervises (
     ssn TEXT,
     pid TEXT,
     ssn_w_p TEXT,
     ssn_g TEXT,
    PRIAMRY KEY (ssn),
    FOREIGN KEY (ssn_g) REFERENCES (Graduate),
    FOREIGN KEY (pid) REFERENCES (Projects),
    FOREIGN KEY (ssn) REFERENCES (Professors)
 )

```

# 2° Esercizio:

![Immagine secondo esercizio](https://image.ibb.co/hQM2c0/Schermata-2018-11-15-alle-18-55-06.png)

```SQL
CREATE TABLE Departments (
    dno INTEGER,
    dname TEXT,
    budget INTEGER,
    PRIMARY KEY (dno),
)

CREATE TABLE Works_In (
    dno INTEGER,
    ssn TEXT,
    PRIMARY KEY (ssn, dno),
    FOREIGN KEY (dno) REFERENCES (Departments),
    FOREIGN KEY (ssn) REFERENCES (Employees)
)

CREATE TABLE Manages (
    dno INTEGER,
    ssn TEXT,
    PRIMARY KEY (dno),
    FOREIGN KEY (dno) REFERENCES (Departments),
    FOREIGN KEY (ssn) REFERENCES (Employees)
)

CREATE TABLE Employees (
    ssn TEXT,
    salary INTEGER,
    phone INTEGER,
    PRIMARY KEY (ssn)
)

CREATE TABLE Child (
    name TEXT,
    age INTEGER,
    PRIMARY KEY (name)
        ON DELETE CASCADE
)

CREATE TABLE Dependent (
    ssn TEXT NOT NULL,
    name TEXT,
    PRIMARY KEY (ssn),
    FOREIGN KEY (ssn) REFERENCES (Employees)
        ON DELETE CASCADE
)
```

# 3° Esercizio:
![Immagine terzo esercizio](https://image.ibb.co/javpPf/Schermata-2018-11-15-alle-19-20-59.png)

```SQL
CREATE TABLE Employees (
    ssn TEXT, 
    union_mem_no INTEGER,
    PRIMARY KEY (ssn)
)

CREATE TABLE Traffic_controls (
    exam_date DATE,
    ssn TEXT,
    union_mem_no INTEGER,
    PRIMARY KEY (ssn),
    FOREIGN KEY (ssn) REFERENCES (Employees)
        ON DELETE CASCADE
)

CREATE TABLE Technician (
    phone_num INTEGER,
    address TEXT,
    name TEXT, 
    salary INTEGER,
    ssn TEXT,
    union_mem_no INTEGER,
    PRIMARY KEY (ssn),
    FOREIGN KEY (ssn) REFERENCES (Employees), 
        ON DELETE CASCADE
)

CREATE TABLE Expert (
    ssn TEXT,
    model_no INTEGER, 
    PRIMARY KEY (ssn, model_no),
    FOREIGN KEY (ssn) REFERENCES (Technicians),
    FOREIGN KEY (model_no) REFERENCES (Models)
)

CREATE TABLE Models (
    model_no INTEGER,
    capacity INTEGER,
    weight INTEGER,
    PRIMARY KEY (model_no)
)

CREATE TABLE Plane (
    reg_no INTEGER,
    PRIMARY KEY (reg_no)
)

CREATE TABLE Type (
    mode_no INTEGER,
    reg_no INTEGER,
    PRIMARY KEY (model_no),
    FOREIGN KEY (reg_no) REFERENCES (Plane),
    FOREIGN KEY (mode_no) REFERENCES (Models)
)

CREATE TABLE Test_Infos (
    score INTEGER,
    hours TIME,
    date DATE,
    reg_no INTEGER,
    FAA_no INTEGER,
    PRIMARY KEY (reg_no, FAA_no),
    FOREIGN KEY (reg_no) REFERENCES (Plane),
    FOREIGN KEY (FAA_no) REFERENCES (Test)
)

CREATE TABLE Tests (
    name TEXT, 
    score INTEGER,
    FAA_no INTEGER,
    PRIMARY KEY (FAA_no)
)
```

# 4° Esercizio:
![Immagine quarto esercizio](https://image.ibb.co/kRcxh0/Schermata-2018-11-17-alle-16-28-22.png)


```SQL
CREATE TABLE Artwork (
    title TEXT, 
    year INTEGER,
    type TEXT, 
    price INTEGER, 
    PRIMARY KEY (title)
)

CREATE TABLE Paints (
    title TEXT NOT NULL, 
    name TEXT,
    birthplace TEXT, 
    age INTEGER,
    style TEXT,
    PRIMARY KEY (name),
    FOREIGN KEY (title) REFERENCES (Artwork)
        ON DELETE NO ACTION
)

CREATE TABLE Artist (
    name TEXT,
    birthplace TEXT, 
    age INTEGER,
    style TEXT,
    PRIMARY KEY (name)
)

CREATE TABLE Classify (
    title TEXT,
    name TEXT,
    PRIMARY KEY (tite, name),
    FOREIGN KEY (title) REFERENCES (Artwork),
    FOREIGN KEY (name) REFERENCES (Group) 
)

CREATE TABLE Group (
    name TEXT, 
    PRIMARY KEY (name)
)

CREATE TABLE Like_Group (
    name TEXT,
    cust_id INTEGER,
    PRIMARY KEY (name, cust_id),
    FOREIGN KEY (cust_id) REFERENCES (Customer),
    FOREIGN KEY (name) REFERENCES (Group) 
)

CREATE TABLE Like_Artist (
    cust_id INTEGER,
    name TEXT,
    FOREIGN KEY (cust_id) REFERENCES (Customer),
    FOREIGN KEY (name) REFERENCES (Artist) 
)
```

