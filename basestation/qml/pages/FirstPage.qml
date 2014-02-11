import QtQuick 2.0
import Sailfish.Silica 1.0

Page {
    id: page

    property var stock: null
    property var stocklist: null
    property var settings: null
    signal listViewClicked
    signal settingsClicked

    function update() {
        if (!settings)
            return;
        chart.endDate = settings.endDate
        chart.update()
    }

    // To enable PullDownMenu, place our content in a SilicaFlickable
    SilicaFlickable {
        anchors.fill: page

        // PullDownMenu and PushUpMenu must be declared in SilicaFlickable, SilicaListView or SilicaGridView
        PullDownMenu {
            MenuItem {
                text: "Show stocks"
                onClicked: pageStack.push(Qt.resolvedUrl("StockListPage.qml"))
            }
        }

        // Tell SilicaFlickable the height of its content.
        contentHeight: column.height

        // Place our content in a Column.  The PageHeader is always placed at the top
        // of the page, followed by our content.

        Column {
            id: column

            width: page.width
            spacing: Theme.paddingLarge
            PageHeader {
                id: header
                title: "Test chart"
            }

            StockChart {
                id: chart
                anchors.bottom: footer.bottom
                anchors.top : header.bottom
                anchors.topMargin: 30
                width: column.width
                stockModel: page.stock
                settings: page.settings
            }

            Text {
                id: footer
                font.pointSize: 10
                width: 50
                wrapMode: Text.WordWrap
                anchors.top: chart.bottom
                anchors.leftMargin: 20
                text: "footer goes here"
            }
        }

    }

}


