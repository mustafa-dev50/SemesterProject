import QtQuick
import QtQuick.Controls
import QtQuick.Window
import QtQuick.Layouts

Window {
    id: mainwindow
    width: 640
    height: 480
    visible: true
    visibility: Window.FullScreen
    title: "Blood Bank Manager"
    color: "#D32F2F"

    ColumnLayout {
        anchors.centerIn: parent
        spacing: 20

        // Logo / Title
        Text {
            text: "🩸 سہارا"
            font.pixelSize: 48
            font.bold: true
            color: "white"
            Layout.alignment: Qt.AlignHCenter

        }

        Text {
            text: "Donate Blood, Save Lives"
            font.pixelSize: 18
            color: "#FFEBEE" // Light red/white
            Layout.alignment: Qt.AlignHCenter
            SequentialAnimation on scale {
                    loops: Animation.Infinite
                    running: true

                    // Scale up to 1.1x size
                    NumberAnimation {
                        to: 1.1
                        duration: 800
                        easing.type: Easing.InOutQuad
                    }

                    // Scale back down to normal
                    NumberAnimation {
                        to: 1.0
                        duration: 800
                        easing.type: Easing.InOutQuad
                    }
                }
        }

        Item { height: 30; width: 1 } // Spacer

        Button
        {
            id: signup
            text: "Signup!"
            Layout.preferredWidth: 200
            Layout.preferredHeight: 50


            background: Rectangle {
                color:signup.down? "#b71c1c" : "white"
                radius:25
            }
            contentItem: Text {
                text:signup.text
                color: "#D32F2F"
                font.bold: true
                font.pixelSize: 16
                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignVCenter
            }


            onClicked: {
                signupPgInstance.showFullScreen()
                mainwindow.hide()
            }
        }

        // Login Button
        Button {
            id: proceed
            text: "Login to Portal"
            Layout.preferredWidth: 200
            Layout.preferredHeight: 50
            Layout.alignment: Qt.AlignHCenter

            background: Rectangle {
                color: proceed.down ? "#b71c1c" : "white"
                radius: 25
            }
            contentItem: Text {
                text: proceed.text
                color: "#D32F2F"
                font.bold: true
                font.pixelSize: 16
                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignVCenter
            }
            onClicked: {
                MyBackend.openSecondWindow();
            }
        }

        //exit button

        Button {
            id: exit
            text: "Exit"
            Layout.preferredHeight: 50
            Layout.preferredWidth: 200

            background: Rectangle {
                color: exit.down? "#b71c1c" : "white"
                radius: 25
            }

            contentItem: Text {
                text: exit.text
                color: "#D32F2F"
                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignVCenter
                font.pointSize: 16
                font.bold: true
            }
            onClicked: {
                MyBackend.exitProgram();
            }

        }
    }

    // Connect the backend to open the next window
    Connections {
        target: MyBackend
        function onOpenWindowRequest() {
            loginWindow.showFullScreen();
            mainwindow.hide();
        }
    }

    //initializing the different windows linked with main

    Loginwindow {
        id: loginWindow
    }

    SignupPg {
        id:signupPgInstance

    }

}
