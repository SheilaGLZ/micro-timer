import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Window 2.15

Window {
    id: root
    width: 250
    height: 200
    x: 50
    y: 200
    visible: true
    opacity: 1.0
    color: "black"

    title: qsTr("About")

    Column {
        anchors.fill: parent
        spacing: 27
        padding: 27

        Column {
            spacing: 6

            Label {
                color: "lightgray"
                text: qsTr("Micro-Timer")
            }

            Label {
                color: "lightgray"
                text: qsTr("version 0.1 beta")
            }

            Label {
                color: "lightgray"
                text: qsTr("GuGo software")
            }

            Label {
                color: "lightgray"
                text: qsTr("www.gugosoftware.com")
            }

            Label {
                color: "lightgray"
                text: qsTr("App icon - fjstudio (flaticon.com)")
            }
        }

        Button {
            width: parent.width - parent.padding*2
            height: 30
            anchors.horizontalCenter: root.horizontalCenter
            text: qsTr("OK")

            onClicked: {
                root.close()
            }
        }
    }
}
