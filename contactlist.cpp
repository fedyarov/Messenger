#include "contactlist.h"

ContactList::ContactList(QObject *parent) : QObject(parent)
{
    mItems.append({ "kfedyarova", "Привет)"});
    mItems.append({ "vbelorysska", "Здравствуйте! У меня к вам очень серьезный разговор."});
    mItems.append({ "mderbedenev", "Хорошо. Я вас понял"});
}

QVector<ContactItem> ContactList::items() const
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

void ContactList::appendItem(QString name, QString msg)
{
    emit preItemAppended();

    ContactItem item;
    item.username = name;
    item.message = msg;
    mItems.append(item);

    emit postItemAppended();
}
