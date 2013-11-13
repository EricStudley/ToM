import QtQuick 2.0
import "Settings.js" as Settings
import "Logic.js" as Logic

Item{
    focus: true
    Welcome{
        id:welcome
        visible: true
        width: Settings.screenWidth
        height: Settings.screenHeight
    }

    Loader{
        id:windowLoader
        source:""
    }

    Rectangle{
        z:-10
        anchors.fill:parent
        color:"black"
    }

    Quit{
        z:10
        anchors.top:parent.top
        anchors.right:parent.right
    }

    Keys.onUpPressed:{
        if(welcome.selector>0)
            welcome.selector-=1
    }

    Keys.onDownPressed:{
        if(welcome.selector<2)
            welcome.selector+=1
    }

    Keys.onReturnPressed: {
        switch(welcome.selector){
        case 0: windowLoader.source="Level.qml"; break;
        case 1: windowLoader.source="Level.qml"; break;
        case 2: Qt.quit();
        }
        windowLoader.focus=true
    }
}
