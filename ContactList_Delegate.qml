import QtQuick 2.0

Rectangle {
    id: contactList_delegate
    property string property_usernameText
    property string property_messageText

    signal contactClicked();

    height: 80
    width: parent.width

    Text {
        id: username
        anchors.top: parent.top
        anchors.left: parent.left
        anchors.topMargin: 10
        anchors.leftMargin: 60

        text: property_usernameText
        color: "#000000"
        font.pointSize: 12
    }
    Text {
        id: message
        anchors.top: username.bottom
        anchors.left: parent.left
        anchors.topMargin: 10
        anchors.leftMargin: 60

        text: property_messageText
        color: "#a3a3a3"
        font.pointSize: 10
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
            contactList_delegate.contactClicked()
        }
    }
}
