import QtQuick 2.0
import "Settings.js" as Settings
import "Logic.js" as Logic

Item{
    id:root
    width:Settings.screenWidth
    height:Settings.screenHeight

    property int mouseHoverX
    property int mouseHoverY
    property bool playerMoving
    property int mapTopLeftX:map.x
    property int mapTopLeftY:map.y
    property int mapTopRightX:map.x+map.width
    property int mapTopRightY:map.y
    property int mapMiddleX:map.x+(map.width/2)
    property int mapMiddleY:map.y+(map.height/2)
    property int mapBottomLeftX:map.x
    property int mapBottomLeftY:map.y+map.height
    property int mapBottomRightX:map.x+map.width
    property int mapBottomRightY:map.y+map.height
    property int characterMiddleX:character.x+(character.width/2)
    property int characterMiddleY:character.y+(character.height/2)
    property int windowShort:root.width>root.height?root.width:root.height
    property int windowLong:root.width>root.height?root.height:root.width

    Map{
        id:map
        width:height
        height:windowShort
        anchors.centerIn:parent
        maxSize:windowLong
    }

    Character{
        id:character
        x:mapMiddleX-(character.width/2)
        y:mapMiddleY-(character.height/2)
        z:50
        playerDirection:"left"
        spellType:spellbook.selectedSpell

        Timer{
            id:updatePosition
            interval:1
            repeat:true
            running:true
            onTriggered:{
                character.lastX=parent.x
                character.lastY=parent.y
            }
        }
    }

    Spellbook{
        id:spellbook
        z:100
        spellbookMode:false
    }

    Spell{
        id:spell
        x:characterMiddleX
        y:characterMiddleY
        z:25
    }

    Component{
        id:enemyComp

        Enemy{
            id: enemy
            width:130
            height:180
            x:mapMiddleX-(enemy.width/2)
            y:map.y+(map.height/2)-500

            onXChanged:{
                enemy.lastX=enemy.x
                enemy.lastY=enemy.y
            }

            Timer{
                id:huntTimer
                interval:1
                repeat:true
                running:true
                onTriggered:{
                    parent.playerTargetX=parent.width>character.width?character.x-((enemy.width-character.width)/2):character.x+((character.width-enemy.width)/2)
                    parent.playerTargetY=parent.height>character.height?character.y-((enemy.height-character.height)/2):character.y+((character.height-enemy.height)/2)
                    if(checkCollision(spell,parent)){
                        enemy.hitBySpell=true
                        enemy.hitByEffect=spellbook.selectedSpell
                    }
                }
            }

            Timer{
                id:punchTimer
                interval:1000
                repeat:true
                running:true
                onTriggered:{
                    if(checkCollision(character,parent)){
                        character.lifeLeft-=10
                    }
                }
            }
        }
    }

    Timer{
        id:enemyTimer
        interval:Logic.getRandom(1000,2000)
        repeat:true
        running:true
        onTriggered:{
            spawnEnemy()
        }
    }

    MouseArea{
        focus:true
        anchors.fill:parent
        enabled:!spellbook.spellbookMode
        hoverEnabled:true
        z:100
        onPressed:{
            playerMoving=true
            moveCharacter(mouse)
        }
        onReleased:{
            character.stop()
            playerMoving=false
        }
        onPositionChanged:{
            mouseHoverX=mouse.x
            mouseHoverY=mouse.y
            if(playerMoving)
                moveCharacter(mouse)
        }
    }

    Keys.onPressed: {
        if (event.key == Qt.Key_X) {
            spell.opacity=1
            fireSpell(spellbook.selectedSpell,getRotation((character.x-(character.width/2)),(character.y+(character.height/2)),mouseHoverX,mouseHoverY));
            event.accepted = true;
        }
    }

    Keys.onReleased: {
        if (event.key == Qt.Key_X) {
            spell.opacity=0
            event.accepted = true;
        }
    }

    Keys.onSpacePressed:{
        spellbook.spellbookMode=!spellbook.spellbookMode
        event.accepted=true;
    }

    function moveCharacter(move){
        character.stop()
        var direction=getRotation(characterMiddleX,characterMiddleY,move.x,move.y)
        var xDif=(Math.abs((character.x)-(move.x)))
        var yDif=(Math.abs((character.y)-(move.y)))
        var pythag=Math.sqrt((xDif^2)+(yDif^2))
        character.playerSpeed=pythag*40
        if(direction<45||direction>315){
            character.playerDirection="up"
        }
        else if(direction>45 && direction<135){
            character.playerDirection="right"
        }
        else if(direction>135 && direction<225){
            character.playerDirection="down"
        }
        else{
            character.playerDirection="left"
        }
        character.x=move.x-(character.width/2)
        character.y=move.y-(character.height/2)
    }

    function checkCollision(a,b){
        return !(
                    ((a.y+a.height)<(b.y))||
                    (a.y>(b.y+b.height))||
                    ((a.x+a.width)<b.x)||
                    (a.x>(b.x+b.width))
                    )
    }

    function fireSpell(spellType, rotation){
        spell.spellType=spellType
        spell.rotation=rotation
        spell.x = (character.x+(character.width/2)) + (150 * Math.sin(rotation*(Math.PI/180)))-(spell.width/2)
        spell.y = (character.y+(character.height/2)) + -(150 * Math.cos(rotation*(Math.PI/180)))-(spell.height/2)
    }

    function spawnEnemy(){
        var enemy=enemyComp.createObject(root,{"playerTargetX":characterMiddleX,"playerTargetY":characterMiddleY})
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
