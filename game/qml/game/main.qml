import QtQuick 2.0

Item{

    Loader{
        id:windowLoader
        source:"Welcome.qml"
        focus:true
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

    Keys.onReturnPressed:windowLoader.source="Level.qml"
}
