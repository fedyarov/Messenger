import QtQuick 2.0
import QtQuick.Controls 2.2

Button {
    id: button
    signal buttClicked()
    MouseArea {
        id: mouseArea
        anchors.fill: parent
        hoverEnabled: true
        onPressed: {
            button_Rectangle.opacity = 0.2
            button_Rectangle.scale = 0.85
        }
        onReleased: {
            button_Rectangle.opacity = 0.1
            button_Rectangle.scale = 1
            parent.buttClicked()
        }
    }

    background: Rectangle {
        id: button_Rectangle
        anchors.fill: parent
        color: "#000000"
        opacity: 0.1
        radius: parent.width/2
        smooth: true

        visible: mouseArea.containsMouse ? true : false
    }
}
