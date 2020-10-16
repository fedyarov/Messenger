#include "appengine.h"

AppEngine::AppEngine(QObject *parent) : QObject(parent)
{
    server = new Server();
    contactList = new ContactList();
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
        setUsername(name);
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

void AppEngine::registration(QString name, QString pass, QString checkPass)
{
    switch (server->tryRegistration(name, pass, checkPass)){
    case 0: {
        emit regConnectionError();
        qDebug() << "App: No connection with the server";
        break;
    }
    case 1:{
        emit regResult();
        break;
    }
    case 2: {
        emit regPasswordError();
        break;
    }
    case 3: {
        emit regUsernameError();
        break;
    }
    case 4: {
        emit regUsernameIsTaken();
        break;
    }
    }
}

ContactList *AppEngine::getContactList()
{
    return contactList;
}

void AppEngine::setItemToFirst()
{
    contactList->moveRowToFirst(5);
}

void AppEngine::openDialog(int index)
{
    contactList->setNewMessageFlag(index, false);
}

QString AppEngine::username() const
{
    return m_username;
}

void AppEngine::setUsername(const QString &a)
{
    if (m_username != a) {
        m_username = a;
        emit usernameChanged(m_username);
    }
}

