import QtQuick 2.0
import "Settings.js" as Settings

Item{
    property string mapSource:"maps/dungeon.png"
    property int mapTopLeftX:room.x
    property int mapTopLeftY:room.y
    property int mapTopRightX:room.x+room.width
    property int mapTopRightY:room.y
    property int mapBottomLeftX:room.x
    property int mapBottomLeftY:room.y+room.height
    property int mapBottomRightX:room.x+room.width
    property int mapBottomRightY:room.y+room.height
    property int mapMiddleX:room.x+(room.width/2)
    property int mapMiddleY:room.y+(room.height/2)

    Image{
        id:room
        z:10
        anchors.centerIn: parent
        source:mapSource
        fillMode: Image.PreserveAspectFit
    }

    Rectangle{
        z:-10
        anchors.fill: parent
        color:"black"
    }
}
