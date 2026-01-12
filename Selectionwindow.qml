import QtQuick
import QtQuick.Window
import QtQuick.Controls
import QtQuick.Layouts

Window {
    id: selectionWindow
    title: 'Dashboard'
    visible: false

    color: "#F5F5F5"

    // Top Header Bar
    Rectangle {
        id: header
        width: parent.width
        height: 80
        color: "#D32F2F"

        Text {
            anchors.left: parent.left
            anchors.verticalCenter: parent.verticalCenter
            anchors.leftMargin: 30
            text: "Dashboard"
            color: "white"
            font.pixelSize: 24
            font.bold: true
        }
    }

    Button {
        id: backbtn
        text: "Back to home"
        width: 150
        height: 40
        anchors.top: parent.top
        anchors.right: parent.right
        anchors.margins: 10


        contentItem: Text {
            text: backbtn.text
            color: "#D32F2F"
            font.bold:true
            font.pointSize: 14
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter
            wrapMode: Text.WordWrap
        }

         background: Rectangle {
          color: "white"
          radius: 5
        }


      onClicked: {
          mainwindow.showFullScreen()
          selectionWindow.hide()
      }
    }

    // Grid of Options
    GridLayout {
        anchors.centerIn: parent
        columns: 2 // Side by side
        columnSpacing: 30

        // Option 1: Find Blood (Opens Table)
        Button {
            Layout.preferredWidth: 260
            Layout.preferredHeight: 200

            background: Rectangle {
                color: parent.down ? "#eee" : "white"
                radius: 15
                border.color: "#ddd"
                // Simple shadow simulation
                border.width: parent.hovered ? 2 : 1
            }

            contentItem: Column {
                spacing: 15
                anchors.centerIn: parent
                Text { text: "🔍"; font.pixelSize: 50; anchors.horizontalCenter: parent.horizontalCenter }
                Text {
                    text: "Find Blood Centres"
                    font.bold: true
                    font.pixelSize: 18
                    color: "#333"
                    anchors.horizontalCenter: parent.horizontalCenter
                }
                Text {
                    text: "View list of hospitals"
                    color: "grey"
                    anchors.horizontalCenter: parent.horizontalCenter
                }
            }

            onClicked: {
                var component = Qt.createComponent("FindCentersWindow.qml");
                if (component.status === Component.Ready) {
                    var win = component.createObject(parent);
                    win.show();
                }
            }
        }

        // Option 2: Map View (Opens Map)
        Button {
            Layout.preferredWidth: 260
            Layout.preferredHeight: 200

            background: Rectangle {
                color: parent.down ? "#eee" : "white"
                radius: 15
                border.color: "#ddd"
                border.width: parent.hovered ? 2 : 1
            }

            contentItem: Column {
                spacing: 15
                anchors.centerIn: parent
                Text { text: "🗺️"; font.pixelSize: 50; anchors.horizontalCenter: parent.horizontalCenter }
                Text {
                    text: "Map View"
                    font.bold: true
                    font.pixelSize: 18
                    color: "#333"
                    anchors.horizontalCenter: parent.horizontalCenter
                }
                Text {
                    text: "Locate on Map"
                    color: "grey"
                    anchors.horizontalCenter: parent.horizontalCenter
                }
            }

            onClicked: {
                var component = Qt.createComponent("MapWindow.qml");
                if (component.status === Component.Ready) {
                    var win = component.createObject(parent);
                    win.show();
                }
            }
        }
    }



}
