import QtQuick 2.0
import QtQuick.Controls 2.2

Rectangle {
    id: registration
    signal regButtonClicked(string username, string password, string checkPassword)
    signal backButtonClicked()
    property string property_message
    property bool   property_warning:true

    color: "#dedede"
    state: "State1"

    Rectangle {
        id: reg_Rectangle
        anchors.centerIn: parent
        width: 400
        height: 550
        color: "#ffffff"
        radius: 3
        smooth: true

        Text {
            id: reg_text
            anchors.top: parent.top
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.topMargin: 20

            color: "#00c4ff"
            font.pointSize: 14
            text:  "Для регистрации в Messenger\nпридумайте ваши уникальные\nимя пользователя и пароль"
        }

        EnterText {
            id: username_EnterText
            anchors.top: reg_text.bottom
            anchors.left: parent.left
            anchors.right: parent.right
            anchors.topMargin: 50
            anchors.leftMargin: 50
            anchors.rightMargin: 50
            height: 50

            property_defaultText: "Имя пользователя"
            property_maxLength: 16
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
        }

        EnterText {
            id: checkPassword_EnterText
            anchors.top: password_EnterText.bottom
            anchors.left: parent.left
            anchors.right: parent.right
            anchors.topMargin: 40
            anchors.leftMargin: 50
            anchors.rightMargin: 50
            height: 50

            property_defaultText: "Пароль еще раз"
        }

        Text {
            id: message
            anchors.top: checkPassword_EnterText.bottom
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.topMargin: 10

            color: property_warning ? "#bb0000" : "#00c4ff"
            font.pointSize: 10
            text: property_message
        }

        Button {
            id: reg_button
            anchors.top: checkPassword_EnterText.bottom
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.topMargin: 50

            text: "ЗАРЕГИСТРИРОВАТЬСЯ"
            onClicked: {
                registration.regButtonClicked(username_EnterText.text, password_EnterText.text, checkPassword_EnterText.text)
            }
        }

        TextButton {
            id: back_button
            anchors.bottom: parent.bottom
            anchors.left: parent.left
            anchors.bottomMargin: 20
            anchors.leftMargin: 20
            height: 30

            text: "Назад"
            onButtClicked: {
                registration.backButtonClicked()
            }
        }
    }

    states: [
        State {
            name: "State1"
            PropertyChanges {
                target: registration
                anchors.leftMargin: parent.width
            }
        },
        State {
            name: "State2"
            PropertyChanges {
                target: registration
                anchors.leftMargin: 0
            }
        }
    ]
    transitions: [
        Transition {
            from: "*"
            to: "*"
            PropertyAnimation{
                target: registration
                properties: "anchors.leftMargin"
                easing.type: Easing.InCirc
                duration: 150
            }
        }
    ]
}
