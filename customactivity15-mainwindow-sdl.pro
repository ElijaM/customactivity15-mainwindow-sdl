QT += core gui widgets androidextras

DEFINES += QT_DEPRECATED_WARNINGS

CONFIG += c++11

HEADERS += \
    mainwindow.h

SOURCES += \
        main.cpp \
        mainwindow.cpp

FORMS += \
    mainwindow.ui

target.path = $$[QT_INSTALL_EXAMPLES]/androidextras/customactivity
INSTALLS += target

android {
    DISTFILES += \
        android/AndroidManifest.xml \
        android/build.gradle \
        android/src/org/qtproject/example/activityhandler/CustomActivity.java \
        android/src/org/qtproject/example/activityhandler/Sdl2Activity.java \
        android/res/layout/second_activity.xml \
        android/res/values/strings.xml
#        android/res/values/libs.xml

message($${ANDROID_TARGET_ARCH})
equals(ANDROID_TARGET_ARCH, armeabi-v7a) {
    RAVIS_ANDROID_PLATFORM = armeabi-v7a
    RAVIS_ANDROID_QT_PLATFORM = android_armv7
}
equals(ANDROID_TARGET_ARCH, arm64-v8a) {
    RAVIS_ANDROID_PLATFORM = arm64-v8a
    RAVIS_ANDROID_QT_PLATFORM = android_arm64_v8a
}
equals(ANDROID_TARGET_ARCH, x86)  {
    RAVIS_ANDROID_PLATFORM = x86
    RAVIS_ANDROID_QT_PLATFORM = android_x86
}

CONFIG(debug, debug|release) {
    RAVIS_ANDROID_CONFIG = debug
    RAVIS_ANDROID_QT_CONFIG = Debug
}
CONFIG(release, debug|release) {
    RAVIS_ANDROID_CONFIG = release
    RAVIS_ANDROID_QT_CONFIG = Release
}

INCLUDEPATH += $$(RAVIS_ANDROID_SDL)/include

#    LIBS += $$PWD/android/libs/libSDL2.so
#    LIBS += $$PWD/android/libs/libhidapi.so
#    LIBS += $$(RAVIS_ANDROID_SDL)/android-project/app/build/intermediates/ndkBuild/$${RAVIS_ANDROID_CONFIG}/obj/local/$${RAVIS_ANDROID_PLATFORM}/libSDL2.so
#    LIBS += $$(RAVIS_ANDROID_SDL)/android-project/app/build/intermediates/ndkBuild/$${RAVIS_ANDROID_CONFIG}/obj/local/$${RAVIS_ANDROID_PLATFORM}/libhidapi.so
#    LIBS += $$(RAVIS_ANDROID_SDL)/android-project/app/build/intermediates/ndkBuild/$${RAVIS_ANDROID_CONFIG}/obj/local/$${RAVIS_ANDROID_PLATFORM}/libmain.so
#    LIBS += D:/Elija/Projects/Vendors/SDL/SDL2-2.0.14-android/app/build/intermediates/cmake/$${RAVIS_ANDROID_CONFIG}/obj/$${RAVIS_ANDROID_PLATFORM}/libSDL2.so
#    LIBS += D:/Elija/Projects/Vendors/SDL/SDL2-2.0.14-android/app/build/intermediates/cmake/$${RAVIS_ANDROID_CONFIG}/obj/$${RAVIS_ANDROID_PLATFORM}/libhidapi.so
#    LIBS += D:/Elija/Projects/Vendors/SDL/SDL2-2.0.14-android/app/build/intermediates/cmake/$${RAVIS_ANDROID_CONFIG}/obj/$${RAVIS_ANDROID_PLATFORM}/libmain.so
#    ANDROID_EXTRA_LIBS += $$(RAVIS_ANDROID_SDL)/android-project/app/build/intermediates/ndkBuild/$${RAVIS_ANDROID_CONFIG}/obj/local/$${RAVIS_ANDROID_PLATFORM}/libSDL2.so
#    ANDROID_EXTRA_LIBS += $$(RAVIS_ANDROID_SDL)/android-project/app/build/intermediates/ndkBuild/$${RAVIS_ANDROID_CONFIG}/obj/local/$${RAVIS_ANDROID_PLATFORM}/libhidapi.so
#    ANDROID_EXTRA_LIBS += $$(RAVIS_ANDROID_SDL)/android-project/app/build/intermediates/ndkBuild/$${RAVIS_ANDROID_CONFIG}/obj/local/$${RAVIS_ANDROID_PLATFORM}/libmain.so
#    ANDROID_EXTRA_LIBS += D:/Elija/Projects/Vendors/SDL/SDL2-2.0.14-android/app/build/intermediates/cmake/$${RAVIS_ANDROID_CONFIG}/obj/$${RAVIS_ANDROID_PLATFORM}/libSDL2.so
#    ANDROID_EXTRA_LIBS += D:/Elija/Projects/Vendors/SDL/SDL2-2.0.14-android/app/build/intermediates/cmake/$${RAVIS_ANDROID_CONFIG}/obj/$${RAVIS_ANDROID_PLATFORM}/libhidapi.so
#    ANDROID_EXTRA_LIBS += D:/Elija/Projects/Vendors/SDL/SDL2-2.0.14-android/app/build/intermediates/cmake/$${RAVIS_ANDROID_CONFIG}/obj/$${RAVIS_ANDROID_PLATFORM}/libmain.so

    !versionAtLeast(QT_VERSION, 5.14.0) {
        ANDROID_EXTRA_LIBS += \
        $$(RAVIS_ANDROID_QT5)/$${QT_VERSION}/$${RAVIS_ANDROID_QT_PLATFORM}/lib/libQt5PrintSupport.so \
        $$(RAVIS_ANDROID_QT5)/$${QT_VERSION}/$${RAVIS_ANDROID_QT_PLATFORM}/lib/libQt5OpenGL.so \
        $$(RAVIS_ANDROID_QT5)/$${QT_VERSION}/$${RAVIS_ANDROID_QT_PLATFORM}/lib/libQt5Concurrent.so \
        $$(RAVIS_ANDROID_QT5)/$${QT_VERSION}/$${RAVIS_ANDROID_QT_PLATFORM}/lib/libQt5Core.so \
        $$(RAVIS_ANDROID_QT5)/$${QT_VERSION}/$${RAVIS_ANDROID_QT_PLATFORM}/lib/libQt5Gui.so \
        $$(RAVIS_ANDROID_QT5)/$${QT_VERSION}/$${RAVIS_ANDROID_QT_PLATFORM}/lib/libQt5Network.so \
        $$(RAVIS_ANDROID_QT5)/$${QT_VERSION}/$${RAVIS_ANDROID_QT_PLATFORM}/lib/libQt5Widgets.so \
        $$(RAVIS_ANDROID_QT5)/$${QT_VERSION}/$${RAVIS_ANDROID_QT_PLATFORM}/lib/libQt5Svg.so
    }
    versionAtLeast(QT_VERSION, 5.14.0) {
        ANDROID_EXTRA_LIBS += \
        $$(RAVIS_ANDROID_QT5)/$${QT_VERSION}/android/lib/libQt5PrintSupport_$${ANDROID_TARGET_ARCH}.so \
        $$(RAVIS_ANDROID_QT5)/$${QT_VERSION}/android/lib/libQt5OpenGL_$${ANDROID_TARGET_ARCH}.so \
        $$(RAVIS_ANDROID_QT5)/$${QT_VERSION}/android/lib/libQt5Concurrent_$${ANDROID_TARGET_ARCH}.so \
        $$(RAVIS_ANDROID_QT5)/$${QT_VERSION}/android/lib/libQt5Core_$${ANDROID_TARGET_ARCH}.so \
        $$(RAVIS_ANDROID_QT5)/$${QT_VERSION}/android/lib/libQt5Gui_$${ANDROID_TARGET_ARCH}.so \
        $$(RAVIS_ANDROID_QT5)/$${QT_VERSION}/android/lib/libQt5Network_$${ANDROID_TARGET_ARCH}.so \
        $$(RAVIS_ANDROID_QT5)/$${QT_VERSION}/android/lib/libQt5Widgets_$${ANDROID_TARGET_ARCH}.so \
        $$(RAVIS_ANDROID_QT5)/$${QT_VERSION}/android/lib/libQt5Svg_$${ANDROID_TARGET_ARCH}.so
    }
#    ANDROID_PACKAGE_SOURCE_DIR = $$PWD/android
    contains(ANDROID_TARGET_ARCH,arm64-v8a) {
        ANDROID_PACKAGE_SOURCE_DIR = \
        $$PWD/android

        ANDROID_ABIS = \
            armeabi-v7a
    }
}

FORMS += \
    mainwindow.ui
