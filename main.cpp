#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QQmlContext>
#include "appengine.h"
#include "contactlist.h"
#include "contactmodel.h"

int main(int argc, char *argv[])
{
    QCoreApplication::setAttribute(Qt::AA_EnableHighDpiScaling);

    QGuiApplication app(argc, argv);

    QQmlApplicationEngine engine;
    const QUrl url(QStringLiteral("qrc:/main.qml"));
    QObject::connect(&engine, &QQmlApplicationEngine::objectCreated,
                     &app, [url](QObject *obj, const QUrl &objUrl) {
        if (!obj && url == objUrl)
            QCoreApplication::exit(-1);
    }, Qt::QueuedConnection);

    AppEngine appEngine;
    engine.rootContext()->setContextProperty("app", &appEngine);

    qmlRegisterType<ContactModel>("Contact", 1, 0, "ContactModel");

    engine.load(url);

    return app.exec();
}
