import QtQuick 2.0
import QtQuick.Controls 2.2

Button {
    MouseArea {
        id: mouseArea
        anchors.fill: parent
        hoverEnabled: true

    }

    background: Rectangle {
        anchors.fill: parent
        color: "#000000"
        opacity: 0.1
        radius: parent.width/2
        smooth: true

        visible: mouseArea.containsMouse ? true : false
    }
}
