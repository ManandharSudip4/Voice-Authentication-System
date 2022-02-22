from asyncio import subprocess
from ipaddress import ip_address
import ipaddress
import sys
import os
import subprocess

def getIpAddress():
    output = subprocess.run(['ip', 'addr'], capture_output=True, text=True)
    output = output.stdout
    output = output.split('\n')
    for contents in output:
        if ('192.168' in contents):
            ip_address = contents.split(' ')
            for ip in ip_address:
                if('/' in ip):
                    ip_address = ip.split('/')[0]
                    with open('./backend/node_api/config.json', 'r') as f:
                        data = f.read()
                    lines = data.split('\n')
                    for line in lines:
                        if '"ip_addr":' in line:
                            text = '    "ip_addr": "' + ip_address + '",'
                            data = data.replace(line, text)
                            with open('./backend/node_api/config.json', 'w') as f:
                                f.write(data)
                            break
                    with open('./frontend/voice_auth_application/lib/config.dart', 'w') as f:
                        text = 'const String ipAddr = "http://' + ip_address + ':8000";'
                        f.write(text) 
                    break
getIpAddress()