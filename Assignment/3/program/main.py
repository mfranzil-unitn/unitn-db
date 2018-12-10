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

cur = connection.cursor()

# Statement 1
start = timer()

cur.execute("DROP TABLE IF EXISTS Car;"
            "DROP TABLE IF EXISTS Person;")

connection.commit()
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
            "owner INTEGER REFERENCES Person(id));")

connection.commit()
end = timer()
print("Step 2 needs " + str(end - start) + " ns")

# Statement 3
start = timer()
people_insertion = []
heights = {}

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

    while True:
        random.seed(i)
        height = round(random.uniform(80, 210), 4)

        if height not in heights and height != 185:
            heights[str(height)] = True
            break

    people_insertion.append(str(i) + "\t" + name + "\t" + address + "\t" + str(age) + "\t" + str(height))
    print(str(i) + "\t" + name + "\t" + address + "\t" + str(age) + "\t" + str(height))
    # people_insertion.append(f"{i}\t{name}\t{address}\t{age}\t{i*0.001}")

random.shuffle(people_insertion)
people_insertion.append("185000\tCentottantacinque\tViadeiSolteri97\t1\t185")

data = StringIO()
data.write("\n".join(people_insertion))
data.seek(0)

# with open("sample.txt", "w") as file:
#   file.write(data.getvalue())

cur.copy_from(data, "Person")

data.close()
connection.commit()
end = timer()
print("Step 3 needs " + str(end - start) + " ns")

# Statement 4
start = timer()

car_insertion = []
plate_dict = {}

for i in range(0, 1000000):
    while True:
        random.seed(i)
        targa = "".join(
            random.choices(string.ascii_uppercase + string.digits, k=10)
        )

        if targa not in plate_dict:
            plate_dict[targa] = True
            break

    brand = "".join(
        random.choices(string.ascii_lowercase, k=10)
    )

    color = "".join(
        random.choices(string.ascii_lowercase, k=7)
    )

    car_insertion.append(targa + "\t" + brand + "\t" + color + "\t" + str(i))
    # car_insertion.append(f"{targa}\t{brand}\t{color}\t{i}")
    print(f"{targa}\t{brand}\t{color}\t{i}")

random.shuffle(car_insertion)

data = StringIO()
data.write("\n".join(car_insertion))
data.seek(0)

cur.copy_from(data, "Car")

connection.commit()
end = timer()
print("Step 4 needs " + str(end - start) + " ns")

# Statement 5
start = timer()

cur.execute("SELECT id FROM Person")
data = cur.fetchall()

for item in data:
    print(item[0], file=sys.stderr)

connection.commit()
end = timer()
sys.stderr.flush()
print("Step 5 needs " + str(end - start) + " ns")

# Statement 6
start = timer()

cur.execute("UPDATE Person SET height = 200 WHERE height = 185")

connection.commit()
end = timer()
print("Step 6 needs " + str(end - start) + " ns")

# Statement 7
start = timer()

cur.execute("SELECT * FROM Person WHERE height = 200")
data = cur.fetchall()

for item in data:
    print(str(item[0]) + "," + str(item[1]), file=sys.stderr)

connection.commit()
end = timer()
sys.stderr.flush()
print("Step 7 needs " + str(end - start) + " ns")

# Statement 8
start = timer()

cur.execute("CREATE INDEX height_idx ON Person (height)")

connection.commit()
end = timer()
print("Step 8 needs " + str(end - start) + " ns")

# Statement 9
start = timer()

cur.execute("SELECT id FROM Person")
data = cur.fetchall()

for item in data:
    print(item[0], file=sys.stderr)

connection.commit()
end = timer()
sys.stderr.flush()
print("Step 9 needs " + str(end - start) + " ns")

# Statement 10
start = timer()

cur.execute("UPDATE Person SET height = 210 WHERE height = 200")

connection.commit()
end = timer()
print("Step 10 needs " + str(end - start) + " ns")

# Statement 11
start = timer()

cur.execute("SELECT * FROM Person WHERE height = 210")
data = cur.fetchall()

for item in data:
    print(str(item[0]) + "," + str(item[1]), file=sys.stderr)

connection.commit()
end = timer()
sys.stderr.flush()
print("Step 11 needs " + str(end - start) + " ns")

cur.close()
connection.close()
