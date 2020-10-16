#ifndef CONTACTLIST_H
#define CONTACTLIST_H

#include <QObject>
#include <QList>
#include <QDebug>

struct ContactItem
{
    QString username;
    QString message;
    bool    newMessageFlag;
};

class ContactList : public QObject
{
    Q_OBJECT
public:
    explicit ContactList(QObject *parent = nullptr);

    QList<ContactItem> items() const;

    bool setItemAt(int index, const ContactItem &item);
    bool moveRowToFirst(int indexSource);
    bool setNewMessageFlag(int index, bool flag);

signals:
    void preItemAppended();
    void postItemAppended();

    void preItemRemoved(int index);
    void postItemRemoved();

    void preItemMoveRows(int indexSourceFirst, int indexSourceLast, int indexDestRow);
    void postItemMoveRows();

    void preResetModel();
    void postResetModel();

public slots:
    void appendItem(QString name, QString msg);

private:
    QList<ContactItem> mItems;

};

#endif // CONTACTLIST_H
