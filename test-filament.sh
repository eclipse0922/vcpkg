#!/bin/bash
set -e

echo "Testing unofficial-filament port..."

# Test 1: Check if port can be found
echo "1. Checking if port exists..."
if [ -d "ports/unofficial-filament" ]; then
    echo "   ✓ Port directory exists"
else
    echo "   ✗ Port directory not found"
    exit 1
fi

# Test 2: Check vcpkg.json
echo "2. Checking vcpkg.json..."
if grep -q '"name": "unofficial-filament"' ports/unofficial-filament/vcpkg.json; then
    echo "   ✓ Package name is correct"
else
    echo "   ✗ Package name is incorrect"
    exit 1
fi

# Test 3: Check portfile doesn't have compiler override
echo "3. Checking compiler override removed..."
if grep -q "vcpkg_find_acquire_program(CLANG)" ports/unofficial-filament/portfile.cmake; then
    echo "   ✗ Compiler override still present"
    exit 1
else
    echo "   ✓ Compiler override removed"
fi

# Test 4: Check usage file
echo "4. Checking usage file..."
if grep -q "unofficial-filament" ports/unofficial-filament/usage; then
    echo "   ✓ Usage file updated"
else
    echo "   ✗ Usage file not updated"
    exit 1
fi

echo ""
echo "All basic checks passed! The port structure looks correct."
echo ""
echo "Summary of changes:"
echo "- Renamed to unofficial-filament"
echo "- Removed hardcoded compiler selection"
echo "- Updated CMake config for unofficial namespace"
echo "- Fixed target issues in FindFilament patch"