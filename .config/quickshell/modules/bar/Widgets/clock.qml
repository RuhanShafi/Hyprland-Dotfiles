import QtQuick
import QtQuick.Layouts

Rectangle {
    id: clockWidget
    
    // Widget properties - customizable
    property color textColor: "#eba0ac"  // Maroon from Catppuccin
    property color bgColor: "#1e1e2e"
    property int fontSize: 14
    property string clockIcon: ""
    property string timeFormat: "hh:mm:ss"
    property string dateFormat: "dddd d MMM yyyy"
    property bool showDate: true
    property bool showTime: true
    
    implicitWidth: widgetLayout.implicitWidth + 20
    implicitHeight: parent.height
    color: bgColor
    radius: 15
    
    RowLayout {
        id: widgetLayout
        anchors.centerIn: parent
        spacing: 8
        
        Text {
            text: clockWidget.clockIcon
            color: clockWidget.textColor
            font.pixelSize: clockWidget.fontSize
            font.family: "JetBrains Mono Nerd Font"
            visible: clockWidget.clockIcon !== ""
        }
        
        Text {
            id: dateText
            text: Qt.formatDate(new Date(), clockWidget.dateFormat)
            color: clockWidget.textColor
            font.pixelSize: clockWidget.fontSize
            font.family: "JetBrains Mono Nerd Font"
            visible: clockWidget.showDate
        }
        
        Text {
            text: "|"
            color: clockWidget.textColor
            font.pixelSize: clockWidget.fontSize
            visible: clockWidget.showDate && clockWidget.showTime
        }
        
        Text {
            id: timeText
            text: Qt.formatTime(new Date(), clockWidget.timeFormat)
            color: clockWidget.textColor
            font.pixelSize: clockWidget.fontSize
            font.family: "JetBrains Mono Nerd Font"
            visible: clockWidget.showTime
        }
    }
    
    // Update timer
    Timer {
        interval: 1000
        running: true
        repeat: true
        onTriggered: {
            var now = new Date()
            timeText.text = Qt.formatTime(now, clockWidget.timeFormat)
            dateText.text = Qt.formatDate(now, clockWidget.dateFormat)
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
        
        onClicked: {
            console.log("Clock clicked - could open calendar")
        }
    }
}
