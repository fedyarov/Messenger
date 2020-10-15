#ifndef CONTACTLIST_H
#define CONTACTLIST_H

#include <QObject>
#include <QVector>

struct ContactItem
{
    QString username;
    QString message;
};

class ContactList : public QObject
{
    Q_OBJECT
public:
    explicit ContactList(QObject *parent = nullptr);

    QVector<ContactItem> items() const;

    bool setItemAt(int index, const ContactItem &item);

signals:
    void preItemAppended();
    void postItemAppended();

    void preItemRemoved(int index);
    void postItemRemoved();

public slots:
    void appendItem(QString name, QString msg);

private:
    QVector<ContactItem> mItems;

};

#endif // CONTACTLIST_H
