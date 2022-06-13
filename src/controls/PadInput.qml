import QtQuick.Controls 2.15
import QtQuick 2.15
import QtQuick.Layouts 1.12
import org.mauikit.controls 1.3 as Maui
import QtQuick.Templates 2.15 as T

T.Control
{
    id: control

    implicitHeight: implicitContentHeight + topPadding + bottomPadding
    implicitWidth: 250 + leftPadding + rightPadding

    spacing: Maui.Style.space.big

    padding: Maui.Style.space.big
    property alias inputArea : _inputArea
    property alias historyArea: _historyLabel
    property alias resultArea : _resultArea

    contentItem: Column
    {
        id: _layout
        spacing: control.spacing

        ScrollView
        {
            id: _scrollView
            implicitHeight: Math.min(contentHeight + topPadding + bottomPadding, 80)
            width: parent.width
            LayoutMirroring.enabled: true
            //            padding: Maui.Style.space.big
            //            Layout.fillHeight: true
            contentWidth: availableWidth

            Flickable
            {
                id: _flickable

                interactive: Maui.Handy.isTouch
                boundsBehavior : Flickable.StopAtBounds
                boundsMovement : Flickable.StopAtBounds

                TextArea.flickable: TextArea
                {
                    id: _historyLabel
                    readOnly: true
                    width: parent.width
                    horizontalAlignment: Qt.AlignRight
                    opacity: 0.7
                    selectByMouse: true
                    wrapMode: TextEdit.WrapAnywhere
                    //                    font.pointSize: Maui.Style.fontSizes.small
                }
            }
        }

        TextArea
        {
            id: _resultArea
            width: parent.width
            font.bold: true
            font.weight: Font.Bold
            readOnly: true
            font.pointSize: Maui.Style.fontSizes.enormous
            horizontalAlignment: Qt.AlignRight
            selectByMouse: true
            wrapMode: TextEdit.WrapAnywhere
        }

        TextField
        {
            id: _inputArea
            focus: true
            selectByMouse: true
            wrapMode: TextEdit.WrapAnywhere
            //            focusPolicy: Qt.StrongFocus
            width: parent.width
            horizontalAlignment: Qt.AlignRight
        }
    }
}
