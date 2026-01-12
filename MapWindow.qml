import QtQuick
import QtQuick.Window
import QtQuick.Controls
import QtLocation
import QtPositioning
import QtQuick.Effects

Window {
    id: mapWindow
    title: "Map View - Islamabad"
    width: 1000
    height: 700

    visible: true

    // mapPlugin
    Plugin {
        id: mapPlugin
        name: "osm"


        PluginParameter { name: "osm.mapping.providersrepository.disabled"; value: true }
        PluginParameter { name: "osm.mapping.cache.disk.size"; value: 0 }
    }

    Map {
        id: map
        anchors.fill: parent
        plugin: mapPlugin
        center: QtPositioning.coordinate(33.6938, 73.0652) // Centered on Islamabad
        zoomLevel: 13



        onSupportedMapTypesChanged: {
            for (var i = 0; i < supportedMapTypes.length; i++) {
                // Look for the generic "Street Map" or "Custom" type
                if (supportedMapTypes[i].name === "Street Map" || supportedMapTypes[i].name === "Custom URL Map") {
                    activeMapType = supportedMapTypes[i];
                    console.log("Forced Map Type to:", supportedMapTypes[i].name);
                    return;
                }
            }
        }

        // This shows the popup when a marker is clicked
        MapQuickItem {
            id: popup
            visible: false
            anchorPoint.x: popupRect.width / 2
            anchorPoint.y: popupRect.height + 20 // Sits above the pin
            coordinate: QtPositioning.coordinate(0, 0) // Updates dynamically

            sourceItem: Rectangle {
                id: popupRect
                width: 220
                height: 80
                radius: 10
                color: "white"
                border.color: "#ddd"
                border.width: 1

                // Little triangle at the bottom
                Rectangle {
                    width: 15; height: 15
                    color: "white"
                    rotation: 45
                    anchors.horizontalCenter: parent.horizontalCenter
                    anchors.bottom: parent.bottom
                    anchors.bottomMargin: -7
                    z: -1
                }

                Column {
                    anchors.centerIn: parent
                    spacing: 5
                    Text {
                        id: popupTitle
                        text: "Center Name"
                        font.bold: true
                        font.pixelSize: 14
                        color: "#333"
                        width: 200
                        wrapMode: Text.WordWrap
                        horizontalAlignment: Text.AlignHCenter
                    }
                    Text {
                        id: popupPhone
                        text: "051-1234567"
                        font.pixelSize: 12
                        color: "#666"
                    }
                }

                // Close button for the popup
                MouseArea {
                    anchors.fill: parent
                    onClicked: popup.visible = false
                }
            }
        }

        // 3. The Markers (Red Dots)
        MapItemView {
            model: MyBackend.searchBloodCentres("")

            delegate: MapQuickItem {
                coordinate: QtPositioning.coordinate(modelData.lat, modelData.lon)
                anchorPoint.x: markerImg.width / 2
                anchorPoint.y: markerImg.height

                sourceItem: Item {
                    width: 40; height: 40

                    // The Marker Icon
                    Rectangle {
                        id: markerImg
                        width: 30; height: 30
                        radius: 15
                        color: "#e74c3c" // Nice Flat Red
                        border.color: "white"
                        border.width: 3
                        anchors.centerIn: parent

                        // "Pulse" animation when loaded
                        NumberAnimation on scale { from: 0; to: 1; duration: 500; easing.type: Easing.OutBack }

                        Text {
                            text: "+"
                            color: "white"
                            font.bold: true
                            font.pixelSize: 18
                            anchors.centerIn: parent
                            anchors.verticalCenterOffset: -1
                        }
                    }

                    // Click Logic
                    MouseArea {
                        anchors.fill: parent
                        hoverEnabled: true
                        onEntered: markerImg.scale = 1.2 // Scale up on hover
                        onExited: markerImg.scale = 1.0

                        onClicked: {
                            // Move the popup to this marker
                            popup.coordinate = QtPositioning.coordinate(modelData.lat, modelData.lon)
                            popupTitle.text = modelData.name
                            popupPhone.text = "📞 " + modelData.phone
                            popup.visible = true
                        }
                    }
                }
            }
        }
    }

    // 4. Zoom Controls (Overlay)
    Column {
        anchors.right: parent.right
        anchors.bottom: parent.bottom
        anchors.margins: 30
        spacing: 10

        Button {
            text: "+"
            width: 40; height: 40
            font.pixelSize: 20
            onClicked: map.zoomLevel += 1
        }

        Button {
            text: "-"
            width: 40; height: 40
            font.pixelSize: 20
            onClicked: map.zoomLevel -= 1
        }
    }
}
