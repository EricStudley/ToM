import QtQuick 2.0

Image{
    id:spell
    opacity:0
    fillMode:Image.PreserveAspectFit

    property int counter:1
    property int spellType

    Timer{
        id:spellTimer
        interval:5
        repeat:true
        running:true
        onTriggered:{
            if(counter<28){
                parent.source="spells/spell_1_"+counter+".png"
            }
            else{
                counter=1
            }
            counter++
        }
    }
}
