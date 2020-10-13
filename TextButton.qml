import QtQuick 2.0
import QtQuick.Controls 2.2

Button {
    property string property_text
    property string property_textColor: "#000000"
    property string property_rectColor: "#000000"
    property string property_icon
    property int    property_pointSize: 10
    property int    property_leftMargin: 100

    signal buttClicked()

    Text {
        anchors.verticalCenter: parent.verticalCenter
        anchors.left: parent.left
        anchors.leftMargin: property_leftMargin

        color: property_textColor
        font.pointSize: property_pointSize
        text: property_text
    }

    MouseArea {
        id: mouseArea
        anchors.fill: parent
        hoverEnabled: true

        onPressed: {
            button_rect.opacity = 0.2
        }
        onReleased: {
            button_rect.opacity = 0.1
            buttClicked()
        }
    }

    background:Rectangle {
        id: button_rect
        anchors.fill: parent

        color: property_rectColor
        opacity: 0.1
        visible: mouseArea.containsMouse ? true : false
    }
}
