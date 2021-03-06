import QtQuick 2.0

Rectangle {
    id: dialogList_delegate
    property string property_usernameText
    property string property_messageText
    property bool   property_newMessage

    signal contactClicked(string name)

    height: 70
    width: parent.width

    Text {
        id: username
        anchors.top: parent.top
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.topMargin: 10
        anchors.leftMargin: 60
        anchors.rightMargin: 10
        elide: Text.ElideRight

        text: property_usernameText
        color: "#000000"
        font.pointSize: 12
    }
    Text {
        id: message
        anchors.bottom: parent.bottom
        anchors.left: parent.left
        anchors.right: notice.left
        anchors.bottomMargin: 10
        anchors.leftMargin: 60
        anchors.rightMargin: 10
        elide: Text.ElideRight

        text: property_messageText
        color: "#a3a3a3"
        font.pointSize: 10
    }
    Rectangle {
        id: notice
        anchors.bottom: parent.bottom
        anchors.right: parent.right
        anchors.bottomMargin: 10
        anchors.rightMargin: 10

        width: 20
        height: 20
        radius: width/2
        color: "#00c4ff"
        smooth: true
        visible: property_newMessage
    }

    Rectangle {
        id: rectangle
        anchors.fill: parent
        color: "#000000"
        opacity: 0.05
        visible: mouseArea.containsMouse ? true : false
    }
    MouseArea {
        id: mouseArea
        anchors.fill: parent
        hoverEnabled: true

        onPressed: {
            rectangle.opacity = 0.1
        }
        onReleased: {
            rectangle.opacity = 0.05
            dialogList_delegate.contactClicked(username.text)
        }
    }
}
