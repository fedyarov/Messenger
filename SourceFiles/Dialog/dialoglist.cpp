#include "dialoglist.h"

DialogList::DialogList(QObject *parent) : QObject(parent)
{
    MessageItem tempMessage1("Привет","0:46", true);
    MessageItem tempMessage2("Здарова","0:46", false);
    MessageItem tempMessage3("У меня к вам деловое предложение","0:48", true);
    MessageItem tempMessage4("У нас было два пакетика травы, семьдесят пять ампул мескалина, "
                             "5 пакетиков диэтиламида лизергиновой кислоты или ЛСД, солонка, "
                             "наполовину наполненная кокаином, и целое море разноцветных амфетаминов, "
                             "барбитуратов и транквилизаторов, а так же литр текилы, литр рома, ящик "
                             "«Бадвайзера», пинта чистого эфира, и 12 пузырьков амилнитрита. Не то, "
                             "чтобы всё это было категорически необходимо в поездке, но если уж "
                             "начал собирать коллекцию, то к делу надо подходить серьёзно."
                             ,"0:48", true);

    QList<MessageItem> tempList1, tempList2, tempList3;
    tempList1 << tempMessage1;
    tempList2 << tempMessage1 << tempMessage2;
    tempList3 << tempMessage1 << tempMessage2 << tempMessage3 << tempMessage4;

    QVariant variant1 = QVariant::fromValue<QList<MessageItem>>(tempList1);
    QVariant variant2 = QVariant::fromValue<QList<MessageItem>>(tempList2);
    QVariant variant3 = QVariant::fromValue<QList<MessageItem>>(tempList3);

    mItems.append({"kfedyarova", variant1, false});
    mItems.append({ "vbelorysska", variant2, false});
    mItems.append({ "mderbedenev", variant3, false});
}

QList<DialogItem> DialogList::items() const
{
    return mItems;
}

QList<MessageItem> DialogList::messageItems(int index) const
{
    return mItems.at(index).messageList.value<QList<MessageItem>>();
}

bool DialogList::setItemAt(int index, const DialogItem &item)
{
    if (index < 0 || index >= mItems.size())
        return false;

    const DialogItem &oldItem = mItems.at(index);
    if (item.username == oldItem.username && item.messageList == oldItem.messageList )
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

void DialogList::appendItem(QString name, QVariant msgList, bool newMsgFlag) // TODO: newMessageFlag set
{
    emit preItemAppended();

    DialogItem item(name, msgList, newMsgFlag);
    mItems.append(item);

    emit postItemAppended();
}
