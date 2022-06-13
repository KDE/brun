import QtQuick.Controls 2.15
import QtQuick 2.15
import org.mauikit.controls 1.3 as Maui

Button
{
    id: control

    focus: false
    focusPolicy: Qt.NoFocus

    implicitWidth: 64 + leftPadding + rightPadding
    implicitHeight: 48 + topPadding + bottomPadding

    property bool dimmable: false
    property bool operator: false
    property color color : Maui.Theme.backgroundColor

    font.bold: true
    font.weight: Font.Bold
    font.pointSize: Maui.Style.fontSizes.big

    background: Rectangle
    {
        id: _bg
        color: control.pressed ? Qt.darker(control.color, 1.2) : (control.hovered ? Qt.lighter(control.color, 1.5) : control.color)
        radius: Maui.Style.radiusV
    }

    contentItem: Label
    {
        text: control.text
        color: Maui.ColorUtils.brightnessForColor(_bg.color) === Maui.ColorUtils.Dark ? Qt.lighter(_bg.color, 2) : Qt.darker(_bg.color, 2)
        font: control.font
        horizontalAlignment: Qt.AlignHCenter
        verticalAlignment: Qt.AlignVCenter
    }
}
