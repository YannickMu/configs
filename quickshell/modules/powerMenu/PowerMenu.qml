import Quickshell
import Quickshell.Io
import QtQuick
import QtQuick.Layouts
import qs.modules.singletons

PanelWindow {
    id: root
    required property int barHeight
    property var modelData
    screen: modelData
    anchors {
        top: true
        left: true
    }

    function startTimer() {
        graceTimer.start();
    }

    property bool shouldBeVisible: {
        return FoldOutManager.isOpen("powermenu") && FoldOutManager.getScreenName("powermenu") === root.screen.name;
    }

    visible: shouldBeVisible
    implicitHeight: barHeight
    implicitWidth: 24 * 8
    exclusiveZone: barHeight
    color: "transparent"

    Component.onCompleted: {
        FoldOutManager.registerFoldout("powermenu");
    }

    Process {
        id: processHandler
    }

    property var menuModel: [
        {
            icon: "\udb81\udc25",
            cmd: ["systemctl", "poweroff"]
        },
        {
            icon: "\udb81\udf09",
            cmd: ["reboot"]
        },
        {
            icon: "\udb81\udcb2",
            cmd: ["systemctl", "suspend"]
        },
        {
            icon: "\udb80\udf41",
            cmd: ["/home/smuely/.config/hypr/lock.sh"]
        },
    ]

    Rectangle {
    id: menu
    y: 0
    clip: true
    color: Colors.background
    height: root.shouldBeVisible ? root.barHeight : 0
    width: 24 * 8
    bottomRightRadius: 16
    
    property int hoveredIndex: -1

    Behavior on height {
        NumberAnimation {
            duration: 250
            easing.type: Easing.InOutCirc
        }
    }

    Timer {
        id: graceTimer
        interval: 500
        onTriggered: {
            var triggerHovered = FoldOutManager.isTriggerHovered("powermenu", root.screen.name);
            if (!menuMouseArea.containsMouse && !triggerHovered) {
                FoldOutManager.toggle("powermenu", root.screen.name, false);
            }
        }
    }

    MouseArea {
        id: menuMouseArea
        anchors.fill: parent
        hoverEnabled: true
        cursorShape: Qt.PointingHandCursor
        onEntered: {
            FoldOutManager.toggle("powermenu", root.screen.name, true);
            graceTimer.stop();
        }
        onExited: {
            menu.hoveredIndex = -1;
            graceTimer.start();
        }
        onPositionChanged: {
            // Calculate which icon is under the cursor
            var row = menu.children[1]; // The Row element
            var iconWidth = 28;
            var spacing = 14;
            var totalWidth = (iconWidth + spacing) * root.menuModel.length;
            var startX = (menu.width - totalWidth) / 2;
            
            var found = false;
            for (var i = 0; i < root.menuModel.length; i++) {
                var iconX = startX + i * (iconWidth + spacing);
                if (mouse.x >= iconX && mouse.x < iconX + iconWidth) {
                    menu.hoveredIndex = i;
                    found = true;
                    break;
                }
            }
            if (!found) {
                menu.hoveredIndex = -1;
            }
        }
        onClicked: {
            if (menu.hoveredIndex >= 0) {
                processHandler.exec(root.menuModel[menu.hoveredIndex].cmd);
                FoldOutManager.toggle("powermenu", root.screen.name, false);
            }
        }
    }

    Row {
        anchors.centerIn: parent
        spacing: 24
        Repeater {
            model: root.menuModel
            delegate: Text {
                text: modelData.icon
                color: menu.hoveredIndex === index ? Colors.primary : "#ffffff"
                font {
                    family: "FiraCode Nerd Font Mono"
                    pixelSize: 28
                }
                anchors.verticalCenter: parent.verticalCenter
                
                Behavior on color {
                    ColorAnimation { duration: 100 }
                }
            }
        }
    }
  }
}
