import QtQuick 2.0

Rectangle {
    id: menu_rect
    property int property_windowWidth
    property string property_account_username

    color: "#ffffff"
    state: "State1"

    Rectangle {
        id: back_mouseArea
        anchors.top: parent.top
        anchors.bottom: parent.bottom
        anchors.left: parent.right
        width: property_windowWidth

        color: "#000000"
        opacity: 0.2
        visible: menu_rect.state == "State2" ? true : false

        MouseArea {
            anchors.fill: parent

            onClicked: {
                menu_rect.state = "State1"
            }
        }
    }

    Rectangle {
        id: account_rect
        anchors.top: parent.top
        anchors.left: parent.left
        anchors.right: parent.right
        height: 170

        color: "#dedede"

        Text {
            anchors.bottom: parent.bottom
            anchors.left: parent.left
            anchors.bottomMargin: 40
            anchors.leftMargin: 20

            text: property_account_username
            font.pointSize: 12
        }
    }

    TextButton {
        id: createGroup_button
        anchors.top: account_rect.bottom
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.topMargin: 20
        height: 40

        property_text: "Создать группу"
    }

    TextButton {
        id: settings_button
        anchors.top: createGroup_button.bottom
        anchors.left: parent.left
        anchors.right: parent.right
        height: 40

        property_text: "Настройки"
    }

    states: [
        State {
            name: "State1"
            PropertyChanges {
                target: menu_rect
                anchors.leftMargin: -menu_rect.width
            }
        },
        State {
            name: "State2"
            PropertyChanges {
                target: menu_rect
                anchors.leftMargin: 0
            }
        }
    ]
    transitions: [
        Transition {
            from: "*"
            to: "*"
            PropertyAnimation {
                target: menu_rect
                properties: "anchors.leftMargin"
                easing.type: Easing.InCirc
                duration: 150
            }
        }
    ]
}
