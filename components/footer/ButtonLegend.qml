import QtQuick 2.15

Item {
    property string key: 'X';
    property string title: 'Title';
    property bool square: false;
    property double fontSize: {
        return vpx(20)//footer.height * .24;
    }
    property double squareWidth: {
        return footer.height * .54;
    }

    height: footer.height * .4;
    width: icon.width + outerText.width + 4;

    // button background
    Rectangle {
        id: icon;

        height: vpx(45)//parent.height;
        width: vpx(45)//square ? squareWidth : parent.height;
        radius: square ? .2 * squareWidth : parent.height;
        color: '#444444';
        anchors.verticalCenter: parent.verticalCenter;

        // button inner text
        Text {
            text: key;
            color: theme.current.buttonLetterColor;

            font {
		family: subtitleFont.name;
                pixelSize: fontSize*1.2;
                letterSpacing: -0.3;
                //bold: true;
            }

            anchors {
                verticalCenter: parent.verticalCenter;
                horizontalCenter: parent.horizontalCenter;
            }
        }
    }

    // button outer text
    Text {
        id: outerText;

        text: title;
        color: theme.current.buttonLabelColor;

        font {
		family: subtitleFont.name;
            pixelSize: fontSize*1.2;
            letterSpacing: -0.3;
            //bold: true;
        }

        anchors {
            verticalCenter: parent.verticalCenter;
            left: icon.right;
            leftMargin: footer.height * .07;
        }
    }
}
