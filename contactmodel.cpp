#include "contactmodel.h"

ContactModel::ContactModel(QObject *parent)
    : QAbstractListModel(parent)
    , mList(nullptr)
{
}

int ContactModel::rowCount(const QModelIndex &parent) const
{
    // For list models only the root node (an invalid parent) should return the list's size. For all
    // other (valid) parents, rowCount() should return 0 so that it does not become a tree model.
    if (parent.isValid() || !mList)
        return 0;

    return mList->items().size();
}

QVariant ContactModel::data(const QModelIndex &index, int role) const
{
    if (!index.isValid() || !mList)
        return QVariant();

    const ContactItem item = mList->items().at(index.row());
    switch (role) {
    case DoneRole:
        return QVariant(item.username);
    case DescriptionRole:
        return QVariant(item.message);
    case NotifyNewMessageRole:
        return QVariant(item.newMessageFlag);
    }

    return QVariant();
}

bool ContactModel::setData(const QModelIndex &index, const QVariant &value, int role)
{
    if (!mList)
        return false;

    ContactItem item = mList->items().at(index.row());
    switch (role) {
    case DoneRole:
        item.username = value.toString();
        break;
    case DescriptionRole:
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

Qt::ItemFlags ContactModel::flags(const QModelIndex &index) const
{
    if (!index.isValid())
        return Qt::NoItemFlags;

    return Qt::ItemIsEditable;
}

QHash<int, QByteArray> ContactModel::roleNames() const
{
    QHash<int, QByteArray> names;
    names[DoneRole] = "username";
    names[DescriptionRole] = "message";
    names[NotifyNewMessageRole] = "newMessageFlag";
    return names;
}

ContactList* ContactModel::list() const
{
    qDebug() << "list()";
    return mList;
}

void ContactModel::setList(ContactList *list)
{
    beginResetModel();

    if (mList)
        mList->disconnect(this);

    mList = list;

    if (mList) {
        connect(mList, &ContactList::preItemAppended, this, [=](){
            const int index = mList->items().size();
            beginInsertRows(QModelIndex(), index, index);
        });
        connect(mList, &ContactList::preItemAppended, this, [=](){
            endInsertRows();
        });
        connect(mList, &ContactList::preItemRemoved, this, [=](int index){
            beginRemoveRows(QModelIndex(), index, index);
        });
        connect(mList, &ContactList::postItemRemoved, this, [=](){
            endInsertRows();
        });
        connect(mList, &ContactList::preItemMoveRows, this, [=](int indexSourceFirst, int indexSourceLast, int indexDestRow){
            beginMoveRows(QModelIndex(), indexSourceFirst, indexSourceLast, QModelIndex(), indexDestRow);
        });
        connect(mList, &ContactList::postItemMoveRows, this, [=](){
            endMoveRows();
        });
        connect(mList, &ContactList::preResetModel, this, [=](){
            beginResetModel();
        });
        connect(mList, &ContactList::postResetModel, this, [=](){
            endResetModel();
        });
    }

    endResetModel();
}
