import QtQuick 2.0

Item{
    id:enemy
    property bool frozen:false
    property int lastX
    property int lastY
    property int enemySpeed:50
    property int playerTargetX
    property int playerTargetY

    Image{
        anchors.fill: parent
        source:"/Users/Eric/Documents/game/qml/game/characters/ogre2.png"
        fillMode: Image.PreserveAspectFit
    }

    Image{
        id:spellEffect
        width:200
        height:200
        anchors.centerIn: parent
        visible:frozen
        source:"/Users/Eric/Documents/game/qml/game/misc/spellEffect_1.png"
    }

    Timer{
        id: huntTimer
        interval: 1
        repeat: true
        running: !frozen
        onTriggered:{
            parent.x=playerTargetX
            parent.y=playerTargetY
        }
    }

    Behavior on x{ id:xMotion; enabled:true; SmoothedAnimation{  velocity: enemySpeed}}

    Behavior on y{ id:yMotion; enabled:true; SmoothedAnimation{  velocity: enemySpeed}}

    function stop(){
        enemy.x=lastX
        enemy.y=lastY
        huntTimer.running=false
    }

    function start(){
        huntTimer.running=true
    }
}
