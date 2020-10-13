#ifndef APPENGINE_H
#define APPENGINE_H

#include <QObject>
#include <QDebug>
#include "server.h"

class AppEngine : public QObject
{
    Q_OBJECT
    Q_PROPERTY(QString username READ get_username WRITE set_username NOTIFY username_changed)
private:
    Server  *server;
    QString m_username;

public:
    explicit AppEngine(QObject *parent = nullptr);

    QString  get_username() const;
    void     set_username(const QString &a);

    Q_INVOKABLE void login(QString name, QString pass);
public slots:


signals:
    void loginResult();
    void loginConnectionError();
    void loginPasswordError();

    void username_changed();
};

#endif // APPENGINE_H
