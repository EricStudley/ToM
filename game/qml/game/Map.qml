import QtQuick 2.0

Item{
    property int maxSize

    Image{
        z:10
        width:maxSize
        anchors.centerIn: parent
        source:"maps/dungeon.png"
        fillMode: Image.PreserveAspectFit
    }

    Rectangle{
        z:-10
        anchors.fill: parent
        color:"black"
    }
}
