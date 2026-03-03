// Where everything is loaded

import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import QtQuick.Window
import Quickshell
import Quickshell.Wayland // Required for Wayland-specific features like PanelWindow

import "./modules/bar/"

ShellRoot {
  id: root

  Loader {
    active: true
    sourceComponent: Bar {}
  }
}
