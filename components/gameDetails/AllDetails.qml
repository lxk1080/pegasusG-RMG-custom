import QtQuick 2.15
import QtGraphicalEffects 1.12

import '../media' as Media

Item {
    property alias video: gameDetailsVideo;
	property alias flick: flickable;

    // get rid of newlines for the short description
    // also some weird kerning on periods and commas for some reason
    property var introDescText: {
        if (currentGame === null) return '';

        return currentGame.description
            // .replace(/\n/g, ' ')
            // .replace(/ {2,}/g, ' ')
            // .replace(/\. {1,}/g, '.  ')
            // .replace(/, {1,}/g, ',  ');
    }
    

	
    property var hasMoreButton: {
        if (currentGame === null) return false;
        if (currentGame.description) return true;
        return false;
    }

    property string imgSrc: {
        if (currentGame === null) return '';
        return currentGame.assets.screenshot;
    }

    Component.onCompleted: {
        gameDetailsVideo.switchVideo();
        settings.addCallback('gameDetailsVideo', function () {
            gameDetailsVideo.switchVideo();
        });
    }

    GameMetadata {
        width: parent.width* 3/ 5 - 10;
        pixelSize: parent.height * .055;

        anchors {
            top: parent.top;
            topMargin: 25;
            bottom: detailsDivider.top;
            bottomMargin: parent.height * .035;
            left: parent.left;
            leftMargin: 25;
        }
    }



    Media.GameImage2 {
        id: gameDetailsScreenshot;

        width: parent.width *2/ 5;
        height: parent.height * .6;
        x: parent.width* 3/5 //+vpx(10);
		y:-vpx(20)
        imageSource: currentGame.assets.boxFront;
    }

    Media.GameVideo2 {
        id: gameDetailsVideo;

        width: parent.width *2/ 5;
        height: parent.height * .6;
        x: parent.width* 3/ 5//+vpx(10);
		y:-vpx(20)
        settingKey: 'gameDetailsVideo';
        validView: 'gameDetails';

        onVideoToggled: {
            gameDetailsScreenshot.videoPlaying = videoPlaying;
        }
    }

    //Text {
       // text: gameData.ratingText;
       // color: theme.current.detailsColor;
       // opacity: 0.5;
       // width: parent.width / 2;
       // height: 0;
       // x: parent.width / 2;
       // verticalAlignment: Text.AlignBottom;
       // horizontalAlignment: Text.AlignHCenter;

       // font {
       //     family: glyphs.name;
       //     pixelSize: parent.height * .04;
       // }
   // }

    Rectangle {
        id: detailsDivider;

        height: 1;
        color: theme.current.dividerColor;

        anchors {
            top: gameDetailsScreenshot.bottom;
			topMargin: -vpx(30);
            left: parent.left;
            leftMargin: 22;
            right: parent.right;
            rightMargin: 22;
        }
    }

 

    Rectangle {
	   id: detail
      width: parent.width
	  anchors{
	  top: detailsDivider.bottom;
	  bottom: parent.bottom;
	  //bottomMargin: vpx(30);
	  }
	  color: 'transparent'
	  z:1
	  
 
	  
	  
	Flickable {
        id: flickable
        width: parent.width
        flickableDirection: Flickable.VerticalFlick
        anchors {
            top: parent.top;
            topMargin: 10;
            bottom:parent.bottom;
            bottomMargin: 10;
            left: parent.left;
            leftMargin: 30;
            right: parent.right;
            rightMargin: 30;
            }
		contentWidth: parent.width
		contentHeight: fullDesc.height
		clip: true
		boundsBehavior: Flickable.DragAndOvershootBounds
		//boundsBehavior: Flickable.DragOverBounds
	    //boundsBehavior: Flickable.StopAtBounds
       // bottomMargin: 600
       // leftMargin: -5
       // rightMargin: -5
       // topMargin: -10
        Text {
            id: fullDesc
            color: theme.current.detailsColor;
            text: introDescText;
            width: flickable.width
            wrapMode: Text.WrapAnywhere
            horizontalAlignment: Text.AlignJustify
			//style: Text.Outline;styleColor:"#555555"
            font {
                pixelSize: Math.min(parent.parent.height * .09 * theme.fontScale,parent.width*.05)//parent.parent.height * .12 * theme.fontScale;
				
                family: subtitleFont.name
            }
        }
    }

}	

    Text {
        id: introDesc;

        text: introDescText;
        wrapMode: Text.WordWrap;
        horizontalAlignment: Text.AlignJustify;
        verticalAlignment: Text.AlignVCenter;
        color: theme.current.detailsColor;
        lineHeight: 1.3;
       elide: Text.ElideRight;

        font {
            pixelSize: parent.height * .04 * theme.fontScale;
            letterSpacing: -0.1;
           //bold: true;
			family: subtitleFont.name;
        }

        anchors {
          top: detailsDivider.bottom;
           topMargin: 10;
           bottom: parent.bottom;
           bottomMargin: 10;
           left: parent.left;
            leftMargin: 30;
           right: parent.right;
           rightMargin: 30;
        }

        //MouseArea {
           // anchors.fill: parent;

            //onClicked: {
           //     detailsButtonClicked('more');
           //}
       // }
	   opacity:0
    }

    //MoreButton {
       // pixelSize: parent.height * .04 * theme.fontScale;
//buttonText: '展开'

        //anchors {
         //   right: parent.right;
         //   rightMargin: 30;
         //   bottom: introDesc.bottom;
         //   bottomMargin: parent.height * .01;
        //}
    //}
}
