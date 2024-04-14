import QtQuick

Window {
    width: 500
    height: 500
    visible: true
    title: qsTr("Hello World")

    Clock
    {
        id: clock
        width: 500
        height: 500
    }

}
