import Quickshell.Hyprland
import QtQuick

import qs.modules.singletons

Row {
    id: workspacesRow
    property string screenName: ""
    property var recInstances: []
    spacing: 8
    anchors {
        verticalCenter: parent.verticalCenter
    }

    function filterWorkspaces() {
        let workspaces = [];
        for (var workspace of Hyprland.workspaces.values) {
            if (!workspace.name.includes("special")) {
                workspaces.push(workspace);
            }
        }
        return workspaces;
    }

    Repeater {
        model: workspacesRow.filterWorkspaces()
        property var modelData

        Rectangle {
            id: rec
            visible: modelData.monitor !== null && modelData.monitor.name === workspacesRow.screenName
            property color activeColor: Colors.activeWorkspace
            property string inactiveColor: Colors.inactiveWorkspace
            property string urgentColor: Colors.urgentWorkspace
            width: textItem.implicitWidth + 16 * 1.5
            height: 24
            radius: 15
            color: modelData.active ? activeColor : (modelData.urgent ? urgentColor : inactiveColor)
            border.color: color
            border.width: 2

            Component.onCompleted: {
                workspacesRow.recInstances.push(rec);
            }

            MouseArea {
                property string oldColor: ""
                property string hoverColor: "#313131"
                property bool isActiveWorkspace: modelData.monitor !== null &&  modelData.monitor.activeWorkspace !== null && modelData.monitor.activeWorkspace.id === modelData.id
                hoverEnabled: !isActiveWorkspace
                anchors.fill: parent
                onClicked: {
                    if (!isActiveWorkspace) {
                        Hyprland.dispatch("workspace " + modelData.id);
                        oldColor = parent.inactiveColor;
                        parent.color = parent.activeColor;
                        enabled = isActiveWorkspace;
                    }
                }
                onIsActiveWorkspaceChanged: {
                    if (!isActiveWorkspace) {
                        parent.color = parent.inactiveColor;
                        oldColor = "";
                        enabled = !isActiveWorkspace;
                    } else {
                        parent.color = parent.activeColor;
                        oldColor = "";
                        enabled = !isActiveWorkspace;
                    }
                }
                onEntered: {
                    oldColor = parent.color;
                    parent.color = hoverColor;
                }
                onExited: {
                    parent.color = oldColor;
                    oldColor = parent.inactiveColor;
                }
            }

            Text {
                id: textItem
                text: modelData.name
                anchors.centerIn: parent
                color: modelData.active ? "#ffffff" : "#cccccc"
                font.pixelSize: 12
                font.family: "FiraCode Nerd Font Mono"
                verticalAlignment: Text.AlignVCenter
            }
        }
    }

    Text {
        visible: Hyprland.workspaces.length === 0
        text: "No workspaces"
        color: "#ffffff"
        font.pixelSize: 12
    }
}
