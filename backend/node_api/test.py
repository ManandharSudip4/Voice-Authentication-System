import sys
import json
dome = {
    "isUser": True,
    "user": sys.argv[1],
    "file": sys.argv[2]
}
data = json.dumps(dome)
print(data)
sys.stdout.flush()