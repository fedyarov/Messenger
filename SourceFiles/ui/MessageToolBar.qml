import QtQuick 2.0

Rectangle {
    property string property_companionUsername

    Text {
        id: companionUsername
        anchors.verticalCenter: parent.verticalCenter
        anchors.left: parent.left
        anchors.leftMargin: 20

        font.pointSize: 12
        text: property_companionUsername
    }
}
