import QtQuick 2.15
import QtGraphicalEffects 1.12

import '../footer' as Footer

FocusScope {
    property var blurSource;
    property alias textInput: nameFilterTextInput;

    // background to lighten or darken the blur effect, since it's translucent
    Rectangle {
        color: theme.current.bgColor;
        anchors.fill: parent;

		//点击任意地区返回列表
        MouseArea {
        anchors.fill: parent;
            onClicked: {
		//	onCancelPressed();
            }
        }
    }

    FastBlur {
        width: root.width;
        height: root.height;
        radius: 80;
        opacity: .1;
        source: blurSource;
        cached: true;
    }

    Rectangle {
        radius: 10;
        height: parent.height * .4;
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
            height: root.height * .115;
            verticalAlignment: Text.AlignVCenter;
            color: theme.current.defaultHeaderNameColor

            font {
                pixelSize: parent.height * .11;
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
                bottom: nameFilterModalFooter.top;
                bottomMargin: 20;
            }

            Text {
                text: '(无内容)';
                verticalAlignment: Text.AlignVCenter;
                color: theme.current.textInputPlaceholderColor;
                visible: nameFilterTextInput.preeditText === '' && nameFilterTextInput.text === '';

                anchors {
                    fill: parent;
                    leftMargin: 10;
                }

                font {
                    pixelSize: parent.height * .6;
                    letterSpacing: -0.3;
                    //bold: true;
					family: subtitleFont.name;
                }
            }

            TextInput {
                id: nameFilterTextInput;
                text: nameFilter;
                verticalAlignment: Text.AlignVCenter;
                color: theme.current.defaultHeaderNameColor
                anchors {
                    fill: parent;
                    leftMargin: 10;
                }

                font {
                    pixelSize: parent.height * .6;
                    letterSpacing: -0.3;
                    //bold: true;
					family: subtitleFont.name;
                }
				focus: true;	
            }
        }

        Footer.Component {
            id: nameFilterModalFooter;

            total: 0;
            radius: 11;

            anchors {
                bottomMargin: 1;
                leftMargin: 1;
                rightMargin: 1;
            }

	Image{
		id: pegasusLogo
		source: '../../../Resource/Background_image1/Pegasus G.png';
		sourceSize { width: 256; height:256 }
		smooth: true
        antialiasing: true
		fillMode: Image.PreserveAspectFit;
        horizontalAlignment: Image.AlignLeft;
		visible: currentView != 'sorting'
		// width: parent.width * .05;
        height: parent.height * .7;
		
		anchors {
            verticalCenter: parent.verticalCenter;
            left: parent.left;
            leftMargin: 14;
        }
	}
	
	Text {
		id: pegaLU
        text: 'Pegasus G'
        color: theme.current.buttonLabelColor
		horizontalAlignment: Text.AlignRight;
		visible: currentView != 'sorting'
        opacity: 1;
		font.family: subtitleFont.name
        anchors {	
            left:pegasusLogo.right; leftMargin: 16;
			top:parent.top
			topMargin:parent.height * .10
			// verticalCenter: parent.verticalCenter; 
        }

        font {
            pixelSize: parent.height * .28;
            letterSpacing: -0.3;
            
        }
    }
	
	Text {
		id: pegaLD
        text: '跳坑者联盟'
        color: theme.current.buttonLabelColor
		horizontalAlignment: Text.AlignRight;
		visible: currentView != 'sorting'
        opacity: 1;
		font.family: subtitleFont.name
        anchors {	
            // left:pegasusLogo.right;leftMargin: 14;
			top:pegaLU.bottom
			// topMargin:parent.height * .18
			horizontalCenter: pegaLU.horizontalCenter; 
        }

        font {
            pixelSize: parent.height * .28;
            letterSpacing: -0.3;
            
        }
    }
            buttons: [
                { title: '筛选', key: theme.buttonGuide.accept, square: false, sigValue: 'accept' },
                { title: '返回', key: theme.buttonGuide.cancel, square: false, sigValue: 'cancel' },
				{ title: '清除', key: theme.buttonGuide.details, square: false, sigValue: 'filter' },
                { title: '清除', key: theme.buttonGuide.filters, square: false, sigValue: 'clear' },
            ];

            onFooterButtonClicked: {
                if (sigValue === 'accept') onAcceptPressed();
                if (sigValue === 'cancel') onCancelPressed();
				if (sigValue === 'filter')  onClearPressed();
                if (sigValue === 'clear')  onClearPressed();
            }
        }
    }
}
