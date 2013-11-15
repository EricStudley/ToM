import QtQuick 2.0

Item{

    Rectangle{
        anchors.fill: parent
        color:"black"
        z:-100
    }

    Row{
        anchors.centerIn: parent

        ExpBar {
            id:bar
            z:100
            anchors.verticalCenter: talents.verticalCenter
            value: .01
            charging: false
            maxLiquidRotation: 0
            rotation: -90

            Timer{
                interval:2000
                repeat:true
                running:true
                onTriggered:{
                    parent.value+=.05
                }
            }
        }

        TreeView{
            id:talents
            value: bar.value
        }
    }
}
