import QtQuick 2.12
import QtQuick.Window 2.12

Window {
    visible: true
    width: 1200
    height: 900
    title: qsTr("Messenger")

    ToolBar {
        id: toolBar
        anchors.top: parent.top
        anchors.left: parent.left
        height: 60
        width: parent.width/3
    }

    Rectangle { // TODO: listView
        id: contact_list
        anchors.top: toolBar.bottom
        anchors.bottom: parent.bottom
        anchors.left: parent.left
        width: toolBar.width
        color: "#000000"
        opacity: 0.5
    }

    Rectangle {
        id: dialog
        anchors.top: parent.top
        anchors.bottom: parent.bottom
        anchors.left: toolBar.right
        anchors.right: parent.right
        color: "#000000"
        opacity: 0.6
    }
}
