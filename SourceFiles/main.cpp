#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QQmlContext>
#include "appengine.h"
#include "Dialog/dialogmodel.h"

int main(int argc, char *argv[])
{
    QCoreApplication::setAttribute(Qt::AA_EnableHighDpiScaling);

    QGuiApplication app(argc, argv);

    QQmlApplicationEngine engine;
    const QUrl url(QStringLiteral("qrc:/SourceFiles/ui/main.qml"));
    QObject::connect(&engine, &QQmlApplicationEngine::objectCreated,
                     &app, [url](QObject *obj, const QUrl &objUrl) {
        if (!obj && url == objUrl)
            QCoreApplication::exit(-1);
    }, Qt::QueuedConnection);

    AppEngine appEngine;
    engine.rootContext()->setContextProperty("app", &appEngine);

    qmlRegisterType<DialogModel>("Dialog", 1, 0, "DialogModel");

    engine.load(url);

    return app.exec();
}
