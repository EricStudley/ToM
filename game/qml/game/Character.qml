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

    Behavior on x{enabled:true;PropertyAnimation{duration:playerSpeed}}
    Behavior on y{enabled:true;PropertyAnimation{duration:playerSpeed}}

    function stop(){
        character.x=lastX
        character.y=lastY
    }
}
