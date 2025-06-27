########## MACROS ###########################################################################
#############################################################################################

# Requires CMake > 3.15
if(${CMAKE_VERSION} VERSION_LESS "3.15")
    message(FATAL_ERROR "The 'CMakeDeps' generator only works with CMake >= 3.15")
endif()

if(pulsar-client-cpp_FIND_QUIETLY)
    set(pulsar-client-cpp_MESSAGE_MODE VERBOSE)
else()
    set(pulsar-client-cpp_MESSAGE_MODE STATUS)
endif()

include(${CMAKE_CURRENT_LIST_DIR}/cmakedeps_macros.cmake)
include(${CMAKE_CURRENT_LIST_DIR}/pulsar-client-cppTargets.cmake)
include(CMakeFindDependencyMacro)

check_build_type_defined()

foreach(_DEPENDENCY ${pulsar-client-cpp_FIND_DEPENDENCY_NAMES} )
    # Check that we have not already called a find_package with the transitive dependency
    if(NOT ${_DEPENDENCY}_FOUND)
        find_dependency(${_DEPENDENCY} REQUIRED ${${_DEPENDENCY}_FIND_MODE})
    endif()
endforeach()

set(pulsar-client-cpp_VERSION_STRING "2.8.1")
set(pulsar-client-cpp_INCLUDE_DIRS ${pulsar-client-cpp_INCLUDE_DIRS_RELEASE} )
set(pulsar-client-cpp_INCLUDE_DIR ${pulsar-client-cpp_INCLUDE_DIRS_RELEASE} )
set(pulsar-client-cpp_LIBRARIES ${pulsar-client-cpp_LIBRARIES_RELEASE} )
set(pulsar-client-cpp_DEFINITIONS ${pulsar-client-cpp_DEFINITIONS_RELEASE} )


# Only the last installed configuration BUILD_MODULES are included to avoid the collision
foreach(_BUILD_MODULE ${pulsar-client-cpp_BUILD_MODULES_PATHS_RELEASE} )
    message(${pulsar-client-cpp_MESSAGE_MODE} "Conan: Including build module from '${_BUILD_MODULE}'")
    include(${_BUILD_MODULE})
endforeach()


