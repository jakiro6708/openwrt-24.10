#!/usr/bin/python3
import os
# import re
import json

luciBase = {
    "admin/nas": {
        "title": "NAS",
        "order": 80,
        "action": {
            "type": "firstchild",
            "recurse": True
        }
    },
    "admin/nlbw": {
        "title": "Bandwidth Monitor",
        "order": 100,
        "action": {
            "type": "firstchild",
            "recurse": True
        }
    },
}

file = 'feeds/luci/modules/luci-base/root/usr/share/luci/menu.d/luci-base.json'

with open(file) as f:
    config = json.load(f)
# if 'admin/vpn' in config:
#     del config['admin/vpn']

s = {}
for i in config:
    s[i] = config[i]
    if i == 'admin/vpn':
        for j in luciBase:
            s[j] = luciBase[j]

# print(s)
with open(file, 'w') as f:
    json.dump(s, f, indent='\t')

applications = {
    'hd-idle': ['admin/services', 'admin/nas'],
}
# applications = {
#     'aria2': ['admin/services', 'admin/nas'],
#     'hd-idle': ['admin/services', 'admin/nas'],
# }
keys = applications.keys()

xx = []

cuts = ['/', '", "', "', '", ']], [[']


def readFile(file, k):
    a1 = k[0]
    a2 = k[1]
    f = open(file)
    s = f.read()
    f.close()
    for i in cuts:
        b1 = a1.replace('/', i)
        b2 = a2.replace('/', i)
        if b1 in s:
            s = s.replace(b1, b2)
            f = open(file, 'w')
            f.write(s)
            f.close()
            xx.append(file)
            print(file)


# a1 = 'admin/services'
# b1 = '"admin", "services"'

for r, dirs, files in os.walk('feeds'):
    for file in files:
        filepath = os.path.join(r, file)
        filedir = filepath.replace(file, '')
        for i in keys:
            if i in filedir:
                try:
                    readFile(filepath, applications[i])
                except Exception as e:
                    print(e)
                    pass

print(len(xx))
