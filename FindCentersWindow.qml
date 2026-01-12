import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

Window {
    id: findWindow
    title: "Hospital Directory"
    width: 500
    height: 700
    visible: true // Opens automatically when created
    color: "#F5F5F5" // Light Grey Background

    Button {
        id: backbtn
        text: "Back"
        width: 100
        height: 40
        anchors.top: parent.top
        anchors.right: parent.right
        anchors.margins: 10

        contentItem: Text {
            text: backbtn.text
            color: "white"
            font.bold:true
            font.pointSize: 14
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter
        }

         background: Rectangle {
          color: backbtn.down ? "#b71c1c" : "#D32F2F"
          radius: 5
        }


      onClicked: {
          Selection.showFullScreen()
          loginWindow.hide()
      }
    }


    // header
    Rectangle {
        id: header
        width: parent.width
        height: 70
        color: "#D32F2F" // Medical Red

        Text {
            text: "🏥 Hospital Directory"
            color: "white"
            font.bold: true
            font.pixelSize: 22
            anchors.centerIn: parent
        }
    }

    ColumnLayout {
        anchors.top: header.bottom
        anchors.bottom: parent.bottom
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.margins: 20
        spacing: 15

        // search Bar
        TextField {
            id: searchInput
            placeholderText: "🔍 Search by Name..."
            Layout.fillWidth: true
            Layout.preferredHeight: 50
            font.pixelSize: 16

            background: Rectangle {
                color: "white"
                radius: 10
                border.color: searchInput.activeFocus ? "#D32F2F" : "#bdbdbd"
                border.width: 2
            }

            // this calls the backend searchBloodCentres function everytime something is typed
            onTextChanged: {
                resultsList.model = MyBackend.searchBloodCentres(text)
            }
        }

        // List
        ListView {
            id: resultsList
            Layout.fillWidth: true
            Layout.fillHeight: true
            clip: true
            spacing: 10

            // Load all data when window opens
            Component.onCompleted: {
                model = MyBackend.searchBloodCentres("")
            }

            // The Design for one Row
            delegate: Rectangle {
                width: resultsList.width
                height: 100
                color: "white"
                radius: 10
                border.color: "#e0e0e0"

                // Content inside the card
                ColumnLayout {
                    anchors.fill: parent
                    anchors.margins: 15
                    spacing: 5

                    // Name
                    Text {
                        text: modelData.name
                        font.bold: true
                        font.pixelSize: 18
                        color: "#333"
                        elide: Text.ElideRight
                        Layout.fillWidth: true
                    }

                    // Location
                    RowLayout {
                        spacing: 5
                        Text { text: "📍"; font.pixelSize: 14 }
                        Text {
                            text: modelData.location
                            color: "#666"
                            font.pixelSize: 14
                            elide: Text.ElideRight
                            Layout.fillWidth: true
                        }
                    }

                    // Phone
                    RowLayout {
                        spacing: 5
                        Text { text: "📞"; font.pixelSize: 14 }
                        Text {
                            text: modelData.phone
                            color: "#D32F2F"
                            font.pixelSize: 14
                            font.bold: true
                        }
                    }
                }
            }
        }
    }
}


