import QtQuick 2.12
import QtQuick.Window 2.12

Window {
    id: win
    visible: true
    width: 1200
    height: 900
    title: qsTr("Messenger")

    Connections{
        target: app
        onLoginResult: {
            onLogin();
        }

        onLoginConnectionError: {
            auth_message("Нет соединения");
        }

        onLoginPasswordError: {
            auth_message("Неверный логин или пароль");
        }
    }

    function onLogin() {
        main_item.state = "State2"
        authorization.state = "State2"
    }

    function auth_message(message) {
        authorization.property_message = message;
    }

    Item {
        id: main_item
        anchors.top: parent.top
        anchors.bottom: parent.bottom
        anchors.left: parent.left
        anchors.right: parent.right
        state: "State1"

        ToolBar {
            id: toolBar
            anchors.top: parent.top
            anchors.left: parent.left
            height: 60
            width: parent.width/3

            onMenu_button_clicked: {
                menu.state = "State2"
            }
        }

        Rectangle { // TODO: listView
            id: contact_list
            anchors.top: toolBar.bottom
            anchors.bottom: parent.bottom
            anchors.left: parent.left
            width: toolBar.width
            color: "#ffffff"
        }

        Rectangle {
            id: dialog
            anchors.top: parent.top
            anchors.bottom: parent.bottom
            anchors.left: toolBar.right
            anchors.right: parent.right
            color: "#dedede"
        }

        states: [
            State {
                name: "State1"
                PropertyChanges {
                    target: main_item
                    anchors.leftMargin: -win.width
                }
            },
            State {
                name: "State2"
                PropertyChanges {
                    target: main_item
                    anchors.leftMargin: 0
                }
            }
        ]
        transitions: [
            Transition {
                from: "*"
                to: "*"
                PropertyAnimation{
                    target: main_item
                    properties: "anchors.leftMargin"
                    easing.type: Easing.InCirc
                    duration: 150
                }
            }
        ]
    }

    Menu {
        id: menu
        anchors.top: parent.top
        anchors.bottom: parent.bottom
        anchors.left: parent.left
        width: 340

        property_windowWidth: parent.width
        property_account_username: app.username
    }

    Authorization {
        id: authorization
        anchors.top: parent.top
        anchors.bottom: parent.bottom
        anchors.left: parent.left
        width: parent.width

        onLoginButtonClicked: {
            app.login(username, password)
        }
    }
}
