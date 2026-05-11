import Quickshell
import QtQuick
import QtQuick.Layouts
import qs.modules.bar.Blocks.Right
import qs.modules.bar.Blocks.Center
import qs.modules.bar.Blocks.Left

import qs.modules.singletons

PanelWindow {
    id: root
    required property int barHeight
    required property var rootWindow
    property var modelData
    screen: modelData
    anchors {
        top: true
        left: true
        right: true
    }
    implicitHeight: barHeight
    exclusiveZone: barHeight
    color: "transparent"
    Rectangle {
        implicitHeight: root.barHeight
        anchors.fill: parent
        color: Colors.background
        LeftRow {
            id: leftRow
            screenName: root.screen.name
        }

        CenterRow {
            id: centerRow
            screenName: root.screen.name
        }

        RightRow {
            id: rightRow
            rootWindow: root.rootWindow
        }
    }
}
