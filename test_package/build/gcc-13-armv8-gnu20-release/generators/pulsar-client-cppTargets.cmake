# Load the debug and release variables
file(GLOB DATA_FILES "${CMAKE_CURRENT_LIST_DIR}/pulsar-client-cpp-*-data.cmake")

foreach(f ${DATA_FILES})
    include(${f})
endforeach()

# Create the targets for all the components
foreach(_COMPONENT ${pulsar-client-cpp_COMPONENT_NAMES} )
    if(NOT TARGET ${_COMPONENT})
        add_library(${_COMPONENT} INTERFACE IMPORTED)
        message(${pulsar-client-cpp_MESSAGE_MODE} "Conan: Component target declared '${_COMPONENT}'")
    endif()
endforeach()

if(NOT TARGET pulsar-client-cpp::pulsar-client-cpp)
    add_library(pulsar-client-cpp::pulsar-client-cpp INTERFACE IMPORTED)
    message(${pulsar-client-cpp_MESSAGE_MODE} "Conan: Target declared 'pulsar-client-cpp::pulsar-client-cpp'")
endif()
# Load the debug and release library finders
file(GLOB CONFIG_FILES "${CMAKE_CURRENT_LIST_DIR}/pulsar-client-cpp-Target-*.cmake")

foreach(f ${CONFIG_FILES})
    include(${f})
endforeach()