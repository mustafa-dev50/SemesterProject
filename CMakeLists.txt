cmake_minimum_required(VERSION 3.16)

project(SemesterProject VERSION 0.1 LANGUAGES CXX)

set(CMAKE_CXX_STANDARD_REQUIRED ON)

find_package(Qt6 REQUIRED COMPONENTS Quick Location Positioning Sql)

qt_standard_project_setup(REQUIRES 6.8)

qt_add_executable(appSemesterProject
    main.cpp
)

qt_add_qml_module(appSemesterProject
    URI SemesterProject
    QML_FILES
        Main.qml
        SOURCES Backend.h
        SOURCES backend.cpp
        QML_FILES Loginwindow.qml
        QML_FILES Selectionwindow.qml
        QML_FILES MapWindow.qml
        QML_FILES
        QML_FILES FindCentersWindow.qml
        QML_FILES SignupPg.qml
        QML_FILES
        RESOURCES README.md
)

# Qt for iOS sets MACOSX_BUNDLE_GUI_IDENTIFIER automatically since Qt 6.1.
# If you are developing for iOS or macOS you should consider setting an
# explicit, fixed bundle identifier manually though.
set_target_properties(appSemesterProject PROPERTIES
#    MACOSX_BUNDLE_GUI_IDENTIFIER com.example.appSemesterProject
    MACOSX_BUNDLE_BUNDLE_VERSION ${PROJECT_VERSION}
    MACOSX_BUNDLE_SHORT_VERSION_STRING ${PROJECT_VERSION_MAJOR}.${PROJECT_VERSION_MINOR}
    MACOSX_BUNDLE TRUE
    WIN32_EXECUTABLE TRUE
)

target_link_libraries(appSemesterProject
    PRIVATE Qt6::Quick
    Qt6::Location
    Qt6::Positioning
    Qt6::Sql
)

include(GNUInstallDirs)
install(TARGETS appSemesterProject
    BUNDLE DESTINATION .
    LIBRARY DESTINATION ${CMAKE_INSTALL_LIBDIR}
    RUNTIME DESTINATION ${CMAKE_INSTALL_BINDIR}
)
