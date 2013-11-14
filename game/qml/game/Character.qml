import QtQuick 2.0

Image{
    id:character
    width:90
    height:130
    source:"characters/player_"+spellType+"_"+playerDirection+".png"
    fillMode:Image.PreserveAspectFit

    property int lastX
    property int lastY
    property int spellType
    property int playerSpeed
    property string playerDirection
    property int lifeLeft: 100

    Behavior on x{enabled:true;PropertyAnimation{duration:playerSpeed}}
    Behavior on y{enabled:true;PropertyAnimation{duration:playerSpeed}}

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
        }
    }

    Item{
        Component.onCompleted: healthbar.opacity=0
    }

    onXChanged: {
        lastX=character.x
        lastY=character.y
    }

    function stop(){
        character.x=lastX
        character.y=lastY
    }
}
