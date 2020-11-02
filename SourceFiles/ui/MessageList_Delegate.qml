import QtQuick 2.0
import QtGraphicalEffects 1.0

Rectangle {
    id: messageList_delegate
    property string property_message
    property string property_date
    property bool   property_fromClient

    anchors.left: property_fromClient ? undefined : parent.left
    anchors.right: property_fromClient ? parent.right : undefined
    anchors.leftMargin: property_fromClient ? undefined : 20
    anchors.rightMargin: property_fromClient ? 20 : undefined

    width: message_Text.width + 20
    height: message_Text.height + 20

    color: property_fromClient ? "#43f7c1" : "#bdf0e1"
    radius: 3
    smooth: true


    Text {
        id: message_Text
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.verticalCenter: parent.verticalCenter

        wrapMode: Text.WordWrap
        width: contentWidth > 500 ? 500 : contentWidth

        text: property_message
        font.pointSize: 10
    }
}
