#ifndef SERVER_H
#define SERVER_H

#include <QObject>
#include <QDebug>

#include <QSqlDatabase>
#include <QSqlQuery>
#include <QSqlTableModel>
#include <QSqlError>
#include <QSqlRecord>

#include <QCryptographicHash>

class Server : public QObject
{
    Q_OBJECT

private:
    QSqlDatabase database;
    QString      db_name;

public:
    explicit Server(QObject *parent = nullptr);

    int      tryLogin(QString name, QString pass);
    int      tryRegistration(QString name, QString pass, QString checkPass);



signals:

};

#endif // SERVER_H
