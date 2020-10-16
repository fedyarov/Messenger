#ifndef APPENGINE_H
#define APPENGINE_H

#include <QObject>
#include <QDebug>

#include <QList>

#include "server.h"
#include "contactlist.h"

class AppEngine : public QObject
{
    Q_OBJECT

    Q_PROPERTY(QString username READ username WRITE setUsername NOTIFY usernameChanged)

private:
    Server      *server;
    ContactList *contactList;
    QString      m_username;

public:
    explicit AppEngine(QObject *parent = nullptr);

    QString  username() const;
    void     setUsername(const QString &a);

    Q_INVOKABLE void         login(QString name, QString pass);
    Q_INVOKABLE void         registration(QString name, QString pass, QString checkPass);
    Q_INVOKABLE ContactList* getContactList();
    Q_INVOKABLE void         setItemToFirst();
    Q_INVOKABLE void         openDialog(int index);

public slots:

signals:
    void loginResult();
    void loginConnectionError();
    void loginPasswordError();

    void regResult();
    void regConnectionError();
    void regPasswordError();
    void regUsernameError();
    void regUsernameIsTaken();

    void usernameChanged(QString name);
};

#endif // APPENGINE_H
