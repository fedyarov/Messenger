import QtQuick 2.0
import QtQuick.Controls 2.2

Item {
    signal menu_button_clicked()
    IconButton {
        id: menu_button
        anchors.verticalCenter: parent.verticalCenter
        anchors.left: parent.left
        anchors.leftMargin: 10
        width: 40
        height: 40
        icon.source: "qrc:/images/res/menu.png"
        opacity: 0.5

        onButtClicked: {
            parent.menu_button_clicked()
        }
    }

    EnterText{
        id: search
        anchors.top: parent.top
        anchors.bottom: parent.bottom
        anchors.left: menu_button.right
        anchors.right: parent.right
        anchors.topMargin: 10
        anchors.bottomMargin: 10
        anchors.leftMargin: 10
        anchors.rightMargin: 10

        property_defaultText: "Поиск"
    }
}
