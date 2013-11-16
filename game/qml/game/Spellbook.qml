import QtQuick 2.0

Item{
    id:spellbook
    anchors.centerIn:parent
    opacity:spellbookMode?1:0

    property int selectedSpell
    property bool spellbookMode:false

    Repeater{
        id:spells
        model:6

        Image{
            opacity:spellbookMode?1:0
            z:10
            source:"icons/spellicon_"+(modelData+1)+".png"
            x:(scroll.x+(scroll.width/2))+(150 * Math.sin(((360/6)*(modelData+1))*(Math.PI/180)))-50
            y:(scroll.y+(scroll.height/2))+-(150 * Math.cos(((360/6)*(modelData+1))*(Math.PI/180)))-30

            Behavior on opacity{ PropertyAnimation{duration:200}}
        }
    }

    Image{
        id:well
        z:200
        width: 60
        anchors.horizontalCenter: scroll.horizontalCenter
        anchors.verticalCenter: scroll.verticalCenter
        anchors.verticalCenterOffset: 20
        anchors.horizontalCenterOffset: -13
        opacity:spellbookMode?1:0
        source:"misc/well.png"
        fillMode: Image.PreserveAspectFit
        Repeater{
            id:stones
            model:4
            Image{
                id:rune
                opacity:spellbookMode?1:0
                source:"icons/r"+(modelData+1)+".png"
                z:300+(modelData+1)

                MouseArea{
                    z:1000
                    anchors.fill: parent
                    drag.target: parent
                    drag.axis: "XandYAxis"
                    drag.minimumX: -200
                    drag.maximumX: 200
                    drag.minimumY: -200
                    drag.maximumY: 200
                    onReleased: {
                        checkPlacement(rune)
                    }
                }
            }
        }

        Behavior on opacity{PropertyAnimation{duration:200}}
    }

    Image{
        id:scroll
        z:0
        height:900
        anchors.centerIn: parent
        opacity:spellbookMode?1:0
        source:"misc/scroll.png"
        fillMode: Image.PreserveAspectFit

        Behavior on opacity{PropertyAnimation{duration:200}}

        Image{
            id:symbol
            z:100
            height: 466
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.verticalCenter: parent.verticalCenter
            anchors.verticalCenterOffset: 20
            anchors.horizontalCenterOffset: -13
            opacity:.3
            fillMode: Image.PreserveAspectFit
            source:"misc/water.png"
        }

        MouseArea{
            anchors.fill: parent
        }
    }

    function checkPlacement(rune){
        var placement = getRotation(0, 0, rune.x+(rune.width/2), rune.y+(rune.height/2))
        if(placement>((1/(spells.count*2))*360)&&placement<=((3/(spells.count*2))*360)){
            var runePlace=1
        }
        else if(placement>((3/(spells.count*2))*360)&&placement<=((5/(spells.count*2))*360)){
            var runePlace=2
        }
        else if(placement>((5/(spells.count*2))*360)&&placement<=((7/(spells.count*2))*360)){
            var runePlace=3
        }
        else if(placement>((7/(spells.count*2))*360)&&placement<=((9/(spells.count*2))*360)){
            var runePlace=4
        }
        else if(placement>((9/(spells.count*2))*360)&&placement<=((11/(spells.count*2))*360)){
            var runePlace=5
        }
        else{
            var runePlace=6
        }
        rune.x=(150 * Math.sin(((360/6)*(runePlace))*(Math.PI/180)))-10
        rune.y=-(150 * Math.cos(((360/6)*(runePlace))*(Math.PI/180)))-20

        var check=false
        for(var i=0; i<stones.count;i++){
            if(well.children[i].x==0){
                check=true
            }
        }
        if(check==false){
            spellbookMode=false
        }
    }

    function getRandom(minimum,maximum){
        var now=new Date()
        return Math.floor(Math.random(now.getSeconds())*(maximum-minimum+1))+minimum;
    }

    function getRotation(x, y, pointx, pointy){
        if(pointx>=x){
            if(pointy>=y)
                return 180-(Math.atan((pointx-x)/(pointy-y))*(180/Math.PI))
            else
                return Math.atan((pointx-x)/(y-pointy))*(180/Math.PI)
        }
        else{
            if(pointy>y)
                return 180+(Math.atan((x-pointx)/(pointy-y))*(180/Math.PI))
            else
                return 360-(Math.atan((x-pointx)/(y-pointy))*(180/Math.PI))
        }
    }
}

