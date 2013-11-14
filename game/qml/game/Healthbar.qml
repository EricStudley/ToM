import QtQuick 2.0

Item {
    id: healthbar
    width: 100
    height: 10

    property int lifeLeft

    Rectangle {
        id: red
        anchors.fill: parent
        color: "red"
    }

    Rectangle {
        id: green
        z: 1
        width: lifeLeft
        height: parent.height
        anchors.left: parent.left
        color: "green"
    }
}
