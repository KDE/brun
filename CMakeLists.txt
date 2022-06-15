cmake_minimum_required(VERSION 3.16)

project(maui-calculator VERSION 1.0.0)

set(CMAKE_INCLUDE_CURRENT_DIR ON)

set(CMAKE_AUTOUIC ON)
set(CMAKE_AUTOMOC ON)
set(CMAKE_AUTORCC ON)

set(CMAKE_CXX_STANDARD 17)
set(CMAKE_CXX_STANDARD_REQUIRED ON)

set(REQUIRED_KF5_VERSION 5.77.0)

set(PROJECT_URI "org.kde.${PROJECT_NAME}")
add_definitions(-DPROJECT_URI="${PROJECT_URI}")

find_package(ECM ${REQUIRED_KF5_VERSION} REQUIRED NO_MODULE)
set(CMAKE_MODULE_PATH ${ECM_MODULE_PATH})
set (CMAKE_MODULE_PATH "${CMAKE_MODULE_PATH}" ${CMAKE_SOURCE_DIR}/cmake/modules)

include(KDEInstallDirs)
include(KDECMakeSettings)
include(ECMInstallIcons)
include(ECMAddAppIcon)
include(KDECompilerSettings NO_POLICY_SCOPE)
include(KDEClangFormat)
include(ECMSetupVersion)
include(ECMSourceVersionControl)
include(FeatureSummary)
include(ECMQMLModules)

find_package(BISON REQUIRED)
find_package(FLEX REQUIRED)

find_package(QT NAMES Qt6 Qt5 COMPONENTS Core Quick Widgets REQUIRED)

find_package(Qt${QT_VERSION_MAJOR} COMPONENTS Core Quick Widgets REQUIRED)

find_package(KF5 ${REQUIRED_KF5_VERSION} REQUIRED COMPONENTS I18n CoreAddons UnitConversion Config)

find_package(Qt5QuickCompiler)
set_package_properties(Qt5QuickCompiler PROPERTIES
    DESCRIPTION "Compile QML at build time"
    TYPE OPTIONAL
    )

find_package(MauiKit)

find_package(GMP)
set_package_properties(GMP PROPERTIES
    DESCRIPTION "The GNU Multiple Precision Arithmetic Library"
    URL "https://gmplib.org/"
    TYPE REQUIRED
    PURPOSE "Required for building KCalc."
)

find_package(MPFR)
set_package_properties(MPFR PROPERTIES
    DESCRIPTION "The GNU Multiple Precision Floating-Point Reliable Library"
    URL "https://www.mpfr.org/"
    TYPE REQUIRED
    PURPOSE "Required for building KCalc."
)

include(CheckTypeSize)
include(CheckIncludeFiles)

check_include_files(ieeefp.h     HAVE_IEEEFP_H)
check_type_size("signed long"    SIZEOF_SIGNED_LONG)
check_type_size("unsigned long"  SIZEOF_UNSIGNED_LONG)

set(CMAKE_MODULE_PATH ${CMAKE_MODULE_PATH} ${ECM_MODULE_PATH} ${ECM_KDE_MODULE_DIR})

if(ECM_SOURCE_UNDER_VERSION_CONTROL)
    execute_process(
        COMMAND git rev-parse --abbrev-ref HEAD
        WORKING_DIRECTORY ${CMAKE_SOURCE_DIR}
        OUTPUT_VARIABLE GIT_BRANCH
        OUTPUT_STRIP_TRAILING_WHITESPACE
        )

    # Get the latest abbreviated commit hash of the working branch
    execute_process(
        COMMAND git log -1 --format=%h
        WORKING_DIRECTORY ${CMAKE_SOURCE_DIR}
        OUTPUT_VARIABLE GIT_COMMIT_HASH
        OUTPUT_STRIP_TRAILING_WHITESPACE
        )

    add_definitions(-DGIT_COMMIT_HASH="${GIT_COMMIT_HASH}")
    add_definitions(-DGIT_BRANCH="${GIT_BRANCH}")

else()
    add_definitions(-DGIT_COMMIT_HASH="${PROJECT_VERSION}")
    add_definitions(-DGIT_BRANCH="${CMAKE_BUILD_TYPE}")
endif()

ecm_setup_version(${PROJECT_VERSION}
    VARIABLE_PREFIX PROJECT
    VERSION_HEADER "${CMAKE_CURRENT_BINARY_DIR}/project_version.h"
    )

add_subdirectory(src)

configure_file(config-kcalc.h.cmake ${CMAKE_CURRENT_BINARY_DIR}/config-kcalc.h )
add_subdirectory(knumber)

install(FILES data/project.appdata.xml DESTINATION ${KDE_INSTALL_METAINFODIR} RENAME ${PROJECT_URI}.appdata.xml)

install(FILES data/project.desktop DESTINATION ${XDG_APPS_INSTALL_DIR} RENAME ${PROJECT_URI}.desktop)

install(FILES src/assets/logo.svg DESTINATION ${KDE_INSTALL_ICONDIR}/hicolor/scalable/apps RENAME ${PROJECT_NAME}.svg)

#install(FILES data/org.kde.index.notifyrc DESTINATION ${KNOTIFYRC_INSTALL_DIR})

feature_summary(WHAT ALL FATAL_ON_MISSING_REQUIRED_PACKAGES)

file(GLOB_RECURSE ALL_CLANG_FORMAT_SOURCE_FILES *.cpp *.h)
kde_clang_format(${ALL_CLANG_FORMAT_SOURCE_FILES})

