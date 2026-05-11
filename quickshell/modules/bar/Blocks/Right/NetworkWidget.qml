import QtQuick
import QtQuick.Layouts
import Quickshell
import Quickshell.Io
import Quickshell.Widgets

import qs.modules.singletons

RowLayout {
    spacing: 16    
    anchors {
        top: parent.top
        bottom: parent.bottom
    }
    Network { id: net }
    Process { id: processHandler }

    // WiFi indicator
    Text {
        visible: net.wifiConnected
        text: "󰖩 " + net.wifiSSID + " (" + net.wifiInterface + ")"
        color: net.wifiConnected ? Colors.connected : Colors.disconnected
        font.family: "FiraCode Nerd Font Propo"
        font.pixelSize: 16
        MouseArea {
          id: wifiMouseArea
          anchors.fill: parent
          onClicked: {
            processHandler.exec("iwgtk")
          }
        }
    }

    // Ethernet indicator
    Text {
        visible: net.ethInterface !== ""
        text: (net.ethConnected ? "󰈀 " : "󰈂 ") + net.ethInterface
        color: net.ethConnected ? "white" : Colors.disconnected
        font.family: "FiraCode Nerd Font Propo"
        font.pixelSize: 16
    }

    // Fallback: completely offline
    Text {
        visible: !net.wifiConnected && !net.ethConnected
        text: "󰤭  No network"
        color: "#f38ba8"
        font.family: "FiraCode Nerd Font Propo"
    }
}
