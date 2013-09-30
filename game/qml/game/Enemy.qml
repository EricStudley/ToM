import QtQuick 2.0

Item{
    id:enemy

    property int lastX
    property int lastY
    property bool frozen:false
    property int playerTargetX
    property int playerTargetY
    property int enemySpeed:50

    Image{
        anchors.fill:parent
        source:"characters/ogre.png"
        fillMode:Image.PreserveAspectFit
    }

    Image{
        id:spellEffect
        width:200
        height:200
        anchors.centerIn:parent
        visible:frozen
        source:"misc/spellEffect_1.png"
    }

    Timer{
        id:huntTimer
        interval:1
        repeat:true
        running:!frozen
        onTriggered:{
            parent.x=playerTargetX
            parent.y=playerTargetY
        }
    }

    Behavior on x{id:xMotion;enabled:true;SmoothedAnimation{velocity:enemySpeed}}

    Behavior on y{id:yMotion;enabled:true;SmoothedAnimation{velocity:enemySpeed}}

    function stop(){
        enemy.x=lastX
        enemy.y=lastY
        huntTimer.running=false
    }

    function start(){
        huntTimer.running=true
    }
}
