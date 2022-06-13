import QtQuick 2.15
import QtQml 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.12

import org.mauikit.controls 1.3 as Maui

Maui.ApplicationWindow
{
    id: root
    title: qsTr("Astro")
headBar.background: null
maximumWidth: 450
maximumHeight: 800
minimumWidth: _mainLayout.implicitWidth
minimumHeight: _mainLayout.implicitHeight + page.headerContainer.implicitHeight

Maui.Theme.colorSet: Maui.Theme.Window

headBar.middleContent: Maui.ToolActions
{
    expanded: true
    autoExclusive: true
    Layout.alignment: Qt.AlignCenter
Action
{
    icon.name: "math7"

}

Action
{
    icon.name: "mathmode"

}
}

    headBar.leftContent: Maui.ToolButtonMenu
    {
        icon.name: "application-menu"
        MenuItem
        {
            text: i18n("Settings")
            icon.name: "settings-configure"
        }

        MenuItem
        {
            text: i18n("About")
            icon.name: "documentinfo"
            onTriggered: root.about()
        }
    }

    ColumnLayout
    {
        id: _mainLayout
        anchors.fill: parent
        spacing: Maui.Style.space.big

        PadInput
        {
            Layout.fillWidth: true
//            Layout.fillHeight: true
            Layout.maximumHeight: 500
            Layout.minimumHeight: implicitHeight
            historyArea.text: "1+2\n3+4\n1+2\n3+4\n1+2\n3+4\n1+2\n3+4\n1+2\n3+4\n1+2\n3+4\n1+2\n3+4\n1+2\n3+4\n"
            resultArea.text: "7"
        }

        PadLayout
        {
            Layout.alignment: Qt.AlignCenter
            Layout.fillWidth: true
//            Layout.fillHeight: true

            Layout.minimumWidth: implicitWidth
            Layout.maximumWidth: implicitWidth
        }


    }


}
