#include "messagemodel.h"

MessageModel::MessageModel(QObject *parent)
    : QAbstractListModel(parent)
{
}

int MessageModel::rowCount(const QModelIndex &parent) const
{
    // For list models only the root node (an invalid parent) should return the list's size. For all
    // other (valid) parents, rowCount() should return 0 so that it does not become a tree model.
    if (parent.isValid())
        return 0;

    return mList.size();
}

QVariant MessageModel::data(const QModelIndex &index, int role) const
{
    if (!index.isValid())
        return QVariant();

    MessageItem item = mList.at(index.row());
    switch (role){
    case MessageRole:
        return QVariant(item.message);
        break;
    case DateRole:
        return QVariant(item.date);
        break;
    case FromClientRole:
        return QVariant(item.fromClient);
        break;
    }

    return QVariant();
}

bool MessageModel::setData(const QModelIndex &index, const QVariant &value, int role)
{
    qDebug() << "MessageModel::setData";
    switch (role){
    case MessageRole:
        qDebug() << "MessageModel::setData -> MessageRole";
        break;
    case DateRole:
        break;
    case FromClientRole:
        break;
    }

    if (data(index, role) != value) {
        // FIXME: Implement me!
        emit dataChanged(index, index, QVector<int>() << role);
        return true;
    }
    return false;
}

Qt::ItemFlags MessageModel::flags(const QModelIndex &index) const
{
    if (!index.isValid())
        return Qt::NoItemFlags;

    return Qt::ItemIsEditable; // FIXME: Implement me!
}

QHash<int, QByteArray> MessageModel::roleNames() const
{
    QHash<int, QByteArray> names;

    names[MessageRole] = "message";
    names[DateRole] = "date";
    names[FromClientRole] = "fromClient";

    return names;
}

QList<MessageItem> MessageModel::list() const
{
    return mList;
}

void MessageModel::setList(QList<MessageItem> list)
{
    qDebug() << "MessageModel::setList";
    beginResetModel();

    mList = list;

    endResetModel();
}
