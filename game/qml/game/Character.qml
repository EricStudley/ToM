import QtQuick 2.0

Image {
    id:character
    property int lastX
    property int lastY
    property int playerSpeed
    property int spellType
    property string playerDirection
    height: 130
    width:90
    source:"characters/player_"+spellType+"_"+playerDirection+".png"
    fillMode: Image.PreserveAspectFit

    Behavior on x{ enabled:true; PropertyAnimation{  duration: playerSpeed}}
    Behavior on y{ enabled:true; PropertyAnimation{  duration: playerSpeed}}

    function stop(){
        character.x=lastX
        character.y=lastY
    }
}
