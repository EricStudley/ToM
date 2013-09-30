#include <QtGui/QGuiApplication>
#include "qtquick2applicationviewer.h"
#include <QQmlContext>
#include <QDir>

int main(int argc, char *argv[])
{
    QGuiApplication app(argc, argv);

    QtQuick2ApplicationViewer viewer;
    const QString appCurrentDir=QDir::current().absolutePath();
    viewer.addImportPath("file:///"+appCurrentDir+"/qml/game");
    viewer.setMainQmlFile(QStringLiteral("qml/game/main.qml"));
    viewer.showFullScreen();
    return app.exec();
}
