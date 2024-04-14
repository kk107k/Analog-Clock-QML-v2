cmake_minimum_required(VERSION 3.16)

project(Analog-Clock-QML-v2 VERSION 0.1 LANGUAGES CXX)

set(CMAKE_CXX_STANDARD_REQUIRED ON)

find_package(Qt6 6.4 REQUIRED COMPONENTS Quick)

qt_standard_project_setup()

qt_add_executable(appAnalog-Clock-QML-v2
    main.cpp
)

qt_add_qml_module(appAnalog-Clock-QML-v2
    URI Analog-Clock-QML-v2
    VERSION 1.0
    QML_FILES
        Main.qml
        QML_FILES Clock.qml
        QML_FILES Analogs.qml
        QML_FILES Buttons.qml
)

# Qt for iOS sets MACOSX_BUNDLE_GUI_IDENTIFIER automatically since Qt 6.1.
# If you are developing for iOS or macOS you should consider setting an
# explicit, fixed bundle identifier manually though.
set_target_properties(appAnalog-Clock-QML-v2 PROPERTIES
#    MACOSX_BUNDLE_GUI_IDENTIFIER com.example.appAnalog-Clock-QML-v2
    MACOSX_BUNDLE_BUNDLE_VERSION ${PROJECT_VERSION}
    MACOSX_BUNDLE_SHORT_VERSION_STRING ${PROJECT_VERSION_MAJOR}.${PROJECT_VERSION_MINOR}
    MACOSX_BUNDLE TRUE
    WIN32_EXECUTABLE TRUE
)

target_link_libraries(appAnalog-Clock-QML-v2
    PRIVATE Qt6::Quick
)

include(GNUInstallDirs)
install(TARGETS appAnalog-Clock-QML-v2
    BUNDLE DESTINATION .
    LIBRARY DESTINATION ${CMAKE_INSTALL_LIBDIR}
    RUNTIME DESTINATION ${CMAKE_INSTALL_BINDIR}
)
