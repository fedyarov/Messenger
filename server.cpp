#include "server.h"

Server::Server(QObject *parent) : QObject(parent)
{
    db_name = "account_data";
    database = QSqlDatabase::addDatabase("QSQLITE");
    database.setHostName("127.0.0.1");
    database.setDatabaseName("account_data.sqlite3");

    if (!database.open()) {
        qDebug() << "Server: Cannot open database:" << database.lastError();
    }
    else {
        qDebug() << "Server: Success open database";
    }
}

int Server::tryLogin(QString name, QString pass)
{
    QSqlQuery query = QSqlQuery(database);
    QSqlRecord rec;
    QString str = "SELECT hash FROM " + db_name + " WHERE username = \'" + name + "\'";

    if (!query.exec(str)) {
        qDebug() << "Server: Unable to make select operation: " << query.lastError();
        return 0;
    }

    rec = query.record();
    if (query.next() && pass == query.value(rec.indexOf("hash")).toString()) {

        return 1;
    }
    else {
        qDebug() << "Server: Incorrect password: " << pass;
        return 2;
    }
}
