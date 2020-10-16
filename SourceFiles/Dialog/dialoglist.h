#ifndef DIALOGLIST_H
#define DIALOGLIST_H

#include <QObject>
#include <QList>
#include <QDebug>

struct MessageItem{

};

struct DialogItem
{
    QString username;
    QString message;
    bool    newMessageFlag;
};

class DialogList : public QObject
{
    Q_OBJECT
public:
    explicit DialogList(QObject *parent = nullptr);

    QList<DialogItem> items() const;

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
    void appendItem(QString name, QString msg);

private:
    QList<DialogItem> mItems;

};

#endif // DIALOGLIST_H
