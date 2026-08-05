import QtQuick 2.15
import QtGraphicalEffects 1.12
import '../gameList'

Rectangle {
    id: footer;

    property var buttons: [];
    property int index;
    property int total;
	property int indexAll;
    property int totalAll;
    property int currentGI : currentGameIndex+1;
	
	
	

    signal footerButtonClicked(string sigValue);

    height: vpx(60)//root.height * .115 * theme.fontScale;
    color: theme.current.bgColor;

    anchors {
        left: parent.left;
        right: parent.right;
        bottom: parent.bottom;
    }

    // divider
    Rectangle {
        height: 1;
        color: theme.current.dividerColor;

        anchors {
            top: parent.top;
            left: parent.left;
            leftMargin: 22;
            right: parent.right;
            rightMargin: 22;
        }
    }

	Image{
		id: pegasusLogo
		source: '../../../Resource/Background_image1/Pegasus G.png';
		// sourceSize { width: 256; height:256 }
		// smooth: true
        // antialiasing: true
		mipmap: true
		fillMode: Image.PreserveAspectFit;
        horizontalAlignment: Image.AlignLeft;
		// visible: currentView != 'sorting'
		// width: parent.width * .05;
        height: parent.height * .8;
		
		anchors {
            verticalCenter: parent.verticalCenter;
            left: parent.left;
            leftMargin: 14;
        }
	}
	
	Text {
		id: pegaLU
        text: '跳坑者联盟'
        color: theme.current.buttonLabelColor
		horizontalAlignment: Text.AlignRight;
		// visible: currentView != 'sorting'
        opacity: 1;
		font.family: subtitleFont.name
        anchors {	
            left:pegasusLogo.right; leftMargin: 10;
			top:parent.top
			topMargin:parent.height * .07
			// verticalCenter: parent.verticalCenter; 
        }

        font {
            pixelSize: parent.height * .30;
            letterSpacing: -0.3;
            
        }
    }
	
	Text {
		id: pegaLD
        text: 'PegasusG'
        color: theme.current.buttonLabelColor
		horizontalAlignment: Text.AlignRight;
		// visible: currentView != 'sorting'
        opacity: 1;
		font.family: subtitleFont.name
        anchors {	
            // left:pegasusLogo.right;leftMargin: 14;
			top:pegaLU.bottom
			topMargin: -parent.height * .1
			// topMargin:parent.height * .18
			horizontalCenter: pegaLU.horizontalCenter; 
        }

        font {
            pixelSize: parent.height * .315;
            letterSpacing: -0.3;
            
        }
    }
	
	
    // button guide
    Row {
        spacing: parent.height * .27;

        anchors {
            verticalCenter: parent.verticalCenter;
            left: pegaLU.right//currentView != 'sorting' ? pegaLU.right : parent.left;
            leftMargin: 24;
        }

        Repeater {
            model: buttons;

            // each individual button
            ButtonLegend {
                title: modelData.title;
                key: modelData.key;
                square: modelData.square;

                MouseArea {
                    anchors.fill: parent;
                    onClicked: {
                        footerButtonClicked(modelData.sigValue);
                    }
                }
            }
        }
    }
	
	Text {
		
		visible: currentView == 'collectionList' ? true : false
        text: '游戏:'+ allCollections[currentCollectionIndex].games.count +'  '+'合集:'+indexAll + '/' + totalAll
        color: theme.current.footerCountColor;
		horizontalAlignment: Text.AlignRight;
		// lineHeight:0.8;
        opacity: 1;
        // style: Text.Outline;styleColor:"black"
		font.family: subtitleFont.name
        anchors {
		
          
			// bottom:parent.bottom;bottomMargin:parent.height*.05
            right:parent.right;rightMargin: 26;
			verticalCenter: parent.verticalCenter;
			// verticalCenterOffset: -parent.height*0.05
            
        }

        font {
            pixelSize: parent.height * .42;
            letterSpacing: -0.3;
            
        }
    }
	
	Text {
		visible: false
        text: allCollections[currentCollectionIndex].games.count > 0 ? currentGI +'/'+ allCollections[currentCollectionIndex].games.count: '无'
        color: theme.current.footerCountColor;
        opacity: 1;
		
        // style: Text.Outline;styleColor:"black"
		font.family: subtitleFont.name
        anchors {
		
          
			// bottom:parent.bottom;bottomMargin:parent.height*.05
            right:parent.right;rightMargin: 26;
			verticalCenter: parent.verticalCenter;
            
        }

        font {
            pixelSize: parent.height * .42;
            letterSpacing: -0.3;
            
        }
    }
	

    Text {
		
		id: countm
        text: total > 0 ? '游戏:'+ index +'/'+allCollections[currentCollectionIndex].games.count +'  '+'合集:'+indexAll + '/' + totalAll : '游戏:'+'0'+'  '+'合集:'+indexAll + '/' + totalAll;
        color: theme.current.footerCountColor;
        visible:  currentView == 'gameList' ? true : false

        anchors {
            right: parent.right;
            rightMargin: 26;
            verticalCenter: parent.verticalCenter;
        }

        font {
            pixelSize: parent.height * .42;
            letterSpacing: -0.3;
           // bold: true;
	family: subtitleFont.name;
        }
    }
}
