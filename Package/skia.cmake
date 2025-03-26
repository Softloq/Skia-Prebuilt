add_custom_target(
    Skia_Copy_DLLs
    ALL DEPENDS ${ALL_TARGETS}
    COMMAND ${CMAKE_COMMAND} -DSkia_DLL_OUTPUT_DIRECTORY="${CMAKE_RUNTIME_OUTPUT_DIRECTORY}/$<CONFIG>" -P"${CMAKE_CURRENT_LIST_DIR}/copy_dlls.cmake"
)

add_library(skia-all INTERFACE)
add_library(skia::all ALIAS skia-all)
target_include_directories(skia-all INTERFACE "${CMAKE_CURRENT_LIST_DIR}/include")
target_link_directories(skia-all INTERFACE "${CMAKE_CURRENT_LIST_DIR}/lib")
target_link_libraries(skia-all INTERFACE
    bentleyottmann
    compression_utils_portable expat harfbuzz icu
    libjpeg libjpeg12 libjpeg16 libpng libwebp_sse41 libwebp
    pathkit
    skcms skia skparagraph skresources skshaper skunicode_core skunicode_icu svg
    wuffs zlib)
