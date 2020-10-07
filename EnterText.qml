import QtQuick 2.0

Item {
    property string property_defaultText
    property string text: textInput.text

    Rectangle {
        id: textInput_Rectangle
        anchors.fill: parent

        border.width: textInput.focus ? 2 : 0
        border.color: "#00c4ff"
        color: textInput.focus ? "#ffffff" : "#dedede"
        radius: 3
        smooth: true
        clip: true

        TextInput {
           id: textInput
           anchors.verticalCenter: parent.verticalCenter
           anchors.left: parent.left
           anchors.right: parent.right
           anchors.leftMargin: 20
           anchors.rightMargin: 20
           font.pointSize: 10
        }
    }

    Text {
        anchors.verticalCenter: textInput_Rectangle.verticalCenter
        anchors.left: textInput_Rectangle.left
        anchors.right: textInput_Rectangle.right
        anchors.leftMargin: 20
        anchors.rightMargin: 20

        font.pointSize: 10
        opacity: 0.5
        visible: textInput.text == "" ? true : false
        text: property_defaultText
    }
}
