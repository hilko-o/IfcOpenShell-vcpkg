# IfcOpenShell-vcpkg
Testing [vcpkg](https://vcpkg.io/en/)-port for [IfcOpenShell](https://github.com/IfcOpenShell/IfcOpenShell).

## Prerequisites
[Vcpkg-Setup](https://learn.microsoft.com/en-us/vcpkg/get_started/get-started?pivots=shell-cmd)

After setting up vcpkg (the VCPKG_ROOT path must be set) and cloning this repository, copy all files in the `vcpkg_port` directory to `${VCPKG_ROOT}/ports/ifcopenshell` and run:
```
vcpkg install ifcopenshell
```
For compile-time reasons, schemas are currently reduced to IFC2x3 but can be easily changed in the `portfile.cmake`.

## Testing

From the root directory of this repository, run:
```
cmake --preset <configure-preset-name> && cmake --build --preset <build-preset-name>
```
Use a preset suitable for the target machine, for example, on Windows:
```
cmake --preset x64-Debug-MSVC && cmake --build --preset x64-Debug-MSVC-Build
```
No tests have been performed yet for macOS and Linux.
