#!/usr/bin/env python3

import random
import string
import sys
import time

import psycopg2

try:
    from StringIO import StringIO
except ImportError:
    from io import StringIO

if sys.version_info >= (3, 7):
    def timer():
        return time.perf_counter_ns()

elif sys.version_info >= (3, 3):
    def timer():
        return time.perf_counter() * (10 ** 9)

else:
    def timer():
        return time.clock() * (10 ** 9)

connection = psycopg2.connect("dbname='db_016' user='db_016' host='sci-didattica.unitn.it' password='faustoemagro'")
connection.autocommit = True
cur = connection.cursor()

# Statement 1
start = timer()

cur.execute("DROP TABLE IF EXISTS Car;"
            "DROP TABLE IF EXISTS Person;")

end = timer()
print("Step 1 needs " + str(end - start) + " ns")

# Statement 2
start = timer()

cur.execute("CREATE TABLE Person ("
            "id INTEGER PRIMARY KEY,"
            "name CHAR(50) NOT NULL,"
            "address CHAR(50) NOT NULL,"
            "age INTEGER NOT NULL,"
            "height FLOAT NOT NULL);"
            "CREATE TABLE Car ("
            "targa CHAR(25) PRIMARY KEY,"
            "brand CHAR(50) NOT NULL,"
            "color CHAR(30) NOT NULL,"
            "owner INTEGER REFERENCES Person(id) NOT NULL);")

end = timer()
print("Step 2 needs " + str(end - start) + " ns")

# Statement 3
start = timer()
people_insertion = []

# Set per le chiavi e le altezze
heights = set()
keys_list = list(range(1000000))
random.shuffle(keys_list)

for i in range(999999):
    key = keys_list[i]

    # Genero il nome completamente a caso
    name = "".join(
        random.choices(string.ascii_lowercase, k=12)
    )

    # Idem per l'indirizzo
    address = "".join(
        random.choices(string.ascii_lowercase, k=10)
    )

    # E pure per l'altezza
    age = random.randrange(18, 100)

    # Genero casualmente l'altezza tenendo traccia di quelle già create
    while True:
        height = round(random.uniform(80, 210), 4)

        if height not in heights and abs(185 - height) > 10e-4:
            heights.add(height)
            break

    people_insertion.append(str(key) + "\t" + name + "\t" + address + "\t" + str(age) + "\t" + str(height))
    print(str(key) + "\t" + name + "\t" + address + "\t" + str(age) + "\t" + str(height))
    # people_insertion.append(f"{i}\t{name}\t{address}\t{age}\t{i*0.001}")

# Generazione della chiave per la tupla con altezza 185
key185 = keys_list[999999]

# Inserisco la tupla con valore 185 in altezza
people_insertion.append(str(key185) + "\t"
                        +  "".join(random.choices(string.ascii_lowercase, k=12)) + "\t"
                        +  "".join(random.choices(string.ascii_lowercase, k=10)) + "\t"
                        +  str(random.randrange(18, 100)) + "\t185")

data = StringIO()
data.write("\n".join(people_insertion))
data.seek(0)

# Inserisco i dati
cur.copy_from(data, "Person")

data.close()
end = timer()
print("Step 3 needs " + str(end - start) + " ns")

# Statement 4
start = timer()

car_insertion = []

def targa(item, seq):
    item *= 26
    d0 = item // (26 ** 4)
    d1 = (item % 26 ** 4) // 26 ** 3
    d2 = (item % 26 ** 3) // 26 ** 2
    d3 = (item % 26 ** 2) // 26
    return chr(ord('A') + d0) + chr(ord('A') + d1) + str(seq).zfill(3) + chr(ord('A') + d2) + chr(ord('A') + d3)

plates = list({targa(count // 26, count % 26) for count in range(1000000)})

random.shuffle(keys_list)
random.shuffle(plates)

assert(len(plates) == 1000000)

for i in range(0, 1000000):
    targa = plates[i]

    brand = "".join(
        random.choices(string.ascii_lowercase, k=7)
    )

    color = "".join(
        random.choices(string.ascii_lowercase, k=7)
    )

    # Estraggo a caso un oggetto dalla lista delle chiavi
    fk = keys_list[i]

    car_insertion.append(targa + "\t" + brand + "\t" + color + "\t" + str(fk))
    # car_insertion.append(f"{targa}\t{brand}\t{color}\t{i}")
    print(f"{targa}\t{brand}\t{color}\t{fk}")

data = StringIO()
data.write("\n".join(car_insertion))
data.seek(0)

cur.copy_from(data, "Car")

end = timer()
print("Step 4 needs " + str(end - start) + " ns")

# Statement 5
start = timer()

cur.execute("SELECT id FROM Person")
data = cur.fetchall()

for item in data:
    print(item[0], file=sys.stderr)

end = timer()
sys.stderr.flush()
print("Step 5 needs " + str(end - start) + " ns")

# Statement 6
start = timer()

cur.execute("UPDATE Person SET height = 200 WHERE height = 185")

end = timer()
print("Step 6 needs " + str(end - start) + " ns")

# Statement 7
start = timer()

cur.execute("SELECT id, address FROM Person WHERE height = 200")
data = cur.fetchall()

for item in data:
    print(str(item[0]) + "," + str(item[1]), file=sys.stderr)

end = timer()
sys.stderr.flush()
print("Step 7 needs " + str(end - start) + " ns")

# Statement 8
start = timer()

cur.execute("CREATE INDEX height_idx ON Person USING btree (height)")

end = timer()
print("Step 8 needs " + str(end - start) + " ns")

# Statement 9
start = timer()

cur.execute("SELECT id FROM Person")
data = cur.fetchall()

for item in data:
    print(item[0], file=sys.stderr)

end = timer()
sys.stderr.flush()
print("Step 9 needs " + str(end - start) + " ns")

# Statement 10
start = timer()

cur.execute("UPDATE Person SET height = 210 WHERE height = 200")

end = timer()
print("Step 10 needs " + str(end - start) + " ns")

# Statement 11
start = timer()

cur.execute("SELECT id, address FROM Person WHERE height = 210")
data = cur.fetchall()

for item in data:
    print(str(item[0]) + "," + str(item[1]), file=sys.stderr)

end = timer()
sys.stderr.flush()
print("Step 11 needs " + str(end - start) + " ns")

cur.close()
connection.close()
