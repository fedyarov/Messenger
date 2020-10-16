import QtQuick 2.12
import QtQuick.Window 2.12
import QtQuick.Layouts 1.12

import Dialog 1.0

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

        onRegResult: {
            reg_message("Ваш аккаунт успешно создан", false);
        }
        onRegConnectionError: {
            reg_message("Нет соединения", true);
        }
        onRegPasswordError: {
            reg_message("Пароли не совпадают", true);
        }
        onRegUsernameError: {
            reg_message("Неверное имя пользователя", true);
        }
        onRegUsernameIsTaken: {
            reg_message("Имя пользователя уже занято", true);
        }
    }

    function onLogin() {
        main_item.state = "State2"
        authorization.state = "State2"
    }

    function auth_message(message) {
        authorization.property_message = message;
    }

    function reg_message(message, warning_flag) {
        registration.property_message = message;
        registration.property_warning = warning_flag;
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
                //menu.state = "State2"
                app.setItemToFirst();
            }
        }

        Rectangle {
            id: contact_list
            anchors.top: toolBar.bottom
            anchors.bottom: parent.bottom
            anchors.left: parent.left
            width: toolBar.width
            color: "#ffffff"

            ListView {
                id: contact_list_ListView
                anchors.fill: parent

                model: DialogModel {
                    list: app.getDialogList()
                }
                clip: true

                delegate:  DialogList_Delegate {
                    property_usernameText: model.username
                    property_messageText: model.message
                    property_newMessage: model.newMessageFlag

                    onContactClicked: {
                        app.openDialog(index)
                    }
                }
            }
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
        onRegistrationButtonClicked: {
            authorization.state = "State3"
            registration.state = "State2"
        }
    }

    Registration {
        id: registration
        anchors.top: parent.top
        anchors.bottom: parent.bottom
        anchors.left: parent.left
        width: parent.width

        onRegButtonClicked: {
            app.registration(username, password, checkPassword)
        }
        onBackButtonClicked: {
            authorization.state = "State1"
            registration.state = "State1"
        }
    }
}
