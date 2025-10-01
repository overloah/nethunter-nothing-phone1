copy paste this

# Professional NetHunter Build Script for Nothing Phone 1
# Includes all discovered fixes and optimizations

set -e

echo "🚀 NetHunter Kernel Build for Nothing Phone 1"
echo "=============================================="
echo "Target: Nothing Phone 1 (Spacewar) - Snapdragon 778G"
echo "Architecture: ARM64 with LTO optimization"
echo ""

# Environment setup with all discovered fixes
export ARCH=arm64
export SUBARCH=arm64
export CROSS_COMPILE=aarch64-linux-gnu-
export PATH="$(pwd)/toolchain/clang/bin:$PATH"

# Complete compiler flags (from troubleshooting guide)
export KCFLAGS="-Wno-error -Wno-unused-variable -Wno-incompatible-pointer-types -Wno-align-mismatch -Wno-declaration-after-statement -std=gnu99"

# LLVM toolchain (required for ARM64 optimization)
export AR="$(pwd)/toolchain/clang/bin/llvm-ar"
export NM="$(pwd)/toolchain/clang/bin/llvm-nm"
export OBJDUMP="$(pwd)/toolchain/clang/bin/llvm-objdump"
export OBJCOPY="$(pwd)/toolchain/clang/bin/llvm-objcopy"
export STRIP="$(pwd)/toolchain/clang/bin/llvm-strip"

echo "✅ Build environment configured with all fixes"

# Configuration management
if [ -f "configs/nethunter-spacewar.config" ]; then
    cp configs/nethunter-spacewar.config .config
    echo "✅ NetHunter configuration loaded"
else
    echo "⚠️  Using default configuration"
fi

make olddefconfig

# Professional build with timing
echo "🔨 Building NetHunter kernel..."
echo "Started: $(date)"
echo ""

time make -j$(nproc) \
    ARCH=arm64 \
    LLVM=1 \
    KCFLAGS="$KCFLAGS" \
    AR="$AR" \
    NM="$NM" \
    OBJDUMP="$OBJDUMP" \
    OBJCOPY="$OBJCOPY" \
    STRIP="$STRIP" \
    2>&1 | tee "build-$(date +%Y%m%d-%H%M%S).log"

# Success verification
if [ -f "arch/arm64/boot/Image.gz" ]; then
    echo ""
    echo "🎉🎉🎉 BUILD SUCCESSFUL! 🎉🎉🎉"
    echo "================================="
    echo ""
    echo "📱 Device: Nothing Phone 1 (Spacewar)"
    echo "🔧 Kernel: $(ls -lh arch/arm64/boot/Image.gz | awk '{print $5}') optimized"
    echo "⏰ Completed: $(date)"
    echo "🏗️ Architecture: ARM64 with LTO"
    echo ""
    echo "🎯 NetHunter kernel ready for deployment!"
    
    # Update release artifact
    [ -d "releases" ] && cp arch/arm64/boot/Image.gz releases/nethunter-spacewar-kernel.gz && echo "✅ Release updated"
    
    echo ""
    echo "📦 Ready for flashing to Nothing Phone 1!"
else
    echo ""
    echo "❌ BUILD FAILED"
    echo "==============="
    echo "Check build log and troubleshooting documentation"
    exit 1
fi
ENDSCRIPT
