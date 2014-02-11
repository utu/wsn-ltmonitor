import QtQuick 2.0
import Sailfish.Silica 1.0


Page {
    id: page

    property string currentStockId: ""
    property string currentStockName: ""

    SilicaListView {
        model: StockListModel{}
        anchors.fill: parent
        header: PageHeader {
            title: "Nested Page"
        }
        delegate: Rectangle {
            height: 30
            width: parent.width
            color: "transparent"
            MouseArea {
                anchors.fill: parent;
                onClicked:view.currentIndex = index;
            }

            Text {
                anchors.verticalCenter: parent.top
                anchors.verticalCenterOffset : 15
                color: index == view.currentIndex ? "#ECC089" : "#A58963"
                font.pointSize: 12
                font.bold: true
                text:"         " + stockId + " - " + name
            }
        }
        VerticalScrollDecorator {}


        keyNavigationWraps: true
        focus: true
        snapMode: SilicaListView.SnapToItem

        onCurrentIndexChanged: {
            root.currentStockId = model.get(currentIndex).stockId;
            root.currentStockName = model.get(currentIndex).name;
            console.log("current stock:" + root.currentStockId + " - " + root.currentStockName);
        }

        highlight: Rectangle {
            width: parent.width
            color: "#662"
        }
    }
}





