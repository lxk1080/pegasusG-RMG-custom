import QtQuick 2.15
import QtGraphicalEffects 1.12
// 不知道功能 import "qrc:/qmlutils" as PegasusUtils
import '../media' as Media

Item {
    property var blurSource;

    function resetFlickable() {
        flickable.contentY = -flickable.topMargin;
    }

    function scrollUp() {
        flickable.contentY = Math.max(  -flickable.topMargin,
            flickable.contentY - fullDesc.font.pixelSize,        );
    }

    function scrollDown() {
        flickable.contentY = Math.min(  flickable.contentY + fullDesc.font.pixelSize,
            flickable.contentHeight - root.height + flickable.bottomMargin,        );
    }

	function upPressed() {
		if(flickable.contentHeight > flickable.height){
		flickable.contentY = flickable.contentY-10;
		if(flickable.contentY < -flickable.topMargin) {
		flickable.contentY = -flickable.topMargin
		}
	}
    }
	
	function downPressed() {
		if(flickable.contentHeight > flickable.height){
		flickable.contentY = flickable.contentY+10;
		if(flickable.contentY > flickable.contentHeight-flickable.height+flickable.bottomMargin){
		flickable.contentY = flickable.contentHeight-flickable.height+flickable.bottomMargin
		}
	}
    }

    // solves some kerning issues with period and commas
    property var descText: {
 //       if (currentGame === null) return '';

        return currentGame.description
            // .replace(/\. {1,}/g, '.  ')
            // .replace(/, {1,}/g, ',  ');
    }

    // background to lighten or darken the blur effect, since it's translucent
    Rectangle {
        color: theme.current.bgColor;
        anchors.fill: parent;
    }

    FastBlur {
        width: root.width;
        height: root.height;
        radius: 80;
        opacity: .4;
        source: blurSource;
        cached: true;
    }
	

	FocusScope {
	
		anchors.fill: parent
		
		Rectangle {
			id: detailsHead
			color: theme.current.bgColor;
			height:parent.height*0.05
			z: 1
			anchors {
				left: parent.left
				right: parent.right
				top: parent.top
			}
		
			MoreButton {
			
				id:moreButton
				pixelSize: parent.height*.6;
				
				buttonText: '收起'

				anchors {
					right: parent.right;
					rightMargin: 30;
					verticalCenter:parent.verticalCenter
				}

				MouseArea {
					anchors.fill: parent;

					onClicked: {
						onDetailsPressed();
					}
				}
			}
		}
		
		Rectangle {
			id: detailsDivider;

			height: 1;
			color: theme.current.dividerColor;

			anchors {
				top: detailsHead.bottom;
				left: parent.left;
				leftMargin: 22;
				right: parent.right;
				rightMargin: 22;
			}
		}
	
		Flickable {
			id: flickable;

			contentWidth: fullDesc.width;
			contentHeight: fullDesc.height;
			flickableDirection: Flickable.VerticalFlick;
			anchors.fill: parent;
			anchors.top: footer.bottom;
			clip: true;
			bottomMargin: 40;
			leftMargin: 40;
			rightMargin: 40;
			topMargin: 80;
			
			

			Text {
				id: fullDesc;

				width: root.width - flickable.leftMargin - flickable.rightMargin;
				text: descText;
				wrapMode: Text.WordWrap;
				lineHeight: 1.8;
				color: theme.current.detailsColor;
				horizontalAlignment: Text.AlignJustify;

				font {
					pixelSize: root.height * .042 * theme.fontScale;
					letterSpacing: -0.35;
					//bold: true;
					family: subtitleFont.name;
				}
			}
		}
	}
}
