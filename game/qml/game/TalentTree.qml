import QtQuick 2.0
import QtGraphicalEffects 1.0
import QtQuick.Particles 2.0

Item{

    property bool talentMode:false
    property int barX:bar.x
    property int barY:bar.y
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
        visible:talentMode
        enabled:talentMode

    }
}
