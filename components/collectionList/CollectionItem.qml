import QtQuick 2.15
import QtGraphicalEffects 1.12

import '../footer' as Footer
import '../header' as Header


Item {
    property bool useSecondBackground: settings.get('secondBackgroundStyle');
    property bool useBuiltinCollectionBackground: [ '全部游戏', '最近游戏', '收藏游戏' ].indexOf(modelData.name) !== -1;
    property bool useLegacyBackground: !useSecondBackground || useBuiltinCollectionBackground;

    Component.onCompleted: {
        settings.addCallback('secondBackgroundStyle', function (enabled) {
            useSecondBackground = enabled;
        });
    }

    MouseArea {
        anchors.fill: parent;
        onClicked: {
            collectionListView.currentIndex = index;
            onAcceptPressed();
        }
    }

    // Device artwork or the legacy full-frame collection artwork.
    Image {
    	//source: '../../assets/images/stripe.png';
        source: '../../../Resource/'
            + (useLegacyBackground ? 'Background_image1/' : 'Background_image2/')
            + collectionData.getImage(modelData.name)
            + (useLegacyBackground ? '.jpg' : '.png');
        width: parent.width;
        height: parent.height;
        fillMode: useLegacyBackground
            ? Image.PreserveAspectCrop
            : Image.PreserveAspectFit;
        horizontalAlignment: Image.AlignHCenter;
        anchors {
            centerIn: parent;
        }
    }

    DropShadow {
        source: title;
        verticalOffset: 10;
        color: '#30000000';
        radius: 20;
        samples: 41;
        cached: true;
        //anchors.fill: title;
    }


    // Image {
        // source: '../../../Resource/Logo1/' + collectionData.getImage(modelData.name) + '.png';
		// fillMode: Image.PreserveAspectFit;
        // horizontalAlignment: Image.AlignLeft;
		// width: parent.width * .3;
        // height: parent.height * .4;
		
        // anchors {
			// top:parent.top
			// topMargin: -vpx(80)
            // verticalCenter: parent.verticalCenter;
			// verticalCenterOffset: -parent.height*0.02
            // left: parent.left;
            // leftMargin : 0;

        // }
    // }



    // Text {
        // text: modelData.games.count + ' GAMES';
        // color: "#ececec"
        // opacity: 1;
        // style: Text.Outline;styleColor:"black"
		// font.family: subtitleFont.name
        // anchors {
		
          
			// bottom:parent.bottom;bottomMargin:parent.height*.05
            // right: parent.right;rightMargin: 30;
            
        // }

        // font {
            // pixelSize: root.height * .035;
            // letterSpacing: -0.3;
            
        // }
    // }

    // Text {
        // text: collectionData.getVendorYear(modelData.name);
        // color: theme.current.titleColor;
        // opacity: 1;

        // font {
            // capitalization: Font.AllUppercase;
            // pixelSize: root.height * 0.25;
            // letterSpacing: 1.3;
            // bold: true;
			// family: subtitleFont.name;
        // }

        // anchors {
            // left: parent.left;
            // leftMargin: 30;
            // bottom: title.top;
        // }
    // }

    Image {
        id: device;

        source: '../../../Resource/Logo2/' + collectionData.getImage(modelData.name) + '.png';
		mipmap: true
		width: parent.width * .2;
        height: parent.height * .4;
        fillMode: Image.PreserveAspectFit;
        horizontalAlignment: Image.AlignRight;
		verticalAlignment: Image.AlignBottom
        asynchronous: true;

        anchors {
            // verticalCenter: parent.verticalCenter;
            // verticalCenterOffset: parent.height*0.25;
			bottom: parent.bottom
			bottomMargin:vpx(40)
			// bottomMargin: -vpx(40)
            right: parent.right;
			// rightMargin: vpx(20)
            //rightMargin : 0;
        }

        // states: [
            // State {
                // name: 'active';
                // when: collectionListView.currentIndex === index;
                // PropertyChanges { target: device; anchors.rightMargin: 20.0; }
            // },

            // State {
                // name: 'inactiveRight';
                // when: collectionListView.currentIndex < index;
                // PropertyChanges { target: device; anchors.rightMargin: 20.0; }
            // },

            // State {
                // name: 'inactiveLeft';
                // when: collectionListView.currentIndex > index;
                // PropertyChanges { target: device; anchors.rightMargin: 20.0; }
            // }
        // ]

        transitions: Transition {
            NumberAnimation {
                properties: 'anchors.rightMargin';
                easing.type: Easing.InOutCubic;
                duration: 325;
            }
        }
    }
	


    // DropShadow {
    //     source: device;
    //     verticalOffset: 10;
    //     color: '#30000000';
    //     radius: 20;
    //     samples: 41;
    //     cached: true;
    //     anchors.fill: device;
    // }
}
