#ifndef DIALOGLIST_H
#define DIALOGLIST_H

#include <QObject>
#include <QList>
#include <QDebug>

class MessageItem{
public:
    QString message;
    QString date;
    bool    fromClient;

public:
    MessageItem() {};
    MessageItem(QString msg, QString msgDate, bool flagFromClient)
        : message(msg), date(msgDate), fromClient(flagFromClient) {}

};

class DialogItem
{
public:
    QString  username;
    QVariant messageList;
    bool     newMessageFlag;

public:
    DialogItem() {};
    DialogItem(QString name, QVariant msgList, bool newMsgFlag)
        : username(name), messageList(msgList), newMessageFlag(newMsgFlag) {}
};

class DialogList : public QObject
{
    Q_OBJECT
public:
    explicit DialogList(QObject *parent = nullptr);

    QList<DialogItem>  items() const;
    QList<MessageItem> messageItems(int index) const;

    bool setItemAt(int index, const DialogItem &item);
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
    void appendItem(QString name, QVariant msgList, bool newMsgFlag);

private:
    QList<DialogItem> mItems;

};

Q_DECLARE_METATYPE(DialogItem)
Q_DECLARE_METATYPE(MessageItem)

#endif // DIALOGLIST_H
