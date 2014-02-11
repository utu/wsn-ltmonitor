# The name of your app.
# NOTICE: name defined in TARGET has a corresponding QML filename.
#         If name defined in TARGET is changed, following needs to be
#         done to match new name:
#         - corresponding QML filename must be changed
#         - desktop icon filename must be changed
#         - desktop filename must be changed
#         - icon definition filename in desktop file must be changed
TARGET = basestation

CONFIG += sailfishapp

SOURCES += src/basestation.cpp

OTHER_FILES += qml/basestation.qml \
    qml/cover/CoverPage.qml \
    qml/pages/FirstPage.qml \
    rpm/basestation.spec \
    rpm/basestation.yaml \
    basestation.desktop \
    qml/StockModel.qml \
    StockChart.qml \
    qml/StockChart.qml \
    qml/pages/StockChart.qml \
    qml/pages/StockModel.qml \
    qml/pages/StockListModel.qml \
    qml/pages/StockListPage.qml

