import QtQuick 2.0
import QtGraphicalEffects 1.0
import QtQuick.Particles 2.0
import "Settings.js" as Settings
import "Logic.js" as Logic

Item{
    id:root
    width:Settings.screenWidth
    height:Settings.screenHeight

    //FINAL
    property string rmapSource:"maps/dungeon.png"
    property string rmapLeft
    property string rmapRight
    property string rmapUp
    property string rmapDown
    property int rcharSpawnX: map.mapMiddleX-(character.width/2)
    property int rcharSpawnY: map.mapMiddleY-(character.height/2)
    property int rmapPointTLX: map.mapTopLeftX
    property int rmapPointTLY: map.mapTopLeftY
    property int rmapPointTRX: map.mapTopRightX
    property int rmapPointTRY: map.mapTopRightY
    property int rmapPointBLX: map.mapBottomLeftX
    property int rmapPointBLY: map.mapBottomLeftY
    property int rmapPointBRX: map.mapBottomRightX
    property int rmapPointBRY: map.mapBottomRightY
    property int rmapPointMX: map.mapMiddleX
    property int rmapPointMY: map.mapMiddleY
    property bool talentMode:false
    //

    property int mouseHoverX
    property int mouseHoverY
    property bool playerMoving
    property int characterMiddleX:character.x+(character.width/2)
    property int characterMiddleY:character.y+(character.height/2)

    Map{
        id:map
        height:parent.height
        anchors.fill:parent
        mapSource: rmapSource
    }

    ExpBar{
        id:exp
        z:9000
        anchors.verticalCenter: map.verticalCenter
        anchors.left:parent.left
        anchors.leftMargin: -100
        value: .01
        charging: false
        maxLiquidRotation: 0
        rotation: -90
    }

//    TalentTree{
//        id: talents
//        talentMode: true
//        visible:root.talentMode
//        anchors.centerIn: parent
//    }

    Character{
        id:character
        x:rcharSpawnX
        y:rcharSpawnY
        z:y+character.height
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
        z:10000
        spellbookMode:false
    }

    Spell{
        id:spell
        x:characterMiddleX
        y:characterMiddleY
        z:9000
    }

    Component{
        id:enemyComp

        Enemy{
            id: enemy

            onXChanged:{
                enemy.lastX=enemy.x
                enemy.lastY=enemy.y
            }

            onDeadChanged: {
                exp.value+=.3
            }

            Timer{
                id:huntTimer
                interval:1
                repeat:true
                running:true
                onTriggered:{
                    parent.playerTargetX=parent.width>character.width?character.x-((enemy.width-character.width)/2):character.x+((character.width-enemy.width)/2)
                    parent.playerTargetY=parent.height>character.height?character.y-((enemy.height-character.height)/2):character.y+((character.height-enemy.height)/2)
                    if(Logic.checkCollision(spell,parent)){
                        enemy.hitBySpell=true
                        enemy.hitByEffect=spellbook.selectedSpell
                        enemy.lifeLeft-=1
//                        if(!enemy.beenHit){
//                            var random=Logic.getRandom(1,100)
//                            if(random<90)
//                                enemy.lifeLeft-=Logic.getRandom(250-275)
//                            else
//                                enemy.lifeLeft-=Logic.getRandom(400,450)
//                        }
                    }
                }
            }

            Timer{
                id:punchTimer
                interval:1000
                repeat:true
                running:true
                onTriggered:{
                    if(Logic.checkCollision(character,parent)){
                        character.lifeLeft-=10
                    }
                }
            }
        }
    }

    Timer{
        id:enemyTimer
        interval:Logic.getRandom(10000,20000)
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
        z:100000
        onPressed:{
            playerMoving=true
            mouseHoverX=mouse.x
            mouseHoverY=mouse.y
            Logic.moveCharacter(mouse, character, characterMiddleX, characterMiddleY)
        }
        onReleased:{
            character.stop()
            playerMoving=false
        }
        onPositionChanged:{
            mouseHoverX=mouse.x
            mouseHoverY=mouse.y
            if(playerMoving)
                Logic.moveCharacter(mouse, character, characterMiddleX, characterMiddleY)
        }
    }

    Keys.onPressed: {
        if (event.key == Qt.Key_X) {
            spell.opacity=1
            fireSpell(spellbook.selectedSpell,Logic.getRotation((character.x-(character.width/2)),(character.y+(character.height/2)),mouseHoverX,mouseHoverY));
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

    Keys.onTabPressed: {
        if(root.talentMode==false){
            root.talentMode=true
        }
        else
            root.talentMode=false

        console.log(root.talentMode)
        event.accepted=true;
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
}
