import QtQuick 2.0

Item{
    id:root
    height:1200
    width:1920

    property bool playerMoving

    property int characterMiddleX: character.x+(character.width/2)
    property int characterMiddleY: character.y+(character.height/2)

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

    property int windowShort:root.width>root.height?root.width:root.height
    property int windowLong:root.width>root.height?root.height:root.width

    Map{
        id:map
        height:windowShort
        width:height
        maxSize:windowLong
        anchors.centerIn: parent
    }

    Character{
        id:character
        spellType: spellbook.selectedSpell
        playerDirection: "left"
        x: mapMiddleX-(character.width/2)
        y: mapMiddleY-(character.height/2)

        Timer {
            id: updatePosition
            interval: 1
            repeat: true
            running: true
            onTriggered:{
                character.lastX=parent.x
                character.lastY=parent.y
            }
        }
        onXChanged: {
            spell.resetPointX=characterMiddleX
        }
        onYChanged: {
            spell.resetPointY=characterMiddleY
        }
    }

    Spellbook{
        id:spellbook
        spellbookMode:false
        z:100
    }

    Spell{
        id:spell
        resetPointX:characterMiddleX
        resetPointY:characterMiddleY
    }

    Component{
        id:enemyComp
        Enemy{
            id: enemy
            height:180
            width:130
            x: mapMiddleX-(enemy.width/2)
            y: map.y+(map.height/2)-500

            Timer {
                id: huntTimer
                interval: 1
                repeat: true
                running: true
                onTriggered:{
                    enemy.lastX=parent.x
                    enemy.lastY=parent.y
                    parent.playerTargetX=parent.width>character.width?character.x-((enemy.width-character.width)/2):x=character.x+((character.width-enemy.width)/2)
                    parent.playerTargetY=parent.height>character.height?character.y-((enemy.height-character.height)/2):character.y+((character.height-enemy.height)/2)
                    if(checkCollision(character,parent)){
                        enemy.frozen=true
                    }
                }
            }
        }
    }

    Timer {
        id: enemyTimer
        interval: getRandom(10000,20000)
        repeat: false
        running: true
        onTriggered:{
            spawnEnemy()
        }
    }

    MouseArea{
        anchors.fill: parent
        focus:true
        enabled:!spellbook.spellbookMode
        hoverEnabled:true
        onHoveredChanged: {
            switch(spellbook.selectedSpell){
                case 1: fireSpell(1,getRotation((character.x-(character.width/2)),(character.y+(character.height/2)),mouse)); break;
                case 2: fireSpell(2,getRotation((character.x-(character.width/2)),(character.y+(character.height/2)),mouse)); break;
                case 3: fireSpell(3,getRotation((character.x-(character.width/2)),(character.y+(character.height/2)),mouse)); break;
                case 4: fireSpell(4,getRotation((character.x-(character.width/2)),(character.y+(character.height/2)),mouse)); break;
                case 5: fireSpell(5,getRotation((character.x-(character.width/2)),(character.y+(character.height/2)),mouse)); break;
                case 6: fireSpell(6,getRotation((character.x-(character.width/2)),(character.y+(character.height/2)),mouse)); break;
                case 7: fireSpell(7,getRotation((character.x-(character.width/2)),(character.y+(character.height/2)),mouse)); break;
            }
        }
        onPressed:{
            playerMoving=true
            moveCharacter(mouse)
            console.log("X: "+mouse.x)
            console.log("Y: "+mouse.y)
        }
        onReleased: playerMoving=false
        onPositionChanged: {
            if(playerMoving)
                moveCharacter(mouse)
        }
    }

//    Keys.onLeftPressed: {
//        if(character.x>=505){
//            character.x-=10
//        }
//        character.playerDirection="left"
//        spell.resetPointX=characterMiddleX
//        spell.resetPointY=characterMiddleY
//        event.accepted = true;
//    }

//    Keys.onRightPressed: {
//        if(character.x<=1325){
//            character.x+=10
//        }
//        character.playerDirection="right"
//        spell.resetPointX=characterMiddleX
//        spell.resetPointY=characterMiddleY
//        event.accepted = true;
//    }

//    Keys.onUpPressed: {
//        if(character.y>=145){
//            character.y-=10
//        }
//        spell.resetPointX=characterMiddleX
//        spell.resetPointY=characterMiddleY
//        event.accepted = true;
//    }

//    Keys.onDownPressed: {
//        if(character.y<=915){
//            character.y+=10
//        }
//        spell.resetPointX=characterMiddleX
//        spell.resetPointY=characterMiddleY
//        event.accepted = true;
//    }

    Keys.onSpacePressed: {
        spellbook.spellbookMode=!spellbook.spellbookMode
        event.accepted = true;
    }

    function moveCharacter(move){
        character.stop()
        var direction=getRotation(characterMiddleX,characterMiddleY,move)
        var xDif=(Math.abs((character.x)-(move.x)))
        var yDif=(Math.abs((character.y)-(move.y)))
        var pythag=Math.sqrt((xDif^2)+(yDif^2))
        if(pythag<100)
            character.playerSpeed=pythag*40
        else
            character.playerSpeed=pythag*30
        if(direction<45 || direction>315){
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

//        if(moveX<=505){
//            character.x=505
//            if(moveY<=145){
//                character.y=145
//            }
//            else if(moveY>=915){
//                character.y=915
//            }
//            else{
//                character.y=moveY-(character.height/2)
//            }
//        }
//        else if(moveX>=1325){
//            character.x=1325
//            if(moveY<=145){
//                character.y=145
//            }
//            else if(moveY>=915){
//                character.y=915
//            }
//            else{
//                character.y=moveY-(character.height/2)
//            }
//        }
//        else{
//            character.x=moveX-(character.width/2)
//            if(moveY<=145){
//                character.y=145
//            }
//            else if(moveY>=915){
//                character.y=915
//            }
//            else{
//                character.y=moveY-(character.height/2)
//            }
//        }
        character.x=move.x-(character.width/2)
        character.y=move.y-(character.height/2)

        spell.resetPointX=characterMiddleX
        spell.resetPointY=characterMiddleY
    }

    function getRandom(minimum, maximum){
        var now = new Date()
        return Math.floor(Math.random(now.getSeconds()) * (maximum - minimum + 1)) + minimum;
    }

    function checkCollision(a, b) {
        return !(
            ((a.y + a.height) < (b.y)) ||
            (a.y > (b.y + b.height)) ||
            ((a.x + a.width) < b.x) ||
            (a.x > (b.x + b.width))
        )
    }

    function fireSpell(spellType, rotation){
        spell.spellType=spellType
        spell.x = (character.x+(character.width/2)) + (200 * Math.sin(rotation*(Math.PI/180)))
        spell.y = (character.y+(character.height/2)) + -(200 * Math.cos(rotation*(Math.PI/180)))
    }

    function spawnEnemy(){
        var enemy=enemyComp.createObject(root,{"playerTargetX":characterMiddleX,"playerTargetY":characterMiddleY})
    }

    function getRotation(x, y, point){
        if(point.x>=x){
            if(point.y>=y)
                return 180-(Math.atan((point.x-x)/(point.y-y))*(180/Math.PI))
            else
                return Math.atan((point.x-x)/(y-point.y))*(180/Math.PI)
        }
        else{
            if(point.y>y)
                return 180+(Math.atan((x-point.x)/(point.y-y))*(180/Math.PI))
            else
                return 360-(Math.atan((x-point.x)/(y-point.y))*(180/Math.PI))
        }
    }
}
