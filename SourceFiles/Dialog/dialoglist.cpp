#include "dialoglist.h"

DialogList::DialogList(QObject *parent) : QObject(parent)
{
    QVector<QString> tempVector, tempVector2, tempVector3;

    tempVector << "Привет" << "Здравствуйте" << "У меня для вас деловое предложение";
    tempVector2 << "Я не буду с вами разговаривать";
    tempVector3 << "Хорошо, буду ждать" << "Ну и жди";

    mItems.append({ "kfedyarova", tempVector[2], false});
    mItems.append({ "vbelorysska", tempVector2[0], true});
    mItems.append({ "mderbedenev", tempVector3[0], false});
    mItems.append({ "user1", tempVector[2], false});
    mItems.append({ "user2", tempVector2[0], false});
    mItems.append({ "user3", tempVector3[0], false});
    mItems.append({ "user4", tempVector[2], false});
    mItems.append({ "user5", tempVector2[0], false});
}

QList<DialogItem> DialogList::items() const
{
    return mItems;
}

bool DialogList::setItemAt(int index, const DialogItem &item)
{
    if (index < 0 || index >= mItems.size())
        return false;

    const DialogItem &oldItem = mItems.at(index);
    if (item.username == oldItem.username && item.message == oldItem.message )
        return false;

    mItems[index] = item;

    return true;
}

bool DialogList::moveRowToFirst(int indexSource)
{
    if (indexSource < 0 || indexSource >= mItems.size())
        return false;

    emit preItemMoveRows(indexSource, indexSource, 0);

    mItems.push_front(mItems.at(indexSource));
    mItems.removeAt(indexSource+1);

    emit postItemMoveRows();

    setNewMessageFlag(0, true);
    return true;
}

bool DialogList::setNewMessageFlag(int index, bool flag)
{
    if (index < 0 || index >= mItems.size())
        return false;

    emit preResetModel();

    mItems[index].newMessageFlag = flag;

    emit postResetModel();
    return true;
}

void DialogList::appendItem(QString name, QString msg) // TODO: newMessageFlag set
{
    emit preItemAppended();

    DialogItem item;
    mItems.append(item);

    emit postItemAppended();
}
