import QtQuick
import QtQuick.Layouts

Rectangle {
    id: cpuWidget
    
    // Widget properties - customizable
    property color textColor: "#f38ba8"  // Red from Catppuccin
    property color bgColor: "#1e1e2e"
    property int fontSize: 14
    property string cpuIcon: ""
    property real cpuUsage: 0.0
    
    implicitWidth: widgetLayout.implicitWidth + 20
    implicitHeight: parent.height
    color: bgColor
    radius: 15
    
    RowLayout {
        id: widgetLayout
        anchors.centerIn: parent
        spacing: 5
        
        Text {
            text: cpuWidget.cpuIcon
            color: cpuWidget.textColor
            font.pixelSize: cpuWidget.fontSize
            font.family: "JetBrains Mono Nerd Font"
        }
        
        Text {
            text: Math.round(cpuWidget.cpuUsage) + "%"
            color: cpuWidget.textColor
            font.pixelSize: cpuWidget.fontSize
            font.family: "JetBrains Mono Nerd Font"
        }
    }
    
    // Update timer - placeholder for actual CPU monitoring
    Timer {
        interval: 1000
        running: true
        repeat: true
        onTriggered: {
            // This will be replaced with actual CPU monitoring
            cpuWidget.cpuUsage = Math.random() * 100
        }
    }
    
    // Hover effect
    MouseArea {
        anchors.fill: parent
        hoverEnabled: true
        
        onEntered: {
            parent.opacity = 0.8
        }
        
        onExited: {
            parent.opacity = 1.0
        }
    }
}
