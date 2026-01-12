#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include "Backend.h"
#include <QQmlContext>

int main(int argc, char *argv[])
{
    QGuiApplication app(argc, argv);

    QQmlApplicationEngine engine;
    MyBackend backendInstance;

    engine.rootContext()->setContextProperty("MyBackend", &backendInstance);

    const QUrl url("qrc:/qt/qml/SemesterProject/Main.qml");
    QObject::connect(&engine, &QQmlApplicationEngine::objectCreated,
                     &app, [url](QObject *obj, const QUrl &objUrl) {
                         if (!obj && url == objUrl)
                             QCoreApplication::exit(-1);
                     }, Qt::QueuedConnection);
    engine.load(url);

    return app.exec();
}
