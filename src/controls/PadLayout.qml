import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.12
import org.mauikit.controls 1.3 as Maui
import QtQuick.Templates 2.15 as T

T.Control
{
    id: control
    implicitHeight: implicitContentHeight + topPadding + bottomPadding
    implicitWidth: implicitContentWidth + leftPadding + rightPadding

    spacing: Maui.Style.space.medium
    padding: Maui.Style.space.big

    contentItem: GridLayout
    {
        id: _layout
        rowSpacing: control.spacing
        columnSpacing: control.spacing
        columns: 4
        rows: 6

        CalcButton { text: "C"; color: Maui.Theme.neutralBackgroundColor}
        CalcButton { text: "("; color: Maui.Theme.alternateBackgroundColor}
        CalcButton { text: ")"; color: Maui.Theme.alternateBackgroundColor}
        CalcButton { text: "X"; color: Maui.Theme.positiveBackgroundColor}


        CalcButton { text: "√"; color: Maui.Theme.alternateBackgroundColor}
        CalcButton { text: "%"; color: Maui.Theme.alternateBackgroundColor}
        CalcButton { text: "±"; color: Maui.Theme.alternateBackgroundColor}
        CalcButton { text: "÷"; color: Maui.Theme.positiveBackgroundColor}


        CalcButton { text: "7" }
        CalcButton { text: "8" }
        CalcButton { text: "9" }
        CalcButton { text: "−"; color: Maui.Theme.positiveBackgroundColor; operator: true; dimmable: true }

        CalcButton { text: "4" }
        CalcButton { text: "5" }
        CalcButton { text: "6" }
        CalcButton { text: "+"; color: Maui.Theme.positiveBackgroundColor; operator: true; dimmable: true }

        CalcButton { text: "1" }
        CalcButton { text: "2" }
        CalcButton { text: "3" }
        CalcButton { text: "="; Layout.rowSpan: 2; color: Maui.Theme.highlightColor; Layout.fillHeight: true;}

        CalcButton { text: "."; dimmable: true }
        CalcButton { text: "0" }
        CalcButton { text: "⎚"; color: Maui.Theme.negativeBackgroundColor}
    }

}
