import QtQuick 2.0
import QtQuick.Controls 2.2

Rectangle {
    id: authorization
    signal authButtonClicked()

    color: "#dedede"
    state: "State1"

    Rectangle {
        id: auth_Rectangle
        anchors.centerIn: parent
        width: 400
        height: 450
        color: "#aaaaaa"
        radius: 3
        smooth: true

        Text {
            id: welcome_Text
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.top: parent.top
            anchors.topMargin: 20

            color: "#ffffff"
            font.pointSize: 14
            text: "Для авторизации в Messenger\nвведите ваши логин и пароль."
        }

        EnterText {
           id: login
           anchors.top: welcome_Text.bottom
           anchors.left: parent.left
           anchors.right: parent.right
           anchors.topMargin: 70
           anchors.leftMargin: 50
           anchors.rightMargin: 50
           height: 50

           property_defaultText: account_login
        }
        EnterText {
           id: password
           anchors.top: login.bottom
           anchors.left: parent.left
           anchors.right: parent.right
           anchors.topMargin: 40
           anchors.leftMargin: 50
           anchors.rightMargin: 50
           height: 50

           property_defaultText: "Пароль"
        }
        Button {
            id: auth_button
            anchors.top: password.bottom
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.topMargin: 50
            height: 50
            text: "Войти"

            onClicked: {
                authorization.authButtonClicked()
            }
        }
    }

    states: [
        State {
            name: "State1"
            PropertyChanges {
                target: authorization
                anchors.leftMargin: 0
            }
        },
        State {
            name: "State2"
            PropertyChanges {
                target: authorization
                anchors.leftMargin: parent.width
            }
        }
    ]
    transitions: [
        Transition {
            from: "*"
            to: "*"
            PropertyAnimation {
                target: authorization
                properties: "anchors.leftMargin"
                easing: Easing.InCirc
                duration: 150
            }
        }
    ]
}
