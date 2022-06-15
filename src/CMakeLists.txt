# Copyright 2018-2021 Camilo Higuita <milo.h@aol.com>
# Copyright 2018-2021 Nitrux Latinoamericana S.C.
#
# SPDX-License-Identifier: GPL-3.0-or-later


bison_target(MyParser ${CMAKE_CURRENT_SOURCE_DIR}/mathengine/parser.yy ${CMAKE_CURRENT_BINARY_DIR}/parser.cc)
flex_target(MyScanner ${CMAKE_CURRENT_SOURCE_DIR}/mathengine/scanner.ll ${CMAKE_CURRENT_BINARY_DIR}/scanner.cc)

add_library(kalklib STATIC
    code/historymanager.cpp
    code/inputmanager.cpp
    code/mathengine.cpp
    mathengine/driver.cc
    ${CMAKE_CURRENT_BINARY_DIR}/parser.cc
    ${CMAKE_CURRENT_BINARY_DIR}/scanner.cc
)

target_link_libraries(kalklib
    Qt5::Core
    knumber)

set(project_SRCS
    code/main.cpp
    assets/assets.qrc
    )

qtquick_compiler_add_resources(project_QML_QRC controls/qml.qrc)

add_executable(${PROJECT_NAME}
    ${project_SRCS}
    ${project_QML_QRC}
    )

add_flex_bison_dependency(MyScanner MyParser)

target_compile_definitions(${PROJECT_NAME}
    PRIVATE $<$<OR:$<CONFIG:Debug>,$<CONFIG:RelWithDebInfo>>:QT_QML_DEBUG>)

target_link_libraries(${PROJECT_NAME}
    PRIVATE
    MauiKit

    Qt${QT_VERSION_MAJOR}::Core
    Qt${QT_VERSION_MAJOR}::Quick
    Qt${QT_VERSION_MAJOR}::Widgets

    KF5::CoreAddons
    KF5::I18n
    KF5::UnitConversion
    KF5::ConfigCore
    kalklib
    knumber)

target_include_directories(${PROJECT_NAME} PRIVATE ${CMAKE_BINARY_DIR})
target_include_directories(kalklib PRIVATE ${CMAKE_CURRENT_SOURCE_DIR}/mathengine)


install(TARGETS ${PROJECT_NAME} ${KDE_INSTALL_TARGETS_DEFAULT_ARGS})
