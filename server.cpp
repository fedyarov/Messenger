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

    QString passWithSault = pass + name[0];
    QCryptographicHash CalculateSha512(QCryptographicHash::Sha512);
    CalculateSha512.addData(passWithSault.toUtf8());
    QString hash(CalculateSha512.result().toHex());

    rec = query.record();
    if (query.next() && hash == query.value(rec.indexOf("hash")).toString()) {
        return 1;
    }
    else {
        qDebug() << "Server: Incorrect password: " << pass;
        return 2;
    }
}

int Server::tryRegistration(QString name, QString pass, QString checkPass)
{
    QSqlQuery query = QSqlQuery(database);
    QSqlRecord rec;

    if (name == "") {
        qDebug() << "Server: Incorrect username";
        return 3;
    }

    if (!query.exec("SELECT username FROM " + db_name + " WHERE username=\'" + name + "\'")){
        qDebug() << "Server: Unable to make SELECT operation: " << query.lastError();
        return 0;
    }

    if (query.next()) {
        qDebug() << "Server: Username is already taken";
        return 4;
    }

    if (pass != checkPass || pass == "") {
        qDebug() << "Server: Incorrect password";
        return 2;
    }

    QString passWithSault = pass + name[0];
    QCryptographicHash CalculateSha512(QCryptographicHash::Sha512);
    CalculateSha512.addData(passWithSault.toUtf8());
    QString hash(CalculateSha512.result().toHex());

    QString str = "INSERT INTO " + db_name + " (username, hash) "
                  "VALUES (\'" + name + "\', \'" + hash + "\' );";

    if (!query.exec(str)) {
        qDebug() << "Server: Unable to make INSERT operation: " << query.lastError();
        return 0;
    }
    else {
        qDebug() << "Server: Successfully created new account: " << name;
        return 1;
    }
}
