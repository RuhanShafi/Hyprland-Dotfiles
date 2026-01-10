// Where everything is loaded

import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import QtQuick.Window
import Quickshell

import qs.modules.Bar

ShellRoot {
  id: root

  Bar {
    context: ctx
  }
}
