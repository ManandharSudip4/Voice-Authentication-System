import imp
import sys
import json
import time

user = sys.argv[1]
file = sys.argv[2]
isUser = False
if (user == "lethal"):
    isUser = True

data = {
    "isUser": isUser
}
time.sleep(2)
data = json.dumps(data)
print(data)
sys.stdout.flush()