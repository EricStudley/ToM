import QtQuick 2.0

Rectangle {
    width: 50
    height: 50
    color: "black"
    Text {
        anchors.centerIn: parent
        text: qsTr("QUIT")
        color: "white"
    }
    MouseArea {
        anchors.fill: parent
        onClicked: {
            Qt.quit();
        }
    }
}
