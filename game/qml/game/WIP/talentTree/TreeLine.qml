import QtQuick 2.0
import QtGraphicalEffects 1.0

Item{
    id: root
    property bool active:false

    Rectangle {
        id:line
        width: parent.width
        height: 0
        z:10
        color:"red"

        Behavior on width{
            PropertyAnimation{
                duration:1000
            }
        }
        Behavior on height{
            PropertyAnimation{
                duration:1000
            }
        }

        RectangularGlow{
            id: effect
            visible:root.active
            anchors.fill: line
            glowRadius: 10
            spread: 0.1
            color: "#660000"
        }
    }

    Rectangle {
        id:blackline
        width: parent.width
        height: parent.height
        z:-10
        color:"black"
    }

    onActiveChanged:{
        line.width=root.width
        line.height=root.height
    }
}
