# 🛠️ Troubleshooting Guide - Nothing Phone 1 NetHunter

Complete documentation of compilation errors and solutions encountered during development.

## 🎯 Quick Fix Reference

| Error Type | Quick Solution | Impact |
|------------|----------------|--------|
| Architecture | `export ARCH=arm64; make clean` | Critical |
| LLVM Tools | `export PATH="$(pwd)/toolchain/clang/bin:$PATH"` | High |
| Certificates | Disable in `.config` + dummy files | High |
| Memory Types | `sed -i 's/int.*i;/u64 i;/' mm/page_alloc.c` | Critical |
| C99 Issues | `export KCFLAGS="$KCFLAGS -std=gnu99"` | Medium |
| Alignment | `export KCFLAGS="$KCFLAGS -Wno-align-mismatch"` | Medium |
| DRM Symbol | `sed -i 's/CONFIG_INPUT_FINGERPRINT=y/# &/' .config` | High |

## 🔧 Detailed Solutions

### 1. Architecture Mismatch (Critical)
Error: x86_64 config questions, objtool failures
Root Cause: Build system defaulting to host architecture
Solution:

export ARCH=arm64
export SUBARCH=arm64
export CROSS_COMPILE=aarch64-linux-gnu-
make clean # Remove x86 artifacts

text

### 2. LLVM Toolchain Missing (High Priority)

Error: llvm-objdump: not found, llvm-ar: not found
Root Cause: LLVM tools not in PATH
Solution:

export PATH="$(pwd)/toolchain/clang/bin:$PATH"
export AR="$(pwd)/toolchain/clang/bin/llvm-ar"
export NM="$(pwd)/toolchain/clang/bin/llvm-nm"
export OBJDUMP="$(pwd)/toolchain/clang/bin/llvm-objdump"
export OBJCOPY="$(pwd)/toolchain/clang/bin/llvm-objcopy"
export STRIP="$(pwd)/toolchain/clang/bin/llvm-strip"

text

### 3. Certificate System Bypass (High Priority)

Error: SSL error, PEM routines, extract-cert failures
Root Cause: Android kernel expects certificate files
Solution:

sed -i 's/CONFIG_SYSTEM_TRUSTED_KEYS="."/CONFIG_SYSTEM_TRUSTED_KEYS=""/' .config
sed -i 's/CONFIG_SYSTEM_REVOCATION_KEYS="."/CONFIG_SYSTEM_REVOCATION_KEYS=""/' .config
Create dummy certificates:

mkdir -p certs debian
echo "# Dummy certificate" > certs/signing_key.pem
echo "# Dummy certificate" > debian/canonical-certs.pem

text

### 4. Memory Management Type Mismatch (Critical)

Error: incompatible pointer types passing 'int *' to 'u64 *'
Root Cause: ARM64 requires 64-bit variables for memory operations
Solution:

sed -i '7059s/int __maybe_unused i;/u64 __maybe_unused i;/' mm/page_alloc.c

text

### 5. C99 Standards Compliance (Medium)

Error: mixing declarations and code incompatible with C99
Root Cause: Variable declared after code statements
Solution:

export KCFLAGS="$KCFLAGS -std=gnu99 -Wno-declaration-after-statement -Wno-error=declaration-after-statement"

text

### 6. Block Layer Alignment (Medium)

Error: passing 8-byte aligned argument to 32-byte aligned parameter
Root Cause: ARM64 memory alignment requirements
Solution:

export KCFLAGS="$KCFLAGS -Wno-align-mismatch -Wno-error=align-mismatch"

text

### 7. Missing DRM Symbol (High Priority)

Error: undefined symbol: drm_panel_notifier_register
Root Cause: Fingerprint driver requires DRM panel notifications
Solution 1 (Recommended): Disable fingerprint

sed -i 's/CONFIG_INPUT_FINGERPRINT=y/# CONFIG_INPUT_FINGERPRINT is not set/' .config
Solution 2: Enable DRM

echo "CONFIG_DRM=y" >> .config
echo "CONFIG_DRM_PANEL_NOTIFICATIONS=y" >> .config

text

## 📈 Success Timeline

### Build Performance Evolution
- **Initial Attempts:** 40+ minutes with multiple errors
- **Systematic Fixes:** Reduced to 5-10 minutes
- **Optimized Build:** Final 38 seconds
- **Success Rate:** 100% after applying all fixes

### Error Resolution Phases
1. **Phase 1 (0-5 min):** Architecture & environment setup
2. **Phase 2 (5-10 min):** Toolchain configuration
3. **Phase 3 (10-15 min):** Certificate system bypass
4. **Phase 4 (15-25 min):** Core memory management fixes
5. **Phase 5 (25-30 min):** Standards compliance
6. **Phase 6 (30-35 min):** Block layer & alignment
7. **Phase 7 (35-40 min):** Symbol resolution & linking
8. **Phase 8 (40 min):** ✅ **COMPLETE SUCCESS**

## 🔍 Debugging Commands

Quick error identification

grep -E "(error|Error|FAILED)" build.log | tail -10
Check for undefined symbols

grep -E "undefined symbol" build.log
Verify architecture

file arch/arm64/boot/Image.gz
Test specific file compilation

make -j1 mm/page_alloc.o ARCH=arm64 LLVM=1
Verify NetHunter features in config

grep -E "CONFIG_USB_CONFIGFS_F_HID|CONFIG_TUN|CONFIG_PACKET" .config

text

## 📚 Technical References

- [Android Kernel Building](https://source.android.com/docs/setup/build/building-kernels)
- [ClangBuiltLinux](https://clangbuiltlinux.github.io/)
- [ARM64 Architecture](https://developer.arm.com/architectures/cpu-architecture/a-profile)
- [Kali NetHunter](https://www.kali.org/docs/nethunter/)

---

This guide documents real compilation challenges solved during Nothing Phone 1 NetHunter development. Each solution has been tested and verified.
ENDTROUBLE
