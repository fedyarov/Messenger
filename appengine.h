#ifndef APPENGINE_H
#define APPENGINE_H

#include <QObject>
#include <QDebug>

class AppEngine : public QObject
{
    Q_OBJECT
    Q_PROPERTY(QString username READ get_username WRITE set_username NOTIFY get_username)
private:
    QString username;

public:
    explicit AppEngine(QObject *parent = nullptr);

    QString get_username() const;
    void set_username(const QString &name);

    Q_INVOKABLE void login(QString name, QString pass);
public slots:


signals:
    void loginResult();
};

#endif // APPENGINE_H
