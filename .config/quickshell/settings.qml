import QtQuick 2.15
import QtQuick.Window 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15

Window {
    id: root
    width: 600
    height: 300
    visible: true
    flags: Qt.FramelessWindowHint | Qt.WindowStaysOnTopHint | Qt.Tool

    color: "#1e1e2e"
    opacity: 0.95

    RowLayout {
        anchors.fill: parent
        spacing: 0

        // Side panel
        Rectangle {
            id: sidePanel
            width: 150
            color: "#313244"
            Layout.fillHeight: true

            Column {
                anchors.centerIn: parent
                spacing: 20

                Text {
                    text: "Menu"
                    font.pixelSize: 18
                    color: "#cdd6f4"
                }

                Button {
                    text: "Wallpaper"
                }

                Button {
                    text: "Bar"
                }
            }
        }

        // Main content area
        Rectangle {
            id: contentArea
            color: "transparent"
            Layout.fillWidth: true
            Layout.fillHeight: true

            Text {
                anchors.centerIn: parent
                text: "Hello, World!"
                color: "#cdd6f4"
                font.pixelSize: 24
                font.bold: true
            }
        }
    }
}
