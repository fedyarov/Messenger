#include "appengine.h"

AppEngine::AppEngine(QObject *parent) : QObject(parent)
{
    server = new Server();
}

QString AppEngine::get_username() const
{
    return m_username;
}

void AppEngine::set_username(const QString &a)
{
    if (m_username != a) {
        m_username = a;
        emit username_changed();
    }
}

void AppEngine::login(QString name, QString pass)
{
    switch (server->tryLogin(name,pass)){
    case 0: {
        emit loginConnectionError();
        qDebug() << "App: No connection with the server";
        break;
    }
    case 1: {
        set_username(name);
        emit loginResult();
        qDebug() << "App: Successfully login";
        break;
    }
    case 2: {
        emit loginPasswordError();
        break;
    }
    }
}
