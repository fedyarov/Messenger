#include "contactlist.h"

ContactList::ContactList(QObject *parent) : QObject(parent)
{
    mItems.append({ "kfedyarova", "Привет)", false});
    mItems.append({ "vbelorysska", "Здравствуйте! У меня к вам очень серьезный разговор.", true});
    mItems.append({ "mderbedenev", "Хорошо. Я вас понял", false});
    mItems.append({ "user1", "Тестовое сообщение", false});
    mItems.append({ "user2", "Тестовое сообщение", false});
    mItems.append({ "user3", "Тестовое сообщение", false});
    mItems.append({ "user4", "Тестовое сообщение", false});
    mItems.append({ "user5", "Тестовое сообщение", false});
}

QList<ContactItem> ContactList::items() const
{
    return mItems;
}

bool ContactList::setItemAt(int index, const ContactItem &item)
{
    if (index < 0 || index >= mItems.size())
        return false;

    const ContactItem &oldItem = mItems.at(index);
    if (item.username == oldItem.username && item.message == oldItem.message )
        return false;

    mItems[index] = item;

    return true;
}

bool ContactList::moveRowToFirst(int indexSource)
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

bool ContactList::setNewMessageFlag(int index, bool flag)
{
    if (index < 0 || index >= mItems.size())
        return false;

    emit preResetModel();

    mItems[index].newMessageFlag = flag;

    emit postResetModel();
    return true;
}

void ContactList::appendItem(QString name, QString msg) // TODO: newMessageFlag set
{
    emit preItemAppended();

    ContactItem item;
    item.username = name;
    item.message = msg;
    mItems.append(item);

    emit postItemAppended();
}
