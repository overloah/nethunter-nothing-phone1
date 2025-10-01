# 📱 Installation Guide - Nothing Phone 1 NetHunter

## ⚠️ Prerequisites

- **Nothing Phone 1 (Spacewar)** with **unlocked bootloader**
- **ADB/Fastboot tools** properly installed
- **USB Debugging** enabled in Developer Options
- **⚠️ WARNING:** This modification **voids warranty**

## 🚀 Installation Process

### Step 1: Download NetHunter Kernel

Download latest release

wget https://github.com/overloah/nethunter-nothing-phone1/releases/latest/download/nethunter-spacewar-kernel.gz
Verify integrity (optional but recommended)

sha256sum nethunter-spacewar-kernel.gz

text

### Step 2: Enable Developer Features

On Nothing Phone 1:
Settings → About Phone → Build Number (tap 7 times)
Settings → System → Advanced → Developer Options
Enable "USB Debugging"
Enable "OEM Unlocking" (if not done during bootloader unlock)

text

### Step 3: Flash NetHunter Kernel

Connect phone via USB

adb devices # Verify connection
Reboot to bootloader

adb reboot bootloader
Verify fastboot connection

fastboot devices
Flash NetHunter kernel

fastboot flash boot nethunter-spacewar-kernel.gz
Reboot to system

fastboot reboot

text

### Step 4: Install NetHunter App
1. Download from [Kali NetHunter Store](https://store.nethunter.com/)
2. Install: `adb install NetHunter.apk`
3. Open app and grant **all permissions**
4. Initialize NetHunter services

## ✅ Post-Installation Verification

### Verify NetHunter Features

Check HID gadget (as root)

su -c "ls /config/usb_gadget/"
Verify wireless monitor mode capability

su -c "iw list | grep monitor"
Check TUN/TAP interfaces

su -c "ip tuntap show"
Test NetHunter core

su -c "nethunter"

text

### Expected Results
- ✅ USB HID gadget configuration available
- ✅ Wireless monitor mode supported
- ✅ TUN/TAP interfaces functional
- ✅ NetHunter app recognizes all kernel features

## 🔄 Backup & Recovery

### Create Backup (BEFORE installation)

Dump current boot partition

adb shell su -c "dd if=/dev/block/bootdevice/by-name/boot of=/sdcard/original_boot.img"
adb pull /sdcard/original_boot.img

text

### Restore Original Boot

If you experience issues, restore original boot

fastboot flash boot original_boot.img
fastboot reboot

text

## 🆘 Troubleshooting

| Issue | Solution |
|-------|----------|
| **Boot Loop** | Flash original boot image |
| **No NetHunter Features** | Check app permissions & root access |
| **USB Not Detected** | Try different cable/USB port |
| **Fastboot Errors** | Update platform-tools, check drivers |
| **App Crashes** | Clear app data, reinstall |

See [TROUBLESHOOTING.md](TROUBLESHOOTING.md) for comprehensive solutions.

---

Professional NetHunter deployment for Nothing Phone 1 - Use responsibly for authorized testing only.
ENDINSTALL
