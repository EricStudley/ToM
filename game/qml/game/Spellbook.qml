import QtQuick 2.0

Item{
    id:spellbook
    anchors.centerIn:parent
    opacity:spellbookMode?1:0

    property int selectedSpell
    property bool spellbookMode:false

    Image{
        id:scroll
        height:700
        z:-10
        anchors.centerIn: parent
        opacity:parent.opacity
        source:"misc/scroll.png"
        fillMode: Image.PreserveAspectFit

        Behavior on opacity{PropertyAnimation{duration:200}}

        SpellDrawArea{
            id:cell
            width:scroll.width/2.5
            height:scroll.height/1.5
            anchors.centerIn: parent
            lineWidth: 5
            lineColor:"black"
        }
    }

    Repeater{
        model:7

        Image{
            opacity:spellbook.opacity
            source:"icons/spellicon_"+(modelData+1)+".png"
            x:(scroll.x+(scroll.width/2))+(150 * Math.sin(((360/7)*(modelData+1))*(Math.PI/180)))-50
            y:(scroll.y+(scroll.height/2))+-(150 * Math.cos(((360/7)*(modelData+1))*(Math.PI/180)))-30

            Behavior on opacity{ PropertyAnimation{duration:200}}

            MouseArea{
                anchors.fill:parent
                enabled:spellbookMode
                onClicked:{
                    selectedSpell=(modelData+1)
                    spellbookMode=false
                }
            }
        }
    }

    onSpellbookModeChanged: {
        cell.clearDrawArea()
    }
}
