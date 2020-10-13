import QtQuick 2.0
import QtQuick.Controls 2.2

Rectangle {
    id: authorization
    signal loginButtonClicked(string username, string password)
    property string property_message;

    color: "#dedede"
    state: "State1"

    Rectangle {
        id: auth_Rectangle
        anchors.centerIn: parent
        width: 400
        height: 500
        color: "#ffffff"
        radius: 3
        smooth: true

        Text {
            id: welcome_Text
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.top: parent.top
            anchors.topMargin: 20

            color: "#00c4ff"
            font.pointSize: 14
            text: "Для авторизации в Messenger\nвведите ваши логин и пароль"
        }

        EnterText {
           id: username_EnterText
           anchors.top: welcome_Text.bottom
           anchors.left: parent.left
           anchors.right: parent.right
           anchors.topMargin: 50
           anchors.leftMargin: 50
           anchors.rightMargin: 50
           height: 50

           property_defaultText: "Имя аккаунта"
           //text: "mfedyarov"
        }

        EnterText {
           id: password_EnterText
           anchors.top: username_EnterText.bottom
           anchors.left: parent.left
           anchors.right: parent.right
           anchors.topMargin: 40
           anchors.leftMargin: 50
           anchors.rightMargin: 50
           height: 50

           property_defaultText: "Пароль"
           //text: "123"
        }

        Text {
            id: warning_message
            anchors.top: password_EnterText.bottom
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.topMargin: 10

            color: "#bb0000"
            font.pointSize: 10
            text: property_message
        }

        Button {
            id: auth_button
            anchors.top: password_EnterText.bottom
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.topMargin: 50
            height: 50
            text: "ВОЙТИ"

            onClicked: {
                authorization.loginButtonClicked(username_EnterText.text, password_EnterText.text)
            }
        }

        Text {
            id: registration_text
            anchors.top: auth_button.bottom
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.topMargin: 35
            color: "#00c4ff"
            font.pointSize: 12
            text: "Нет аккаунта в Messenger?"
        }

        TextButton {
            id: registration_button
            anchors.top: registration_text.bottom
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.topMargin: 5
            height: 30

            text: "Зарегистрироваться"
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
                easing.type: Easing.InCirc
                duration: 150
            }
        }
    ]
}
