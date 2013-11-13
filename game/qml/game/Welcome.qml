import QtQuick 2.0
import QtGraphicalEffects 1.0
import "Settings.js" as Settings
import "Logic.js" as Logic

Item {
    id: root
    width: Settings.screenWidth
    height: Settings.screenHeight
    opacity: 0

    property int selector: 0

    Rectangle{
        anchors.fill: parent
        color:"black"
    }

    Item{
        Component.onCompleted:{
            root.opacity=1
        }
    }

    Behavior on opacity {
        PropertyAnimation {
            duration: 1000
        }
    }

    NMapLightSource {
        id: lightSource
        z: 10
        lightIntensity: Settings.lightIntensity
        // Animate pos in cave mode
        SequentialAnimation on lightTranslateX {
            running: Settings.caveMode
            loops:Animation.Infinite
            NumberAnimation { to:8; duration: 200; easing.type: Easing.InOutQuad }
            NumberAnimation { to:-8; duration: 350; easing.type: Easing.OutBack }
        }
        SequentialAnimation on lightTranslateY {
            running: Settings.caveMode
            loops:Animation.Infinite
            NumberAnimation { to:6; duration: 500; easing.type: Easing.InBack }
            NumberAnimation { to:-6; duration: 1200; easing.type: Easing.OutBounce }
        }
    }

    NMapEffect {
        id: scroll
        anchors.centerIn: parent
        sourceImage: "misc/scroll.png"
        normalsImage: "misc/scrolln.png"
        lightSource: lightSource
        diffuseBoost: Settings.diffuseBoost
        switchX: Settings.switchX
        switchY: Settings.switchY
        width: scroll.originalWidth * Settings.itemScale * 1.2
        height: scroll.originalHeight * Settings.itemScale * 1.2
        z:100

        NMapEffect {
            id: welcomeText
            anchors.verticalCenter: parent.verticalCenter
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.horizontalCenterOffset: -75
            sourceImage: "misc/welcome.png"
            normalsImage: "misc/welcomen.png"
            lightSource: lightSource
            diffuseBoost: Settings.diffuseBoost
            switchX: Settings.switchX
            switchY: Settings.switchY
            width: Settings.screenWidth * 0.47
            height: Settings.screenHeight * 0.50
            z:100
        }

        Text {
            id: startText
            anchors.left: welcomeText.right
            anchors.leftMargin: 5
            anchors.verticalCenter: welcomeText.verticalCenter
            anchors.verticalCenterOffset: -100
            text: "Start"
            font.pointSize: 32
            color: selector==0?"white":"black"
        }

        Text {
            id: optionsText
            anchors.top: startText.bottom
            anchors.topMargin: 50
            anchors.horizontalCenter: startText.horizontalCenter
            text: "Options"
            font.pointSize: 32
            color: selector==1?"white":"black"
        }

        Text {
            id: quitText
            anchors.top: optionsText.bottom
            anchors.topMargin: 50
            anchors.horizontalCenter: startText.horizontalCenter
            text: "Quit"
            font.pointSize: 32
            color: selector==2?"white":"black"
        }


        Glow{
            anchors.fill: {
                switch(selector){
                case 0: startText; break;
                case 1: optionsText; break;
                case 2: quitText; break;
                }
            }
            radius: 16
            samples: 32
            color: "white"
            source: {
                switch(selector){
                case 0: startText; break;
                case 1: optionsText; break;
                case 2: quitText; break;
                }
            }
        }
    }

    NMapEffect {
        id: background
        anchors.centerIn: parent
        sourceImage: "maps/background.png"
        normalsImage: "maps/backgroundn.png"
        lightSource: lightSource
        diffuseBoost: Settings.diffuseBoost
        switchX: Settings.switchX
        switchY: Settings.switchY
        width: background.originalWidth * Settings.itemScale * 1.2
        height: background.originalHeight * Settings.itemScale * 1.2
    }

    MouseArea {
        anchors.fill: parent
        hoverEnabled: true
        function updatePos(mouseX, mouseY) {
            lightSource.setLightPos(mouseX, mouseY);
        }

        onPressed: updatePos(mouseX, mouseY);
        onPositionChanged: updatePos(mouseX, mouseY);
    }
}

