import QtQuick 2.0

Item{
    property int maxSize

    Image{
        width:maxSize
        source:"/Users/Eric/Documents/game/qml/game/maps/dungeon.png"
        fillMode: Image.PreserveAspectFit
        anchors.centerIn: parent
        z:10
    }
    Rectangle{
        anchors.fill: parent
        color:"black"
        z:-10
    }
}