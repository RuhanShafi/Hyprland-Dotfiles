import QtQuick
import QtQuick.Layouts
import QtQuick.Controls
import Quickshell.Services.Pipewire

Rectangle {
    id: card
    
    required property PwNode node
    property bool isDevice: false
    
    implicitHeight: content.implicitHeight + 30
    color: isDefault ? "#45475a" : "#313244"
    radius: 12
    border.color: isDefault ? "#a6e3a1" : "#585b70"
    border.width: isDefault ? 3 : 2
    
    property bool isDefault: {
        // Check if this is the default device
        const nodeId = node.properties["object.id"];
        const defaultSink = node.properties["default.audio.sink"];
        const defaultSource = node.properties["default.audio.source"];
        return nodeId === defaultSink || nodeId === defaultSource;
    }
    
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
            
            // Device icon
            Rectangle {
                width: 48
                height: 48
                radius: 8
                color: "#45475a"
                
                Text {
                    anchors.centerIn: parent
                    text: {
                        const deviceClass = card.node.properties["device.class"] || "";
                        const deviceIcon = card.node.properties["device.icon-name"] || "";
                        
                        if (deviceIcon.includes("headset") || deviceIcon.includes("headphone")) return "";
                        if (deviceIcon.includes("speaker")) return "";
                        if (deviceIcon.includes("microphone")) return "";
                        if (deviceClass.includes("sound")) return "";
                        
                        const mediaClass = card.node.properties["media.class"] || "";
                        return mediaClass.includes("Source") ? "" : "";
                    }
                    font.pixelSize: 28
                    font.family: "JetBrains Mono Nerd Font"
                    color: "#89b4fa"
                }
            }
            
            // Device info
            ColumnLayout {
                Layout.fillWidth: true
                spacing: 4
                
                RowLayout {
                    Layout.fillWidth: true
                    spacing: 8
                    
                    Label {
                        text: {
                            const nick = card.node.properties["node.nick"];
                            const desc = card.node.properties["node.description"];
                            return nick || desc || card.node.description || card.node.name;
                        }
                        font.pixelSize: 15
                        font.bold: true
                        color: "#cdd6f4"
                        elide: Text.ElideRight
                        Layout.fillWidth: true
                    }
                    
                    // Default indicator
                    Rectangle {
                        visible: card.isDefault
                        color: "#a6e3a1"
                        radius: 4
                        implicitWidth: defaultLabel.implicitWidth + 12
                        implicitHeight: 20
                        
                        Label {
                            id: defaultLabel
                            anchors.centerIn: parent
                            text: "DEFAULT"
                            font.pixelSize: 9
                            font.bold: true
                            color: "#1e1e2e"
                        }
                    }
                }
                
                Label {
                    text: {
                        const product = card.node.properties["device.product.name"];
                        const desc = card.node.properties["device.description"];
                        return product || desc || "Audio Device";
                    }
                    font.pixelSize: 11
                    color: "#a6adc8"
                    elide: Text.ElideRight
                    Layout.fillWidth: true
                }
            }
            
            // Set as default button (only for devices)
            Button {
                visible: card.isDevice && !card.isDefault
                text: "Set Default"
                
                background: Rectangle {
                    color: parent.hovered ? "#a6e3a1" : "#585b70"
                    radius: 6
                    implicitWidth: 90
                    implicitHeight: 32
                }
                
                contentItem: Text {
                    text: parent.text
                    color: parent.hovered ? "#1e1e2e" : "#cdd6f4"
                    font.pixelSize: 11
                    font.bold: true
                    horizontalAlignment: Text.AlignHCenter
                    verticalAlignment: Text.AlignVCenter
                }
                
                onClicked: {
                    // Set as default - this would need PulseAudio command
                    console.log("Setting as default:", card.node.name);
                    // pactl set-default-sink or set-default-source
                }
            }
            
            // Mute button
            Button {
                text: card.node.audio.muted ? "󰝟" : "󰕾"
                
                background: Rectangle {
                    color: parent.hovered ? "#45475a" : "transparent"
                    radius: 6
                    implicitWidth: 44
                    implicitHeight: 44
                }
                
                contentItem: Text {
                    text: parent.text
                    font.pixelSize: 20
                    font.family: "JetBrains Mono Nerd Font"
                    color: card.node.audio.muted ? "#f38ba8" : "#a6e3a1"
                    horizontalAlignment: Text.AlignHCenter
                    verticalAlignment: Text.AlignVCenter
                }
                
                onClicked: card.node.audio.muted = !card.node.audio.muted
            }
        }
        
        // Volume control
        RowLayout {
            Layout.fillWidth: true
            spacing: 10
            
            Text {
                text: {
                    if (card.node.audio.muted) return "󰝟";
                    const vol = card.node.audio.volume;
                    if (vol === 0) return "󰝟";
                    if (vol < 0.33) return "󰕿";
                    if (vol < 0.66) return "󰖀";
                    return "󰕾";
                }
                font.pixelSize: 18
                font.family: "JetBrains Mono Nerd Font"
                color: "#89b4fa"
            }
            
            Slider {
                id: volumeSlider
                Layout.fillWidth: true
                from: 0
                to: 1.0
                value: card.node.audio.volume
                onValueChanged: card.node.audio.volume = value
                
                background: Rectangle {
                    x: volumeSlider.leftPadding
                    y: volumeSlider.topPadding + volumeSlider.availableHeight / 2 - height / 2
                    width: volumeSlider.availableWidth
                    height: 6
                    radius: 3
                    color: "#45475a"
                    
                    Rectangle {
                        width: volumeSlider.visualPosition * parent.width
                        height: parent.height
                        radius: 3
                        gradient: Gradient {
                            orientation: Gradient.Horizontal
                            GradientStop { position: 0.0; color: "#89b4fa" }
                            GradientStop { position: 0.5; color: "#74c7ec" }
                            GradientStop { position: 1.0; color: "#94e2d5" }
                        }
                    }
                }
                
                handle: Rectangle {
                    x: volumeSlider.leftPadding + volumeSlider.visualPosition * (volumeSlider.availableWidth - width)
                    y: volumeSlider.topPadding + volumeSlider.availableHeight / 2 - height / 2
                    width: 18
                    height: 18
                    radius: 9
                    color: volumeSlider.pressed ? "#cdd6f4" : "#89b4fa"
                    border.color: "#313244"
                    border.width: 2
                }
            }
            
            Label {
                Layout.preferredWidth: 50
                text: `${Math.floor(card.node.audio.volume * 100)}%`
                font.pixelSize: 14
                font.family: "JetBrains Mono Nerd Font"
                color: "#cdd6f4"
                horizontalAlignment: Text.AlignRight
            }
        }
        
        // Port selector (if available)
        RowLayout {
            Layout.fillWidth: true
            visible: portCombo.model.length > 1
            spacing: 10
            
            Label {
                text: "Port:"
                font.pixelSize: 12
                color: "#a6adc8"
            }
            
            ComboBox {
                id: portCombo
                Layout.fillWidth: true
                
                model: {
                    // Get available ports from node
                    const ports = card.node.properties["device.profile.name"];
                    return ports ? [ports] : ["Default"];
                }
                
                background: Rectangle {
                    color: "#45475a"
                    radius: 6
                    border.color: parent.hovered ? "#89b4fa" : "#585b70"
                    border.width: 1
                }
                
                contentItem: Text {
                    text: portCombo.displayText
                    font.pixelSize: 12
                    color: "#cdd6f4"
                    verticalAlignment: Text.AlignVCenter
                    leftPadding: 10
                }
            }
        }
    }
    
    MouseArea {
        anchors.fill: parent
        hoverEnabled: true
        propagateComposedEvents: true
        
        onEntered: {
            if (!card.isDefault) {
                card.border.color = "#89b4fa";
            }
        }
        onExited: {
            if (!card.isDefault) {
                card.border.color = "#585b70";
            }
        }
    }
}
