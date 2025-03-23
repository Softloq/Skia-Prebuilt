cmake_minimum_required(VERSION 3.10)

project(Skia-Package)

# Package skia.zip
file(REMOVE_RECURSE "${CMAKE_BINARY_DIR}/skia")

file(COPY "${CMAKE_BINARY_DIR}/../Prerequisite/Downloads/skia/include" DESTINATION "${CMAKE_BINARY_DIR}/skia/include")
file(COPY "${CMAKE_BINARY_DIR}/../Prerequisite/Downloads/skia/modules" DESTINATION "${CMAKE_BINARY_DIR}/skia/include")
file(COPY "${CMAKE_BINARY_DIR}/../Prerequisite/Downloads/skia/src" DESTINATION "${CMAKE_BINARY_DIR}/skia/include")
file(GLOB_RECURSE skia_lib_SRC "${CMAKE_BINARY_DIR}/../Compile/skia/*.lib")
foreach(SKIA_LIB ${skia_lib_SRC})
    get_filename_component(SKIA_OLD_LIB "${SKIA_LIB}" NAME)
    get_filename_component(SKIA_NEW_LIB "${SKIA_LIB}" NAME)
    string(REGEX REPLACE "\\.dll.lib$" ".lib" SKIA_NEW_LIB "${SKIA_NEW_LIB}")

    file(COPY "${SKIA_LIB}" DESTINATION "${CMAKE_BINARY_DIR}/skia/lib")
    file(RENAME "${CMAKE_BINARY_DIR}/skia/lib/${SKIA_OLD_LIB}" "${CMAKE_BINARY_DIR}/skia/lib/${SKIA_NEW_LIB}")
endforeach()
file(GLOB_RECURSE skia_dll_SRC "${CMAKE_BINARY_DIR}/../Compile/skia/*.dll")
foreach(SKIA_DLL ${skia_dll_SRC})
    file(COPY "${SKIA_DLL}" DESTINATION "${CMAKE_BINARY_DIR}/skia/bin")
endforeach()
configure_file("${CMAKE_CURRENT_LIST_DIR}/copy_dlls.cmake" "${CMAKE_BINARY_DIR}/skia/copy_dlls.cmake" COPYONLY)
configure_file("${CMAKE_CURRENT_LIST_DIR}/skia.cmake" "${CMAKE_BINARY_DIR}/skia/skia.cmake" COPYONLY)
add_custom_target(
    zip_skia ALL
    COMMAND ${CMAKE_COMMAND} -E tar cfv "${CMAKE_BINARY_DIR}/skia.zip" --format=zip .
    WORKING_DIRECTORY "${CMAKE_BINARY_DIR}/skia"
)
