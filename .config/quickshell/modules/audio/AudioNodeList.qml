import QtQuick
import QtQuick.Layouts
import QtQuick.Controls
import Quickshell.Services.Pipewire

ScrollView {
    id: root
    
    required property string nodeType
    required property string emptyText
    required property string emptyIcon
    
    clip: true
    
    ScrollBar.vertical: ScrollBar {
        policy: ScrollBar.AsNeeded
        contentItem: Rectangle {
            implicitWidth: 8
            radius: 4
            color: "#585b70"
        }
        background: Rectangle {
            color: "#313244"
            radius: 4
        }
    }
    
    Pipewire { 
        id: pipewire 
    }
    
    ColumnLayout {
        width: root.width - 20
        spacing: 10
        
        Repeater {
            id: nodeRepeater
            model: {
                let nodes = [];
                for (let group of pipewire.linkGroups) {
                    // Check target node
                    if (group.target && group.target.audio) {
                        let mediaClass = group.target.properties["media.class"] || "";
                        if (mediaClass.includes(root.nodeType)) {
                            nodes.push(group.target);
                        }
                    }
                    // Check linked nodes
                    if (group.links) {
                        for (let link of group.links) {
                            if (link && link.audio) {
                                let mediaClass = link.properties["media.class"] || "";
                                if (mediaClass.includes(root.nodeType)) {
                                    nodes.push(link);
                                }
                            }
                        }
                    }
                }
                return nodes;
            }
            
            AudioNodeCard {
                Layout.fillWidth: true
                node: modelData
            }
        }
        
        // Empty state
        Item {
            Layout.fillWidth: true
            Layout.fillHeight: true
            visible: nodeRepeater.count === 0
            
            ColumnLayout {
                anchors.centerIn: parent
                spacing: 15
                
                Text {
                    text: root.emptyIcon
                    font.pixelSize: 64
                    font.family: "JetBrains Mono Nerd Font"
                    color: "#45475a"
                    Layout.alignment: Qt.AlignHCenter
                }
                
                Text {
                    text: root.emptyText
                    font.pixelSize: 16
                    color: "#6c7086"
                    Layout.alignment: Qt.AlignHCenter
                }
            }
        }
    }
}
