#!/usr/bin/env python3
import sys

try:
    from StringIO import StringIO
except ImportError:
    from io import StringIO

import random
import string
import time

import psycopg2


class Counter:
    def __init__(self):
        self.start = -1
        self.end = -1

    def start(self):
        pass


connection = psycopg2.connect("dbname='db_016' user='db_016' host='sci-didattica.unitn.it' password='faustoemagro'")

cur = connection.cursor()

# Statement 1
start = time.perf_counter_ns()

cur.execute("DROP TABLE IF EXISTS Car;"
            "DROP TABLE IF EXISTS Person;")

connection.commit()
end = time.perf_counter_ns()
print("Step 1 needs " + str(end - start) + "ns")

# Statement 2
start = time.perf_counter_ns()

cur.execute("CREATE TABLE Person ("
            "id INTEGER PRIMARY KEY,"
            "name CHAR(50) NOT NULL,"
            "address CHAR(50) NOT NULL,"
            "age INTEGER NOT NULL,"
            "height FLOAT NOT NULL);"
            "CREATE TABLE Car ("
            "targa CHAR(50) PRIMARY KEY,"
            "brand CHAR(50) NOT NULL,"
            "color CHAR(30) NOT NULL,"
            "owner INTEGER REFERENCES Person(id));")

connection.commit()
end = time.perf_counter_ns()
print("Step 2 needs " + str(end - start) + "ns")

# Statement 3
start = time.perf_counter_ns()
people_insertion = []

for i in range(0, 1000000):
    if i == 185000:
        continue

    name = "".join(
        random.choices(string.ascii_lowercase, k=12)
    )

    address = "".join(
        random.choices(string.ascii_lowercase, k=10)
    )

    age = random.randrange(0, 101)
    # people_insertion.append(str(i) + "\t" + name + "\t" + address + "\t" + str(age) + "\t" + str(i*0.001))
    people_insertion.append(f"{i}\t{name}\t{address}\t{age}\t{i*0.001}")

people_insertion.append("185000\t'Centottantacinque'\t'ViadeiSolteri97'\t1\t185")

data = StringIO()
data.write("\n".join(people_insertion))
data.seek(0)

cur.copy_from(data, "Person")

connection.commit()
end = time.perf_counter_ns()
print("Step 3 needs " + str(end - start) + "ns")

# Statement 4
start = time.perf_counter_ns()

car_insertion = []
plate_dict = {}

for i in range(0, 1000000):
    while True:
        targa = "".join(
            random.choices(string.ascii_uppercase + string.digits, k=10)
        )

        if targa in plate_dict:
            continue
        else:
            plate_dict[targa] = True
            break

    brand = "".join(
        random.choices(string.ascii_lowercase, k=10)
    )

    color = "".join(
        random.choices(string.ascii_lowercase, k=7)
    )

    # car_insertion.append(targa + "\t" + brand + "\t" + color + "\t" + str(i))
    car_insertion.append(f"{targa}\t{brand}\t{color}\t{i}")
    #print(f"{targa}\t{brand}\t{color}\t{i}")

data = StringIO()
data.write("\n".join(car_insertion))
data.seek(0)

cur.copy_from(data, "Car")

connection.commit()
end = time.perf_counter_ns()
print("Step 4 needs " + str(end - start) + "ns")


# Statement 5
start = time.perf_counter_ns()

cur.execute("SELECT id FROM Person")
data = cur.fetchall()

for item in data:
    print(item[0], file=sys.stderr)

end = time.perf_counter_ns()
print("Step 4 needs " + str(end - start) + "ns")


cur.close()
connection.close()
