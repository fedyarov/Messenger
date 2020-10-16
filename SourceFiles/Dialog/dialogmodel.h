#ifndef DIALOGMODEL_H
#define DIALOGMODEL_H

#include <QAbstractListModel>
#include <QDebug>

#include "dialoglist.h"

class DialogList;

class DialogModel : public QAbstractListModel
{
    Q_OBJECT
    Q_PROPERTY(DialogList* list READ list WRITE setList)
public:
    explicit DialogModel(QObject *parent = nullptr);

    enum {
        UsernameRole = Qt::UserRole,
        MessageRole,
        NotifyNewMessageRole,
    };

    // Basic functionality:
    int rowCount(const QModelIndex &parent = QModelIndex()) const override;

    QVariant data(const QModelIndex &index, int role = Qt::DisplayRole) const override;

    // Editable:
    bool setData(const QModelIndex &index, const QVariant &value,
                 int role = Qt::EditRole) override;

    Qt::ItemFlags flags(const QModelIndex& index) const override;

    virtual QHash<int, QByteArray> roleNames() const override;

    DialogList* list() const;
    void setList(DialogList *list);

private:
    DialogList *mList;
};

#endif // DIALOGMODEL_H
