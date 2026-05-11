pragma Singleton
import QtQuick


QtObject {
  readonly property color background: "#2a1a2a"
  readonly property color background2: "#4a2a4a"
  readonly property color primary: "#dd44cc"
  readonly property color white: "#ffffff"

  // Workspace colors
  readonly property color activeWorkspace: "#8844ee"
  readonly property color inactiveWorkspace: "#4a2a4a"
  readonly property color urgentWorkspace: "#dd44cc"

  // Battery colors
  readonly property color criticalBattery: "#ff0000"
  readonly property color chargingBattery: "#11aa11"

  // Network colors
  readonly property color connected: "#afa"
  readonly property color disconnected: "#888"
}
