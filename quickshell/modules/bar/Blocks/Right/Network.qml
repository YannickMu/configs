import QtQuick
import Quickshell
import Quickshell.Io

Item {
    id: root
    visible: false

    property string wifiInterface: "wlan0"
    property string wifiSSID:      "None"
    property bool   wifiConnected: false

    property string ethInterface: "eth0"
    property string ethState:     "down"
    property bool   ethConnected: false

    property int pollInterval: 5000

    Process {
        id: wifiProc
        command: ["sh", "-c", "iw dev | awk '/Interface/{iface=$2} /ssid/{print iface \":\" $2}'"]

        stdout: StdioCollector { id: wifiOut }

        onExited: function(code) {
            var text = wifiOut.text.trim()
            if (text === "") {
                root.wifiInterface = ""
                root.wifiSSID      = ""
                root.wifiConnected = false
                return
            }
            var sep = text.indexOf(":")
            if (sep < 0) return
            root.wifiInterface = text.substring(0, sep)
            root.wifiSSID      = text.substring(sep + 1).trim()
            root.wifiConnected = root.wifiSSID !== ""
        }
    }

    Process {
        id: ethProc
        command: [
            "sh", "-c",
            "for f in /sys/class/net/*/operstate; do " +
            "  iface=$(echo $f | awk -F/ '{print $5}'); " +
            "  type=$(cat /sys/class/net/$iface/type 2>/dev/null); " +
            "  [ \"$type\" != \"1\" ] && continue; " +
            "  [ \"$iface\" = \"lo\" ] && continue; " +
            "  echo \"$iface:$(cat $f)\"; " +
            "done"
        ]

        stdout: StdioCollector { id: ethOut }

        onExited: function(code) {
            var text = ethOut.text.trim()
            if (text === "") {
                root.ethInterface = ""
                root.ethState     = ""
                root.ethConnected = false
                return
            }
            var sep = text.indexOf(":")
            if (sep < 0) return
            root.ethInterface = text.substring(0, sep)
            root.ethState     = text.substring(sep + 1).trim()
            root.ethConnected = root.ethState === "up"
        }
    }

    Timer {
        interval: root.pollInterval
        running:  true
        repeat:   true
        onTriggered: {
            wifiProc.running = false
            wifiProc.running = true
            ethProc.running  = false
            ethProc.running  = true
        }
    }

    Component.onCompleted: {
        wifiProc.running = true
        ethProc.running  = true
    }
}
