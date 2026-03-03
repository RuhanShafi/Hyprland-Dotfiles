import Quickshell
import Quickshell.Wayland
import Quickshell.Io
import Quickshell.Hyprland
import QtQuick
import QtQuick.Layouts

Repeater {
  model: Quickshell.screens
  PanelWindow {
    id:panel
    anchors {
      top:true
      left:true
      right:true
    }
    implicitHeight: 40
    margins {
      top:0
      left:0
      right:0

      Rectangle {
        id: bar
        anchors.fill:parent
      }
    }
  }
}
