from python import *

with open("config.txt", "r") as file:
    ip = file.readline().strip()
    password = file.readline().strip()
    port = int(file.readline().strip())
setup(ip, password, port)


from src.load import *
