import QtQuick 2.0
import "Settings.js" as Settings
import "Logic.js" as Logic

Item{
    focus: true

    Loader{
        id:windowLoader
        source: "Welcome.qml"
        sourceComponent: undefined
    }

    Component{
        id: room1
        Level{
            rmapSource: "maps/1.png"
            rcharSpawnX: rmapPointMX
            rcharSpawnY: rmapPointBLY
        }
    }

    Component{
        id: room2
        Level{
            rmapSource: "maps/2.png"
            rcharSpawnX: rmapPointMX
            rcharSpawnY: rmapPointBLY
        }
    }

    Component{
        id: room3
        Level{
            rmapSource: "maps/3.png"
            rcharSpawnX: rmapPointMX
            rcharSpawnY: rmapPointBLY
        }
    }

    Rectangle{
        z:-10
        anchors.fill:parent
        color:"black"
    }
}
