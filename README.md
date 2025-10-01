# NetHunter Kernel for Nothing Phone 1

Professional NetHunter kernel for Nothing Phone 1 (Spacewar) with Snapdragon 778G.

## Features
- USB HID Gadget (BadUSB attacks)
- Wireless Monitor Mode  
- Packet Injection capabilities
- TUN/TAP VPN support
- Bluetooth penetration testing
- Advanced Netfilter support

## Installation

Download and flash

wget https://github.com/overloah/nethunter-nothing-phone1/releases/latest/download/nethunter-spacewar-kernel.gz
adb reboot bootloader
fastboot flash boot nethunter-spacewar-kernel.gz
fastboot reboot

## Documentation
- [Troubleshooting Guide](docs/TROUBLESHOOTING.md)
- [Installation Guide](docs/INSTALLATION.md)  
- [Build Script](scripts/build-kernel.sh)

## Technical Details
- **Architecture:** ARM64 with LTO optimization
- **Target:** Nothing Phone 1 (Spacewar)
- **SoC:** Snapdragon 778G (SM7325)
- **Kernel:** 5.4.147-nethunter-spacewar
- **Status:** Production ready

## 🛠️ **BadUSB Tools Included**

### Ready-to-Use Payloads
- **Windows Recon** - System information gathering
- **Linux Terminal** - Command execution
- **Custom Generator** - Create your own payloads

### Usage

Generate payloads

python3 tools/badusb-generator.py
Deploy to NetHunter device

adb push tools/ /data/local/nethunter/

**Complete penetration testing arsenal for Nothing Phone 1!**

Built with precision for the security research community.
