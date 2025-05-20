import QtQuick 2.15
import QtQuick.Window 2.15
import QtQuick.Controls 2.15
import com.company.cpp_control 1.0

/* Main Window
- Frameless window
- Always on top
*/
Window {
    id: root
    width: 350
    height: 80
    x: 50
    y: 50
    visible: true
    opacity: 0.6
    color: "black"

    title: qsTr("Micro Timer")
    flags: Qt.FramelessWindowHint | Qt.WindowStaysOnTopHint

    property variant clickPosition: "1,1"
    property bool running: false

    Row {
        id: row
        anchors.fill: parent
        spacing: 12
        rightPadding: 27

        /* DRAG ICON - if user clicks on this icon, they can
          drag the clock window.
        */
        Image {
            id: dragIcon
            source: "qrc:/resources/drag_icon_white.png"
            height: row.height
            width: 50
            fillMode: Image.PreserveAspectFit
            opacity: 0.5

            MouseArea {
                id: dragArea
                anchors.fill: parent

                onPressed: {
                    clickPosition = Qt.point(mouse.x, mouse.y)
                }

                onPositionChanged: {
                    var delta = Qt.point(mouse.x-clickPosition.x, mouse.y-clickPosition.y)
                    root.x += mouse.x
                    root.y += mouse.y
                }
            } // MouseArea
        } // Image

        Label {
            id: stringTime
            height: row.height
            text: "00:00:00"
            font.pixelSize: 60
            color: "lightgray"
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter

            MouseArea {
                id: clickArea
                anchors.fill: parent
                acceptedButtons: Qt.LeftButton | Qt.RightButton

                /* ONE CLICK TO START/STOP CLOCK */
                onClicked: {
                    if(mouse.button === Qt.LeftButton) {
                        if(!running) {
                            cpp_control.start()
                            running = true
                        } else {
                            cpp_control.stop()
                            running = false
                        }
                    }
                    if(mouse.button === Qt.RightButton) {
                        contextMenu.popup()
                    }
                }

                /* DOUBLE CLICK TO CLEAR CLOCK (SET TO ZERO). */
                onDoubleClicked: {
                    if(running) {
                        cpp_control.stop()
                        running = false
                    }
                    cpp_control.clear()
                }
            } // MouseArea

            /* CONTEXT MENU APPEARS WHEN USER RIGHT-CLICK ON AREA */
            Menu {
                id: contextMenu
                opacity: 1.0

                MenuItem {
                    text: qsTr("About")
                    onTriggered: {
                        var component = Qt.createComponent("AboutDialog.qml")
                        var window = component.createObject()
                        window.show()
                    }
                }

                MenuItem {
                    text: qsTr("Close")
                    onTriggered: Qt.quit()
                }
            } // Menu
        } // Label
    }

    // C++ IMPLEMENTATION OF THE CLOCK TIMER
    CppControl {
        id: cpp_control

        onTimeChanged: {
            stringTime.text = cpp_control.displayString
        }
    } // CppControl
} // Window
