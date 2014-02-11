import QtQuick 2.0
import Sailfish.Silica 1.0
import "pages"

ApplicationWindow
{
    initialPage: Component {
        FirstPage {
            id: stockView
            stock: stock
            settings: settings
        }
    }
    cover: Qt.resolvedUrl("cover/CoverPage.qml")

    StockModel {
        id: stock
        stockId: listView.currentStockId
        stockName: listView.currentStockName
        startDate: settings.startDate
        endDate: settings.endDate
        onStockIdChanged: updateTimer.restart()
        onStartDateChanged: updateTimer.restart()
        onEndDateChanged: updateTimer.restart()
        onDataReady: {
            root.positionViewAtIndex(1, ListView.SnapPosition)
            stockView.update()
        }
    }

    Timer {
        id: updateTimer
        interval: 500
        onTriggered: stock.updateStock()
    }

    ListModel {
        id: settings
        property var startDate : new Date(1995, 3, 25)
        property var endDate : new Date()

        property bool drawHighPrice: true
        property bool drawLowPrice: true
        property bool drawOpenPrice: true
        property bool drawClosePrice: true
        property bool drawVolume: true
        property bool drawKLine: true

        property color highColor: Qt.rgba(1, 0, 0, 1)
        property color lowColor: Qt.rgba(0, 1, 0, 1)
        property color openColor: Qt.rgba(0, 0, 1, 1)
        property color volumeColor: Qt.rgba(0.3, 0.5, 0.7, 1)
        property color closeColor: "#ecc088"

        property string chartType: "year"
    }


    StockListPage {
        id: listView
    }

}
