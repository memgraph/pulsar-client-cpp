# Avoid multiple calls to find_package to append duplicated properties to the targets
include_guard()########### VARIABLES #######################################################################
#############################################################################################
set(pulsar-client-cpp_FRAMEWORKS_FOUND_RELEASE "") # Will be filled later
conan_find_apple_frameworks(pulsar-client-cpp_FRAMEWORKS_FOUND_RELEASE "${pulsar-client-cpp_FRAMEWORKS_RELEASE}" "${pulsar-client-cpp_FRAMEWORK_DIRS_RELEASE}")

set(pulsar-client-cpp_LIBRARIES_TARGETS "") # Will be filled later


######## Create an interface target to contain all the dependencies (frameworks, system and conan deps)
if(NOT TARGET pulsar-client-cpp_DEPS_TARGET)
    add_library(pulsar-client-cpp_DEPS_TARGET INTERFACE IMPORTED)
endif()

set_property(TARGET pulsar-client-cpp_DEPS_TARGET
             APPEND PROPERTY INTERFACE_LINK_LIBRARIES
             $<$<CONFIG:Release>:${pulsar-client-cpp_FRAMEWORKS_FOUND_RELEASE}>
             $<$<CONFIG:Release>:${pulsar-client-cpp_SYSTEM_LIBS_RELEASE}>
             $<$<CONFIG:Release>:protobuf::protobuf;abseil::abseil;boost::boost;CURL::libcurl;openssl::openssl;ZLIB::ZLIB;zstd::libzstd_static;Snappy::snappy;gtest::gtest>)

####### Find the libraries declared in cpp_info.libs, create an IMPORTED target for each one and link the
####### pulsar-client-cpp_DEPS_TARGET to all of them
conan_package_library_targets("${pulsar-client-cpp_LIBS_RELEASE}"    # libraries
                              "${pulsar-client-cpp_LIB_DIRS_RELEASE}" # package_libdir
                              "${pulsar-client-cpp_BIN_DIRS_RELEASE}" # package_bindir
                              "${pulsar-client-cpp_LIBRARY_TYPE_RELEASE}"
                              "${pulsar-client-cpp_IS_HOST_WINDOWS_RELEASE}"
                              pulsar-client-cpp_DEPS_TARGET
                              pulsar-client-cpp_LIBRARIES_TARGETS  # out_libraries_targets
                              "_RELEASE"
                              "pulsar-client-cpp"    # package_name
                              "${pulsar-client-cpp_NO_SONAME_MODE_RELEASE}")  # soname

# FIXME: What is the result of this for multi-config? All configs adding themselves to path?
set(CMAKE_MODULE_PATH ${pulsar-client-cpp_BUILD_DIRS_RELEASE} ${CMAKE_MODULE_PATH})

########## GLOBAL TARGET PROPERTIES Release ########################################
    set_property(TARGET pulsar-client-cpp::pulsar-client-cpp
                 APPEND PROPERTY INTERFACE_LINK_LIBRARIES
                 $<$<CONFIG:Release>:${pulsar-client-cpp_OBJECTS_RELEASE}>
                 $<$<CONFIG:Release>:${pulsar-client-cpp_LIBRARIES_TARGETS}>
                 )

    if("${pulsar-client-cpp_LIBS_RELEASE}" STREQUAL "")
        # If the package is not declaring any "cpp_info.libs" the package deps, system libs,
        # frameworks etc are not linked to the imported targets and we need to do it to the
        # global target
        set_property(TARGET pulsar-client-cpp::pulsar-client-cpp
                     APPEND PROPERTY INTERFACE_LINK_LIBRARIES
                     pulsar-client-cpp_DEPS_TARGET)
    endif()

    set_property(TARGET pulsar-client-cpp::pulsar-client-cpp
                 APPEND PROPERTY INTERFACE_LINK_OPTIONS
                 $<$<CONFIG:Release>:${pulsar-client-cpp_LINKER_FLAGS_RELEASE}>)
    set_property(TARGET pulsar-client-cpp::pulsar-client-cpp
                 APPEND PROPERTY INTERFACE_INCLUDE_DIRECTORIES
                 $<$<CONFIG:Release>:${pulsar-client-cpp_INCLUDE_DIRS_RELEASE}>)
    # Necessary to find LINK shared libraries in Linux
    set_property(TARGET pulsar-client-cpp::pulsar-client-cpp
                 APPEND PROPERTY INTERFACE_LINK_DIRECTORIES
                 $<$<CONFIG:Release>:${pulsar-client-cpp_LIB_DIRS_RELEASE}>)
    set_property(TARGET pulsar-client-cpp::pulsar-client-cpp
                 APPEND PROPERTY INTERFACE_COMPILE_DEFINITIONS
                 $<$<CONFIG:Release>:${pulsar-client-cpp_COMPILE_DEFINITIONS_RELEASE}>)
    set_property(TARGET pulsar-client-cpp::pulsar-client-cpp
                 APPEND PROPERTY INTERFACE_COMPILE_OPTIONS
                 $<$<CONFIG:Release>:${pulsar-client-cpp_COMPILE_OPTIONS_RELEASE}>)

########## For the modules (FindXXX)
set(pulsar-client-cpp_LIBRARIES_RELEASE pulsar-client-cpp::pulsar-client-cpp)
