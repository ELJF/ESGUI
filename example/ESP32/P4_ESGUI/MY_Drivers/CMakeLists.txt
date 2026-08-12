file(GLOB_RECURSE ALL_SUBDIRS LIST_DIRECTORIES true RELATIVE ${CMAKE_CURRENT_SOURCE_DIR} "*")

set(MY_INCLUDE_DIRS "")
foreach(item ${ALL_SUBDIRS})
    if(IS_DIRECTORY ${CMAKE_CURRENT_SOURCE_DIR}/${item})
        list(APPEND MY_INCLUDE_DIRS ${CMAKE_CURRENT_SOURCE_DIR}/${item})
    endif()
endforeach()
# 追加当前目录本身
list(APPEND MY_INCLUDE_DIRS ${CMAKE_CURRENT_SOURCE_DIR})

file(GLOB_RECURSE SRC_FILES "./*.c")
idf_component_register(SRCS ${SRC_FILES}
        REQUIRES driver
        REQUIRES esp_lcd esp_driver_gpio
        REQUIRES esp_timer
        INCLUDE_DIRS ${MY_INCLUDE_DIRS})