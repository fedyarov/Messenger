import QtQuick 2.0
import QtQuick.Controls 2.2

Item {
    IconButton {
        id: menu_button
        anchors.verticalCenter: parent.verticalCenter
        anchors.left: parent.left
        anchors.leftMargin: 10
        width: 40
        height: 40
        icon.source: "qrc:/images/res/menu.png"
        opacity: 0.5
    }

    Rectangle {
        id: search_Rectangle
        anchors.top: parent.top
        anchors.bottom: parent.bottom
        anchors.left: menu_button.right
        anchors.right: parent.right
        anchors.topMargin: 10
        anchors.bottomMargin: 10
        anchors.leftMargin: 10
        anchors.rightMargin: 10
        border.width: search_TextInput.focus ? 2 : 0
        border.color: "#00c4ff"
        color: search_TextInput.focus ? "#ffffff" : "#000000"
        opacity: search_TextInput.focus ? 1 : 0.05
        radius: 3
        smooth: true
        clip: true

        TextInput {
           id: search_TextInput
           anchors.verticalCenter: parent.verticalCenter
           anchors.left: parent.left
           anchors.right: parent.right
           anchors.leftMargin: 20
           anchors.rightMargin: 20

           font.pointSize: 10
        }
    }
    Text {
        anchors.verticalCenter: search_Rectangle.verticalCenter
        anchors.left: search_Rectangle.left
        anchors.right: search_Rectangle.right
        anchors.leftMargin: 20
        anchors.rightMargin: 20

        font.pointSize: 10
        opacity: 0.5
        visible: search_TextInput.focus ? (search_TextInput.text == "" ? true : false) : true
        text: "Поиск"
    }
}
