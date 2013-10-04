import QtQuick 2.0

Canvas {
    id: canvas
    antialiasing: true
    renderTarget: Canvas.FramebufferObject

    signal startDraw()
    signal endDraw()
    property alias drawEnabled: maCanvas.enabled
    property bool isDraw: false
    property int lineWidth: 10
    property string lineColor: "green"
    property var mousePoints: []

    function clearDrawArea() {
        drawEnded();
        var ctx = canvas.getContext("2d");
        ctx.clearRect(0, 0, width, height);
        canvas.requestPaint();
    }

    function clearMousePoints() {
        mousePoints.length = 0;
    }

    function drawStarted() {
        canvas.isDraw = true;
        canvas.startDraw();
    }

    function drawEnded() {
        if (canvas.isDraw) {
            clearMousePoints();
            canvas.isDraw = false;
            canvas.endDraw();
        }
    }

    function pushMousePoint(x, y) {
        if (canvas.isDraw) {
            mousePoints.push(Qt.point(x, y));
            canvas.requestPaint();
        }
    }

    onPaint: {
        const pointCount = mousePoints.length;
        if (pointCount == 0)
            return;

        var ctx = canvas.getContext("2d");

        ctx.lineJoin = 'round';
        ctx.lineCap = 'round';
        ctx.strokeStyle = canvas.lineColor;
        ctx.lineWidth = canvas.lineWidth;

        ctx.beginPath();

        var pos = mousePoints[0];
        ctx.moveTo(pos.x, pos.y);

        for (var i = 1; i < pointCount; ++i) {
            pos = mousePoints[i];
            ctx.lineTo(pos.x, pos.y);
        }

        mousePoints[0] = pos;  // store the last mouse point
        mousePoints.length = 1;

        ctx.closePath();
        ctx.stroke();
    }

    MouseArea {
        id: maCanvas
        anchors.fill: parent
        hoverEnabled: true

        onPressed: {
            drawStarted();
            pushMousePoint(mouseX, mouseY);
        }
        onReleased: drawEnded()
        onExited: drawEnded()
        onPositionChanged: pushMousePoint(mouseX, mouseY)
    }
}
