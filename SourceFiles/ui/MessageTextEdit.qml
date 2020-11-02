import QtQuick 2.0

Item {
    id: rectangle
    property int  property_maxHeight
    property bool property_visible

    height: msg_TextEdit.height + 40 > property_maxHeight ?
                property_maxHeight : msg_TextEdit.height + 40

    Rectangle {
        id: msg_Rectangle
        anchors.fill: parent
        clip: true
        color: property_visible ? "#ffffff" : "#dedede"

        TextEdit {
            id: msg_TextEdit
            anchors.verticalCenter: parent.verticalCenter
            anchors.left: parent.left
            anchors.right: send_button.left
            anchors.leftMargin: 70
            anchors.rightMargin: 20

            wrapMode: TextEdit.Wrap
            selectByMouse: true
            visible: property_visible

            font.pointSize: 10
        }
        IconButton{
            id: send_button
            anchors.bottom: parent.bottom
            anchors.right: parent.right
            anchors.bottomMargin: 10
            anchors.rightMargin: 10
            width: 40
            height: 40
            icon.source: "qrc:/images/res/send.png"
            icon.color: "#00c4ff"

            onButtClicked: {

            }
        }
    }

    Text {
        anchors.verticalCenter: msg_Rectangle.verticalCenter
        anchors.left: msg_Rectangle.left
        anchors.leftMargin: 70

        opacity: 0.5
        visible: msg_TextEdit.text == "" && property_visible ? true : false

        font.pointSize: 10
        text: "Ваше сообщение"
    }
}
