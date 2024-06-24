cmake_minimum_required(VERSION 3.21)

project(IFCOS_VCPKG_TEST VERSION 0.0.1)

######################### Compiler Settings ########################
set(CMAKE_CXX_STANDARD 17)
set(CMAKE_EXPORT_COMPILE_COMMANDS TRUE)

## Set SCHEMA_SEQ for IfcParseExamples
set(SCHEMA_VERSIONS "2x3")

foreach(schema ${SCHEMA_VERSIONS})
  add_definitions(-DHAS_SCHEMA_${schema})
endforeach()

string(REPLACE ";" ")(" schema_version_seq "(${SCHEMA_VERSIONS})")
add_definitions(-DSCHEMA_SEQ=${schema_version_seq})

############################# Packages #############################
find_package(Boost REQUIRED COMPONENTS system)
find_package(Boost REQUIRED COMPONENTS program_options)
find_package(Boost REQUIRED COMPONENTS regex)
find_package(Boost REQUIRED COMPONENTS thread)
find_package(OpenCASCADE CONFIG REQUIRED)
if(OpenCASCADE_FOUND)
    message(STATUS "${OpenCASCADE_INCLUDE_DIR}")
    message(STATUS "${OpenCASCADE_LIBRARY_DIR}")
endif()
find_package(IfcOpenShell CONFIG REQUIRED)

########################### EXAMPLES ###########################
########################### IFCPARSE ###########################
add_executable(IfcParseExamples IfcParseExamples.cpp) 
target_link_libraries(IfcParseExamples PRIVATE
    IfcOpenShell::IfcParse
)
########################### IFCPARSE ###########################

########################### IFCGEOM ###########################
add_executable(IfcOpenHouse IfcOpenHouse.cpp) 

target_include_directories(IfcOpenHouse PRIVATE
     ${OpenCASCADE_INCLUDE_DIR}
)

target_link_libraries(IfcOpenHouse PRIVATE
    IfcOpenShell::IfcParse
    IfcOpenShell::IfcGeom
    IfcOpenShell::geometry_kernel_opencascade
    IfcOpenShell::geometry_mapping_ifc2x3
    IfcOpenShell::geometry_serializer
    IfcOpenShell::geometry_serializer_ifc2x3
    # IfcOpenShell::Serializers
    # IfcOpenShell::Serializers_ifc2x3
)

################################################################
add_executable(IfcAdvancedHouse IfcAdvancedHouse.cpp) 

target_include_directories(IfcAdvancedHouse PRIVATE
     ${OpenCASCADE_INCLUDE_DIR}
)

target_link_libraries(IfcAdvancedHouse PRIVATE
    IfcOpenShell::IfcParse
    IfcOpenShell::IfcGeom
    IfcOpenShell::geometry_kernel_opencascade
    IfcOpenShell::geometry_mapping_ifc2x3
    IfcOpenShell::geometry_serializer
    IfcOpenShell::geometry_serializer_ifc2x3
    # IfcOpenShell::Serializers
    # IfcOpenShell::Serializers_ifc2x3
)
########################### IFCGEOM ###########################

###################### COMPILE COMMANDS #######################
add_custom_command(TARGET IfcParseExamples 
    COMMAND ${CMAKE_COMMAND} -E create_symlink "${CMAKE_BINARY_DIR}/compile_commands.json" "${CMAKE_SOURCE_DIR}/compile_commands.json" 
    DEPENDS compile_commands.json
    VERBATIM ON
)
add_custom_command(TARGET IfcParseExamples POST_BUILD
    COMMAND echo "Created symlink pointing to `compile_commands.json`"
    DEPENDS compile_commands.json
    VERBATIM ON
)
