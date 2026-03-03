import QtQuick
import QtQuick.Layouts
import QtQuick.Controls
import Quickshell.Services.Pipewire

Rectangle {
    id: card
    
    required property PwNode node
    
    implicitHeight: content.implicitHeight + 30
    color: "#313244"
    radius: 12
    border.color: "#585b70"
    border.width: 2
    
    PwObjectTracker { objects: [ node ] }
    
    ColumnLayout {
        id: content
        anchors.fill: parent
        anchors.margins: 15
        spacing: 12
        
        // Header
        RowLayout {
            Layout.fillWidth: true
            spacing: 12
            
            // Icon
            Image {
                visible: source != ""
                source: {
                    const icon = card.node.properties["application.icon-name"] ?? "audio-volume-high-symbolic";
                    return `image://icon/${icon}`;
                }
                sourceSize.width: 32
                sourceSize.height: 32
            }
            
            // Name
            ColumnLayout {
                Layout.fillWidth: true
                spacing: 2
                
                Label {
                    text: {
                        const app = card.node.properties["application.name"] ?? 
                                   (card.node.description != "" ? card.node.description : card.node.name);
                        const media = card.node.properties["media.name"];
                        return media != undefined ? `${app} - ${media}` : app;
                    }
                    font.pixelSize: 14
                    font.bold: true
                    color: "#cdd6f4"
                    elide: Text.ElideRight
                    Layout.fillWidth: true
                }
                
                Label {
                    text: card.node.properties["media.name"] ?? ""
                    font.pixelSize: 11
                    color: "#a6adc8"
                    visible: text !== ""
                    elide: Text.ElideRight
                    Layout.fillWidth: true
                }
            }
            
            // Mute button
            Button {
                text: card.node.audio.muted ? "unmute" : "mute"
                onClicked: card.node.audio.muted = !card.node.audio.muted
                
                background: Rectangle {
                    color: parent.hovered ? "#45475a" : "transparent"
                    radius: 6
                    implicitWidth: 70
                    implicitHeight: 32
                }
                
                contentItem: Text {
                    text: parent.text
                    color: card.node.audio.muted ? "#f38ba8" : "#a6e3a1"
                    font.pixelSize: 12
                    horizontalAlignment: Text.AlignHCenter
                    verticalAlignment: Text.AlignVCenter
                }
            }
        }
        
        // Volume control
        RowLayout {
            Layout.fillWidth: true
            spacing: 10
            
            Label {
                Layout.preferredWidth: 50
                text: `${Math.floor(card.node.audio.volume * 100)}%`
                font.pixelSize: 13
                color: "#cdd6f4"
            }
            
            Slider {
                Layout.fillWidth: true
                from: 0
                to: 1.5
                value: card.node.audio.volume
                onValueChanged: card.node.audio.volume = value
                
                background: Rectangle {
                    x: parent.leftPadding
                    y: parent.topPadding + parent.availableHeight / 2 - height / 2
                    width: parent.availableWidth
                    height: 6
                    radius: 3
                    color: "#45475a"
                    
                    Rectangle {
                        width: parent.parent.visualPosition * parent.width
                        height: parent.height
                        radius: 3
                        color: "#89b4fa"
                    }
                }
                
                handle: Rectangle {
                    x: parent.leftPadding + parent.visualPosition * (parent.availableWidth - width)
                    y: parent.topPadding + parent.availableHeight / 2 - height / 2
                    width: 16
                    height: 16
                    radius: 8
                    color: parent.pressed ? "#cdd6f4" : "#89b4fa"
                    border.color: "#313244"
                    border.width: 2
                }
            }
        }
    }
    
    MouseArea {
        anchors.fill: parent
        hoverEnabled: true
        propagateComposedEvents: true
        
        onEntered: card.border.color = "#89b4fa"
        onExited: card.border.color = "#585b70"
    }
}
