import QtQuick 2.12
import QtQuick.Window 2.12
import QtQuick.Layouts 1.12

import DialogModel 1.0
import MessageModel 1.0

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

    function displayDialog(username){
        msgToolBar.property_companionUsername = username
        msgToolBar.color = "#ffffff"
        //msgTextEdit.color = "#ffffff"
    }

    /* main_item contains toolbar where are located:
     *  - Menu button which displays the menu when pressed,
     *  - Search through which you can find another user
     * Also contactList with ListView which displays all user dialogs.
     * When user clicked at contact, app displays
     * all messages in the conversation.
     * And dialog_item with messages */

    Item {
        id: main_item
        anchors.fill: parent
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

        Rectangle {
            id: contactList
            anchors.top: toolBar.bottom
            anchors.bottom: parent.bottom
            anchors.left: parent.left
            width: toolBar.width

            ListView {
                id: contactList_ListView
                anchors.fill: parent

                clip: true

                model: DialogModel {
                    id: dialogModel
                    list: app.getDialogList()
                }

                delegate:  DialogList_Delegate {
                    id: dlgList_Delegate
                    property_usernameText: model.username
                    property_messageText: model.lastMessage
                    property_newMessage: model.newMessageFlag

                    Component.onCompleted: {
                        contactClicked.connect(win.displayDialog)
                    }
                    onContactClicked: {
                        messageModel.list = app.openDialog(index)
                    }
                }
            }
        }


        /* dialog_item contains:
         * - toolbar with buttons for dialog,
         * - all messages between two users,
         * - textEdit when user can write your own message and send it. */

        Item {
           id: dialog_item
            anchors.top: parent.top
            anchors.bottom: parent.bottom
            anchors.left: toolBar.right
            anchors.right: parent.right

            MessageToolBar{
                id: msgToolBar
                anchors.top: parent.top
                anchors.left: parent.left
                anchors.right: parent.right
                height: toolBar.height
                color: dialog.color
            }

            Rectangle {
                id: dialog
                anchors.top: msgToolBar.bottom
                anchors.bottom: msgTextEdit.bottom
                anchors.left: parent.left
                anchors.right: parent.right
                color: "#dedede"

                ListView {
                    id: dialogList_ListView
                    anchors.fill: parent
                    anchors.topMargin: 5
                    anchors.bottomMargin: 5
                    clip: true
                    spacing: 5

                    model: MessageModel {
                        id: messageModel
                    }

                    delegate: MessageList_Delegate {
                        id: message_rect

                        property_message: model.message
                        property_date: model.date
                        property_fromClient: model.fromClient
                    }
                }
            }

            MessageTextEdit {
                id: msgTextEdit
                anchors.left: parent.left
                anchors.right: parent.right
                anchors.bottom: parent.bottom

                property_maxHeight: win.height/2
            }
        }

        // Line separator
        Rectangle {
            id: separator
            anchors.top: parent.top
            anchors.bottom: parent.bottom
            anchors.left: toolBar.right
            width: 2
            color: dialog.color
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
