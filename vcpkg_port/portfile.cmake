vcpkg_check_linkage(ONLY_STATIC_LIBRARY)

vcpkg_from_github(
    OUT_SOURCE_PATH SOURCE_PATH
    REPO IfcOpenShell/IfcOpenShell
    REF e295d596feb7b547ec597c0d73bcdfd3097802f3
    SHA512 0d289df80797b5cbbeb5fa267fcaa9492201c17de6b7e70292986986ea4359639abb18c443f5d13cab30874102254ad43cc1c17493f927bd88601f74f7836db2
    HEAD_REF v0.8.0
    PATCHES
        "find-opencascade.patch"
        "opencascade-debug-lib-postfix.patch"
        "package-config-and-install.patch"
        "remove-convert-executable.patch"
)

file(COPY "${CMAKE_CURRENT_LIST_DIR}/Config.cmake.in" DESTINATION "${SOURCE_PATH}/cmake")

vcpkg_cmake_configure(
    SOURCE_PATH "${SOURCE_PATH}/cmake"
    OPTIONS
        -DMINIMAL_BUILD=ON
        -DBUILD_CONVERT=ON
        -DBUILD_EXAMPLES=OFF
        -DCITYJSON_SUPPORT=OFF
        "-DSCHEMA_VERSIONS=2x3"
        #"-DSCHEMA_VERSIONS=2x3;4"
)

vcpkg_cmake_install()

vcpkg_cmake_config_fixup(PACKAGE_NAME "IfcOpenShell" CONFIG_PATH "lib/cmake")

file(REMOVE_RECURSE "${CURRENT_PACKAGES_DIR}/debug/include")

vcpkg_install_copyright(FILE_LIST "${SOURCE_PATH}/COPYING" "${SOURCE_PATH}/COPYING.LESSER")

configure_file("${CMAKE_CURRENT_LIST_DIR}/usage" "${CURRENT_PACKAGES_DIR}/share/${PORT}/usage" COPYONLY)
