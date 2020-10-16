#include "dialogmodel.h"

DialogModel::DialogModel(QObject *parent)
    : QAbstractListModel(parent)
    , mList(nullptr)
{
}

int DialogModel::rowCount(const QModelIndex &parent) const
{
    // For list models only the root node (an invalid parent) should return the list's size. For all
    // other (valid) parents, rowCount() should return 0 so that it does not become a tree model.
    if (parent.isValid() || !mList)
        return 0;

    return mList->items().size();
}

QVariant DialogModel::data(const QModelIndex &index, int role) const
{
    if (!index.isValid() || !mList)
        return QVariant();

    const DialogItem item = mList->items().at(index.row());
    switch (role) {
    case UsernameRole:
        return QVariant(item.username);
    case MessageRole:
        return QVariant(item.message);
    case NotifyNewMessageRole:
        return QVariant(item.newMessageFlag);
    }

    return QVariant();
}

bool DialogModel::setData(const QModelIndex &index, const QVariant &value, int role)
{
    if (!mList)
        return false;

    DialogItem item = mList->items().at(index.row());
    switch (role) {
    case UsernameRole:
        item.username = value.toString();
        break;
    case MessageRole:
        item.message = value.toString();
        break;
    case NotifyNewMessageRole:
        item.newMessageFlag = value.toBool();
        break;
    }

    if (mList->setItemAt(index.row(), item)) {
        // FIXME: Implement me!
        emit dataChanged(index, index, QVector<int>() << role);
        return true;
    }
    return false;
}

Qt::ItemFlags DialogModel::flags(const QModelIndex &index) const
{
    if (!index.isValid())
        return Qt::NoItemFlags;

    return Qt::ItemIsEditable;
}

QHash<int, QByteArray> DialogModel::roleNames() const
{
    QHash<int, QByteArray> names;
    names[UsernameRole] = "username";
    names[MessageRole] = "message";
    names[NotifyNewMessageRole] = "newMessageFlag";
    return names;
}

DialogList* DialogModel::list() const
{
    qDebug() << "list()";
    return mList;
}

void DialogModel::setList(DialogList *list)
{
    beginResetModel();

    if (mList)
        mList->disconnect(this);

    mList = list;

    if (mList) {
        connect(mList, &DialogList::preItemAppended, this, [=](){
            const int index = mList->items().size();
            beginInsertRows(QModelIndex(), index, index);
        });
        connect(mList, &DialogList::preItemAppended, this, [=](){
            endInsertRows();
        });
        connect(mList, &DialogList::preItemRemoved, this, [=](int index){
            beginRemoveRows(QModelIndex(), index, index);
        });
        connect(mList, &DialogList::postItemRemoved, this, [=](){
            endInsertRows();
        });
        connect(mList, &DialogList::preItemMoveRows, this, [=](int indexSourceFirst, int indexSourceLast, int indexDestRow){
            beginMoveRows(QModelIndex(), indexSourceFirst, indexSourceLast, QModelIndex(), indexDestRow);
        });
        connect(mList, &DialogList::postItemMoveRows, this, [=](){
            endMoveRows();
        });
        connect(mList, &DialogList::preResetModel, this, [=](){
            beginResetModel();
        });
        connect(mList, &DialogList::postResetModel, this, [=](){
            endResetModel();
        });
    }

    endResetModel();
}
