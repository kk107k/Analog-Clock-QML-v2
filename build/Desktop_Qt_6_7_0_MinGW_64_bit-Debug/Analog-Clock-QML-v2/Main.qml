import QtQuick

Window {
    width: 1000
    height: 1000
    visible: true
    title: qsTr("Hello World")

    Clock
    {
        id: clock
        width: 650
        height: 650
    }

}
