#!/usr/bin/env python

import subprocess


def getIpAddress():
    output = subprocess.run(['ip', 'addr'], capture_output=True, text=True)
    output = output.stdout
    output = output.split('\n')
    print('Finding ip address...')
    for contents in output:
        if ('192.168' in contents):
            print('ip address found.')
            ip_address = contents.split(' ')
            for ip in ip_address:
                if('/' in ip):
                    ip_address = ip.split('/')[0]
                    print('updating ip address...')
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
                    print('ip address updated successfully.')
                    exit(0)
            print('Something went wrong!!!')
            exit(2)
    print('ip address not found!!!')
    exit(1)


getIpAddress()
