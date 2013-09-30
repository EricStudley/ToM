import QtQuick 2.0

Item{
    id:root
    height:1200
    width:1920
    opacity:0

    property int windowShort:root.width>root.height?root.width:root.height
    property int windowLong:root.width>root.height?root.height:root.width

    Behavior on opacity{ PropertyAnimation{ duration: 1000}}

    Image{
        id:welcomeScroll
        anchors.centerIn: parent
        width:1432.5
        height:1152
        z:100
        source:"misc/scroll.png"
        fillMode: Image.Stretch
        Image{
            id:welcomeText
            anchors.centerIn: parent
            width:900
            height:600
            source:"misc/welcome.png"
        }
        Text{
            anchors.top: welcomeText.bottom
            anchors.horizontalCenter: welcomeText.horizontalCenter
            text:"Press Enter"
            color:"white"
        }
    }

    Component{
        id:enemyComp
        Enemy{
            id: enemy
            height:180
            width:130
        }
    }

    Timer{
        id: huntTimer
        interval: getRandom(4000,6000)
        repeat: true
        running: true
        onTriggered: spawnEnemy()
    }

    Item{
        Component.onCompleted: {
            root.opacity=1
            spawnEnemy()
        }
    }

    Rectangle{
        anchors.fill:parent
        color:"black"
        z:-10
    }

    function getRandom(minimum, maximum){
        var now = new Date()
        return Math.floor(Math.random(now.getSeconds()) * (maximum - minimum + 1)) + minimum;
    }

    function spawnEnemy(){
        var finalX=getRandom(0,root.width)
        var enemy=enemyComp.createObject(root,{"x":finalX,"y":-180,"playerTargetX":finalX,"playerTargetY":root.height,"enemySpeed":getRandom(50,200)})

    }
}
