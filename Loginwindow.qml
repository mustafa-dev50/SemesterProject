import QtQuick
import QtQuick.Window
import QtQuick.Controls
import QtQuick.Layouts

Window {
    id: loginWindow
    visible: false
    title: "Login"
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
          mainwindow.showFullScreen()
          loginWindow.hide()
      }
    }

    // The White "Card" in the center
    Rectangle {
        id: loginCard
        width: 320
        height: 400
        anchors.centerIn: parent
        color: "white"
        radius: 10


        layer.enabled: true
        border.color: "#e0e0e0"

        ColumnLayout {
            anchors.fill: parent
            anchors.margins: 30
            spacing: 15

            Text {
                text: "Welcome Back"
                font.pixelSize: 28
                font.bold: true
                color: "#333"
                Layout.alignment: Qt.AlignHCenter
            }

            Text {
                text: "Please sign in to continue"
                color: "grey"
                Layout.alignment: Qt.AlignHCenter
                Layout.bottomMargin: 20
            }

            // Email Field
            TextField {
                id: userEmail
                placeholderText: "Email Address"
                color: "black" // user text color
                placeholderTextColor: "black"
                Layout.fillWidth: true
                Layout.preferredHeight: 45
                font.pixelSize: 14
                background: Rectangle {
                    color: "#F5F5F5"
                    border.color: userEmail.activeFocus ? "#D32F2F" : "#bdbdbd"
                    radius: 5
                }
            }

            // Password Field
            TextField {
                id: userPassword
                placeholderText: "Password"
                color: "black" // user text color
                placeholderTextColor: "black"
                echoMode: TextInput.Password // Hides text
                Layout.fillWidth: true
                Layout.preferredHeight: 45
                font.pixelSize: 14
                background: Rectangle {
                    color: "#F5F5F5"
                    border.color: userPassword.activeFocus ? "#D32F2F" : "#bdbdbd"
                    radius: 5
                }
            }

            Item { Layout.fillHeight: true } // Spacer to push button down

            // Submit Button
            Button {
                id: submitBtn
                text: "Sign In"
                Layout.fillWidth: true
                Layout.preferredHeight: 50

                background: Rectangle {
                    color: submitBtn.down ? "#b71c1c" : "#D32F2F"
                    radius: 5
                }
                contentItem: Text {
                    text: parent.text
                    color: "white"
                    font.bold: true
                    font.pixelSize: 16
                    horizontalAlignment: Text.AlignHCenter
                    verticalAlignment: Text.AlignVCenter
                }
                onClicked: {
                    MyBackend.verifyUser(userEmail.text, userPassword.text)
                }
            }
        }
    }

    // Load next windows
    Selectionwindow { id: selectionwindow }

    Connections {
        target: MyBackend
        function onOpenSelectionWindow() {
            selectionwindow.showFullScreen();
            loginWindow.hide();
        }
    }
}
