import QtQuick 2.0

Image{
    id:spell
    opacity:1
    source:"misc/spell_"+spellType+".png"
    fillMode:Image.PreserveAspectFit

    property int spellType
    property int resetPointX
    property int resetPointY


    Behavior on opacity{PropertyAnimation{duration:200}}
    Behavior on x{PropertyAnimation{easing.type:Easing.InCubic;duration:200}}
    Behavior on y{PropertyAnimation{easing.type:Easing.InCubic;duration:200}}
}
