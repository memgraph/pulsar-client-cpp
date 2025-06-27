########### AGGREGATED COMPONENTS AND DEPENDENCIES FOR THE MULTI CONFIG #####################
#############################################################################################

set(pulsar-client-cpp_COMPONENT_NAMES "")
if(DEFINED pulsar-client-cpp_FIND_DEPENDENCY_NAMES)
  list(APPEND pulsar-client-cpp_FIND_DEPENDENCY_NAMES protobuf absl Boost CURL OpenSSL ZLIB zstd Snappy GTest)
  list(REMOVE_DUPLICATES pulsar-client-cpp_FIND_DEPENDENCY_NAMES)
else()
  set(pulsar-client-cpp_FIND_DEPENDENCY_NAMES protobuf absl Boost CURL OpenSSL ZLIB zstd Snappy GTest)
endif()
set(protobuf_FIND_MODE "NO_MODULE")
set(absl_FIND_MODE "NO_MODULE")
set(Boost_FIND_MODE "NO_MODULE")
set(CURL_FIND_MODE "NO_MODULE")
set(OpenSSL_FIND_MODE "NO_MODULE")
set(ZLIB_FIND_MODE "NO_MODULE")
set(zstd_FIND_MODE "NO_MODULE")
set(Snappy_FIND_MODE "NO_MODULE")
set(GTest_FIND_MODE "NO_MODULE")

########### VARIABLES #######################################################################
#############################################################################################
set(pulsar-client-cpp_PACKAGE_FOLDER_RELEASE "/home/andi.linux/.conan2/p/b/pulsa18250a625a4d4/p")
set(pulsar-client-cpp_BUILD_MODULES_PATHS_RELEASE )


set(pulsar-client-cpp_INCLUDE_DIRS_RELEASE "${pulsar-client-cpp_PACKAGE_FOLDER_RELEASE}/include")
set(pulsar-client-cpp_RES_DIRS_RELEASE )
set(pulsar-client-cpp_DEFINITIONS_RELEASE )
set(pulsar-client-cpp_SHARED_LINK_FLAGS_RELEASE )
set(pulsar-client-cpp_EXE_LINK_FLAGS_RELEASE )
set(pulsar-client-cpp_OBJECTS_RELEASE )
set(pulsar-client-cpp_COMPILE_DEFINITIONS_RELEASE )
set(pulsar-client-cpp_COMPILE_OPTIONS_C_RELEASE )
set(pulsar-client-cpp_COMPILE_OPTIONS_CXX_RELEASE )
set(pulsar-client-cpp_LIB_DIRS_RELEASE "${pulsar-client-cpp_PACKAGE_FOLDER_RELEASE}/lib")
set(pulsar-client-cpp_BIN_DIRS_RELEASE )
set(pulsar-client-cpp_LIBRARY_TYPE_RELEASE STATIC)
set(pulsar-client-cpp_IS_HOST_WINDOWS_RELEASE 0)
set(pulsar-client-cpp_LIBS_RELEASE pulsar)
set(pulsar-client-cpp_SYSTEM_LIBS_RELEASE )
set(pulsar-client-cpp_FRAMEWORK_DIRS_RELEASE )
set(pulsar-client-cpp_FRAMEWORKS_RELEASE )
set(pulsar-client-cpp_BUILD_DIRS_RELEASE )
set(pulsar-client-cpp_NO_SONAME_MODE_RELEASE FALSE)


# COMPOUND VARIABLES
set(pulsar-client-cpp_COMPILE_OPTIONS_RELEASE
    "$<$<COMPILE_LANGUAGE:CXX>:${pulsar-client-cpp_COMPILE_OPTIONS_CXX_RELEASE}>"
    "$<$<COMPILE_LANGUAGE:C>:${pulsar-client-cpp_COMPILE_OPTIONS_C_RELEASE}>")
set(pulsar-client-cpp_LINKER_FLAGS_RELEASE
    "$<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,SHARED_LIBRARY>:${pulsar-client-cpp_SHARED_LINK_FLAGS_RELEASE}>"
    "$<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,MODULE_LIBRARY>:${pulsar-client-cpp_SHARED_LINK_FLAGS_RELEASE}>"
    "$<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,EXECUTABLE>:${pulsar-client-cpp_EXE_LINK_FLAGS_RELEASE}>")


set(pulsar-client-cpp_COMPONENTS_RELEASE )