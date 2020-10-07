#include "appengine.h"

AppEngine::AppEngine(QObject *parent) : QObject(parent)
{
    username = "mfedyarov";
}

QString AppEngine::get_username() const
{
    return username;
}

void AppEngine::set_username(const QString &name)
{
    this->username = name;
}

void AppEngine::login(QString name, QString pass)
{
    if (name == username) {
        qDebug() << "Successfully login";
        emit loginResult();
    }
    else {
        qDebug() << "Access denied";
    }
}
