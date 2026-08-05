import QtQuick 2.15
import Qt.labs.qmlmodels 1.0
import '../footer' as Footer

Item {

    property alias textInput: nameFilterTextInput;
	
    property alias sortingListView: sortingListView;
    property double itemHeight: {
        return sortingListView.height * .16 * theme.fontScale;
    }

    Component.onCompleted: {
        sortingListView.currentIndex = 0;
        sortingListView.positionViewAtIndex(0, ListView.Center);
    }

    ListView {
        id: sortingListView;

        model: sorting.model;
        delegate: lvSortingDelegate;
        width: parent.width - 40; // minus the margins
        height: parent.height - 24;
        highlightMoveDuration: 0;
        preferredHighlightBegin: itemHeight - 12; // height of an item minus top margin
        preferredHighlightEnd: parent.height - (itemHeight + 12); // height of an item plus bottom margin
        highlightRangeMode: ListView.ApplyRange;

        anchors {
            left: parent.left;
            leftMargin: 20;
            top: parent.top;
            topMargin: 12;
            bottom: parent.bottom;
            bottomMargin: 12;
            right: parent.right;
            rightMargin: 20;
        }

        highlight: Rectangle {
            color: theme.current.highlightColor;
            radius: 8;
            width: sortingListView.width;
        }
    }
		
    Rectangle {
        radius: 10;
        height: parent.height * .35;
        width: parent.width * .7;
        color: theme.current.bgColor;
        border.color: theme.current.dividerColor;

        anchors {
            top: parent.top;
            topMargin: root.height * .06;
            horizontalCenter: parent.horizontalCenter;
        }

        Text {
            id: modalTitle;

            text: if (nameFilter === '') return '请输入筛选关键词';
					else return '当前筛选关键词:';//'输入筛选关键词';
            height: root.height * .1;
            verticalAlignment: Text.AlignVCenter;
            color: theme.current.defaultHeaderNameColor

            font {
                pixelSize: Math.min(parent.height * .15,parent.width * .08);
                letterSpacing: -0.3;
               // bold: true;
				family: subtitleFont.name;
            }

            anchors {
                top: parent.top;
                left: parent.left;
                leftMargin: 27;
            }
        }

        Rectangle {
            id: modalDividerTop;

            height: 1;
            color: theme.current.dividerColor;

            anchors {
                top: modalTitle.bottom;
                left: parent.left;
                leftMargin: 23;
                right: parent.right;
                rightMargin: 23;
            }
        }

        Rectangle {
            id: textBox;
			
            border.color: theme.current.textInputBorderColor;
            color: theme.current.textInputBackgroundColor;

            anchors {
                top: modalDividerTop.bottom;
                topMargin: 20;
                left: parent.left;
                leftMargin: 27;
                right: parent.right;
                rightMargin: 27;
                bottom: parent.bottom;
                bottomMargin: 20;
            }

            Text {
                text: sortingScroll.textInput.focus ? '正在输入···':'(请"点击"或按"手柄Y键"激活输入框)';
                verticalAlignment: Text.AlignVCenter;
                color: theme.current.textInputPlaceholderColor;
                visible: nameFilterTextInput.preeditText === '' && nameFilterTextInput.text === '';

                anchors {
                    fill: parent;
                    leftMargin: 10;
                }

                font {
                    pixelSize: Math.min(parent.height * .4,parent.width * .08);
                    letterSpacing: -0.3;
                    //bold: true;
					family: subtitleFont.name;
                }
            }

            TextInput {
                id: nameFilterTextInput;
                text: nameFilter;
                verticalAlignment: Text.AlignVCenter;
                color: nameFilterTextInput.text === '' || sortingScroll.textInput.focus ? theme.current.defaultHeaderNameColor : "red";
                anchors {
                    fill: parent;
                    leftMargin: 10;
                }

                font {
                    pixelSize: Math.min(parent.height * .45,parent.width * .1);
                    letterSpacing: -0.3;
                    //bold: true;
					family: subtitleFont.name;
                }
				// focus: true;	
            }
        }

        // Footer.Component {
            // id: nameFilterModalFooter;

            // total: 0;
            // radius: 11;

            // anchors {
                // bottomMargin: 1;
                // leftMargin: 1;
                // rightMargin: 1;
            // }


        // }
    }


}
