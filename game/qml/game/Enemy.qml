import QtQuick 2.0

Item{
    id:enemy
    x:map.mapMiddleX-(enemy.width/2)
    y:map.y+(map.height/2)-500
    z:y+enemy.height
    width:130
    height:180

    property int lifeLeft: 100
    property bool dead:false
    property bool beenHit:false

    property int lastX
    property int lastY
    property bool hitBySpell:false
    property int hitByEffect
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
        visible:hitBySpell
        source:"misc/spellEffect_"+hitByEffect+".png"
    }

    Timer{
        id:huntTimer
        interval:1
        repeat:true
        running:!hitBySpell
        onTriggered:{
            parent.x=playerTargetX
            parent.y=playerTargetY
        }
    }

    Healthbar {
        id: healthbar
        anchors.bottom: parent.top
        lifeLeft: parent.lifeLeft
        opacity: 0

        Behavior on opacity{
            SequentialAnimation{
                PropertyAnimation{
                    duration: 0
                }
                PauseAnimation {
                    duration: 3000
                }
                PropertyAnimation{
                    to: 0
                    duration: 1000
                }
            }
        }

        onLifeLeftChanged: {
            healthbar.opacity=1
            enemy.beenHit=true
            hitTimer.start()
            if(lifeLeft==0){
                enemy.destroy()
                enemy.dead=true
            }
        }
    }

    Timer{
        id:hitTimer
        interval:2750
        repeat:false
        onTriggered:{
            enemy.beenHit=false
        }
    }

    Item{
        Component.onCompleted: healthbar.opacity=0
    }

    Behavior on hitBySpell{ScriptAction{ script: stop()}}
    Behavior on x{id:xMotion;enabled:true;SmoothedAnimation{id: xAnim; velocity:enemySpeed}}
    Behavior on y{id:yMotion;enabled:true;SmoothedAnimation{id: yAnim; velocity:enemySpeed}}

    function stop(){
        xAnim.stop()
        yAnim.stop()
        enemy.x=lastX
        enemy.y=lastY
        huntTimer.running=false
    }

    function start(){
        huntTimer.running=true
    }
}
