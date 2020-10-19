import QtQuick 2.0

Item {
    id: rectangle
    property int property_maxHeight

    height: msg_TextEdit.height + 40 > property_maxHeight ?
                property_maxHeight : msg_TextEdit.height + 40

    Rectangle {
        id: msg_Rectangle
        anchors.fill: parent
        clip: true

        TextEdit {
            id: msg_TextEdit
            anchors.verticalCenter: parent.verticalCenter
            anchors.left: parent.left
            anchors.right: parent.right
            anchors.leftMargin: 70
            anchors.rightMargin: 70

            wrapMode: TextEdit.Wrap
            selectByMouse: true

            font.pointSize: 10
        }
    }
}
