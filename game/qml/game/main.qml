import QtQuick 2.0

Item{
    Loader {
        id: windowLoader
        source: "Welcome.qml"
        focus: true

        property bool valid: item !== null
    }
    Connections {
        ignoreUnknownSignals: true
        target: windowLoader.valid? windowLoader.item : null
        onPageExit: { windowLoader.source = "Welcome.qml" }
    }

    Keys.onReturnPressed: {
        windowLoader.source = "Level.qml"
    }

    Rectangle{
        anchors.fill:parent
        color:"black"
        z:-10
    }

    Quit{
        anchors.top: parent.top
        anchors.right: parent.right
        z:10
    }
}
