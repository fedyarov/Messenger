#ifndef MESSAGEMODEL_H
#define MESSAGEMODEL_H

#include <QAbstractListModel>
#include "dialoglist.h"

class MessageItem;

class MessageModel : public QAbstractListModel
{
    Q_OBJECT
    Q_PROPERTY(QList<MessageItem> list READ list WRITE setList)

public:
    explicit MessageModel(QObject *parent = nullptr);

    enum {
        MessageRole = Qt::UserRole,
        DateRole,
        FromClientRole
    };

    // Basic functionality:
    int rowCount(const QModelIndex &parent = QModelIndex()) const override;

    QVariant data(const QModelIndex &index, int role = Qt::DisplayRole) const override;

    // Editable:
    bool setData(const QModelIndex &index, const QVariant &value,
                 int role = Qt::EditRole) override;

    Qt::ItemFlags flags(const QModelIndex& index) const override;

    virtual QHash<int, QByteArray> roleNames() const override;

    QList<MessageItem> list() const;
    void               setList(QList<MessageItem> list);

private:
    QList<MessageItem> mList;
};

#endif // MESSAGEMODEL_H