//Item {
//    id: root
//    width: Settings.screenWidth
//    height: Settings.screenHeight
//    opacity: 0

//    property int selector: 0

//    Behavior on opacity {
//        PropertyAnimation {
//            duration: 1000
//        }
//    }

//    PropertyAnimation{
//        target:{
//            switch(selector){
//            case 0: startText; break;
//            case 1: optionsText; break;
//            case 2: quitText; break;
//            }
//        }
//        easing.type: Easing.OutSine
//        loops: Animation.Infinite
//        from: 32
//        to: 42
//        duration: 5000
//        property: "font.pointSize"
//    }

//    Image {
//        id: welcomeScroll
//        z: 100
//        width: Settings.screenWidth * 0.75
//        height: Settings.screenHeight * 0.95
//        anchors.centerIn: parent
//        source: "misc/scroll.png"
//        fillMode: Image.Stretch
//        smooth:true
//        antialiasing: true

//        Image {
//            id: welcomeText
//            width: Settings.screenWidth * 0.47
//            height: Settings.screenHeight * 0.50
//            anchors.verticalCenter: parent.verticalCenter
//            anchors.horizontalCenter: parent.horizontalCenter
//            anchors.horizontalCenterOffset: -75
//            source: "misc/welcome.png"
//        }

//        Text {
//            id: startText
//            anchors.left: welcomeText.right
//            anchors.leftMargin: 100
//            anchors.verticalCenter: welcomeText.verticalCenter
//            anchors.verticalCenterOffset: -150
//            text: "Start"
//            font.pointSize: 32
//            color: selector==0?"white":"black"
//        }

//        Text {
//            id: optionsText
//            anchors.top: startText.bottom
//            anchors.topMargin: 50
//            anchors.horizontalCenter: startText.horizontalCenter
//            text: "Options"
//            font.pointSize: 32
//            color: selector==1?"white":"black"
//        }

//        Text {
//            id: quitText
//            anchors.top: optionsText.bottom
//            anchors.topMargin: 50
//            anchors.horizontalCenter: startText.horizontalCenter
//            text: "Quit"
//            font.pointSize: 32
//            color: selector==2?"white":"black"
//        }


//        Glow{
//            anchors.fill: {
//                switch(selector){
//                case 0: startText; break;
//                case 1: optionsText; break;
//                case 2: quitText; break;
//                }
//            }
//            radius: 16
//            samples: 32
//            color: "white"
//            source: {
//                switch(selector){
//                case 0: startText; break;
//                case 1: optionsText; break;
//                case 2: quitText; break;
//                }
//            }
//        }
//    }

//    Component{
//        id:enemyComp

//        Enemy{
//            id:enemy
//            width:130
//            height:180
//        }
//    }

//    Timer{
//        id:huntTimer
//        interval:getRandom(4000,6000)
//        repeat:true
//        running:true
//        onTriggered:spawnEnemy()
//    }

//    Item{
//        Component.onCompleted:{
//            root.opacity=1
//            spawnEnemy()
//        }
//    }

//    Rectangle{
//        z:-10
//        anchors.fill:parent
//        color:"black"
//    }



//    function getRandom(minimum,maximum){
//        var now=new Date()
//        return Math.floor(Math.random(now.getSeconds())*(maximum-minimum+1))+minimum;
//    }

//    function spawnEnemy(){
//        var finalX=getRandom(0,root.width)
//        var enemy=enemyComp.createObject(root,{"x":finalX,"y":-180,"playerTargetX":finalX,"playerTargetY":root.height,"enemySpeed":getRandom(50,200)})

//    }
//}
