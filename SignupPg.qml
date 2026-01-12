import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import QtQuick.Window


Window {
    id: signupPage
    visible: false
    color: "#F5F5F5"
    title: "SignUp"

    //back button on top right

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
          signupPage.hide()
      }
    }

    //signup card

    Rectangle {
        id: signupCard
        width:340
        height: 400
        color: "white"
        anchors.centerIn: parent
        radius: 10

        ColumnLayout {
            anchors.fill: parent
            anchors.margins: 30
            spacing: 15

            //welcome text
            Text {
                text: "Welcome to sahara!"
                Layout.alignment: Qt.AlignHCenter
                font.bold: true
                font.pointSize: 20
                color: "Black"
            }

            //signUp please text
            Text {
                text: "Please enter your Email Address and Password to continue!"
                Layout.fillWidth: true
                Layout.alignment: Qt.AlignHCenter
                font.bold: true
                font.pointSize: 10
                wrapMode: Text.WordWrap
                color: "Gray"
            }

            // text field for email

            TextField {
                id: emailAddress
                placeholderText: "Enter Email Address"
                color: "black" // user text color
                placeholderTextColor: "black"
                Layout.fillWidth: true
                Layout.preferredHeight: 50
                leftPadding: 10
                verticalAlignment: TextInput.AlignVCenter
                font.pixelSize: 14
                background: Rectangle {
                    color: "#F5F5F5"
                    border.color: emailAddress.activeFocus ? "#D32F2F" : "#bdbdbd"
                    radius: 5
                }
            }

            //text field for password

            TextField {
                id: passwordField
                placeholderText: "Enter your password"
                color: "black" // user text color
                placeholderTextColor: "black"
                echoMode: TextField.Password
                Layout.fillWidth: true
                Layout.preferredHeight: 50
                verticalAlignment: TextInput.AlignVCenter
                leftPadding: 10
                font.pixelSize: 14
                background: Rectangle {
                    color: "#F5F5F5"
                    border.color: passwordField.activeFocus ? "#D32F2F" : "#bdbdbd"
                    radius: 5
                }
            }

            Item {Layout.fillHeight: true}

            //create account button

            Button {
                id: create
                text: "Create Account"
                Layout.fillWidth: true
                Layout.preferredHeight: 50
                background: Rectangle {
                    color: create.down ? "#b71c1c" : "#D32F2F"
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
                    MyBackend.addUser(emailAddress.text, passwordField.text)
                }

            }

        }

    }




}

