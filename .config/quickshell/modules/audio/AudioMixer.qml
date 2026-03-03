import QtQuick
import QtQuick.Layouts
import QtQuick.Controls
import Quickshell
import Quickshell.Services.Pipewire

FloatingWindow {
    id: mixer
    
    width: 700
    height: 600
    visible: true
    
    color: "transparent"
    
    // PipeWire connection
    Pipewire { 
        id: pipewire 
    }
    
    Rectangle {
        anchors.fill: parent
        anchors.margins: 10
        color: "#1e1e2e"
        radius: 15
        border.color: "#313244"
        border.width: 3
        
        ColumnLayout {
            anchors.fill: parent
            anchors.margins: 20
            spacing: 15
            
            // Header
            RowLayout {
                Layout.fillWidth: true
                
                Text {
                    text: "󰕾 Audio Mixer"
                    font.pixelSize: 24
                    font.bold: true
                    font.family: "JetBrains Mono Nerd Font"
                    color: "#cdd6f4"
                    Layout.fillWidth: true
                }
                
                Button {
                    text: "✕"
                    onClicked: mixer.visible = false
                    
                    background: Rectangle {
                        color: parent.hovered ? "#f38ba8" : "#313244"
                        radius: 8
                        implicitWidth: 40
                        implicitHeight: 40
                    }
                    
                    contentItem: Text {
                        text: parent.text
                        color: "#cdd6f4"
                        font.pixelSize: 16
                        horizontalAlignment: Text.AlignHCenter
                        verticalAlignment: Text.AlignVCenter
                    }
                }
            }
            
            // Tabs
            TabBar {
                id: tabBar
                Layout.fillWidth: true
                
                background: Rectangle {
                    color: "#313244"
                    radius: 10
                }
                
                Repeater {
                    model: [
                        {icon: "", text: "Outputs"},
                        {icon: "", text: "Inputs"}, 
                        {icon: "󰐊", text: "Playback"},
                        {icon: "󰍬", text: "Recording"}
                    ]
                    
                    TabButton {
                        text: modelData.icon + " " + modelData.text
                        
                        contentItem: Text {
                            text: parent.text
                            font.pixelSize: 14
                            font.family: "JetBrains Mono Nerd Font"
                            color: parent.checked ? "#cdd6f4" : "#6c7086"
                            horizontalAlignment: Text.AlignHCenter
                            verticalAlignment: Text.AlignVCenter
                        }
                        
                        background: Rectangle {
                            color: parent.checked ? "#45475a" : "transparent"
                            radius: 8
                        }
                    }
                }
            }
            
            // Content
            StackLayout {
                Layout.fillWidth: true
                Layout.fillHeight: true
                currentIndex: tabBar.currentIndex
                
                // Output Sinks
                AudioDeviceList {
                    nodeType: "Audio/Sink"
                    emptyText: "No output devices found"
                    emptyIcon: ""
                }
                
                // Input Sources
                AudioDeviceList {
                    nodeType: "Audio/Source"
                    emptyText: "No input devices found"
                    emptyIcon: ""
                }
                
                // Playback Streams
                AudioNodeList {
                    nodeType: "Stream/Output/Audio"
                    emptyText: "No playback streams"
                    emptyIcon: "󰐊"
                }
                
                // Recording Streams
                AudioNodeList {
                    nodeType: "Stream/Input/Audio"
                    emptyText: "No recording streams"
                    emptyIcon: "󰍬"
                }
            }
        }
    }
}
