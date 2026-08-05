import QtQuick 2.15

import '../media' as Media

Item {
    property alias video: gameListVideo;
    property alias gamesListView: gamesListView;
    property var sortingFont: global.fonts.sans;
    property alias letter: skipLetter.letter;
	property alias flick: flickable;

    property double itemHeight: {
        return gamesListView.height * .12 * theme.fontScale;
    }

    property string imgSrc: {
        if (currentGame === null) return '';
        return currentGame.assets.boxFront;
    }
	
	property string imgLogo: {
        if (currentGame === null) return '';
        return currentGame.assets.logo;
    }

    property var sortingText: {
        if (sortKey === 'release') {
            sortingFont = global.fonts.sans;
            return gameData.releaseDateText;
        }

        if (sortKey === 'rating') {
            sortingFont = glyphs.name;
            return gameData.ratingText;
        }

        sortingFont = global.fonts.sans;
        return gameData.lastPlayedText;
    }

    property string noGameText: {
        if (nameFilter != '') {
            return '未找到包含' + ' " ' + nameFilter + ' " '+'的游戏';
        }

        return '当前列表\n没有游戏';
    }

    Component.onCompleted: {
        gamesListView.currentIndex = currentGameIndex;
        gamesListView.positionViewAtIndex(currentGameIndex, ListView.Center);
        settings.addCallback('gameListVideo', function () {
            gameListVideo.switchVideo();
        });
    }

    Text {
        visible: currentGameList.count === 0;
        text: noGameText;
        anchors.centerIn: parent;
        color: theme.current.blurTextColor;
        opacity: 0.5;
		font.family: subtitleFont.name
        font {
            pixelSize: parent.height * .065;
            letterSpacing: -0.3;
            //bold: true;
        }
    }

    ListView {
        id: gamesListView;
        model: currentGameList;
        delegate: lvGameDelegate;
        width: (parent.width* 2/ 5); // 20 is left margin
        height: parent.height - 24;
        highlightMoveDuration: 0;
        preferredHighlightBegin: itemHeight - 12; // height of an item minus top margin
        // preferredHighlightBegin: height*.5; // height of an item minus top margin
        preferredHighlightEnd: parent.height - (itemHeight + 12); // height of an item plus bottom margin
        // preferredHighlightEnd: height*.5; // height of an item plus bottom margin
        highlightRangeMode: ListView.ApplyRange;
		clip: true
        anchors {
            left: parent.left;
            leftMargin: 20;
            top: parent.top;
            topMargin: 12;
            bottom: parent.bottom;
            bottomMargin: 12;
        }

        highlight: Rectangle {
            color: collectionData.getColor(currentShortName);
            opacity: theme.current.bgOpacity;
            radius: 8;
            width: gamesListView.width;
        }

        onCurrentIndexChanged: {
            gameListVideo.switchVideo();
        }
    }

    Component {
        id: lvGameDelegate;

        GameItem {
            width: gamesListView.width;
            height: itemHeight*1;
        }
		
    }

    SkipLetter {
        id: skipLetter;

        anchors {
            verticalCenter: gamesListView.verticalCenter;
            horizontalCenter: gamesListView.horizontalCenter;
        }
    }
	
	// Media.GameImage3 {
        // id: gameListLogo;

        // width: parent.width* 3/ 5;
        // height: parent.height;
        // x: parent.width* 2/ 5 + vpx(30);
        // imageSource: imgLogo;
		
    // }

    Media.GameImage {
        id: gameListBoxart;

        width: parent.width* 1/ 5;
        height: parent.height*.7;
        // x: parent.width* 2/ 5+vpx(30);
        x: gamesListView.width+vpx(40);
        imageSource: imgSrc;
		
    }

    Media.GameVideo {
        id: gameListVideo;

        width: parent.width* 2/ 5-vpx(75);
        height: parent.height*.7;
        x: parent.width* 3/ 5+ vpx(45);
        settingKey: 'gameListVideo';
        validView: 'gameList';
		
        onVideoToggled: {
            gameListBoxart.videoPlaying = videoPlaying;
        }
    }
	
	Flickable {
        id: flickable
        width: parent.width*3/5
        flickableDirection: Flickable.VerticalFlick
		visible: currentGameList.count == 0 ? false : true;
		x: gamesListView.width+vpx(40);
        anchors {
            top: parent.top;
            topMargin: parent.height*.5+15;
            bottom:parent.bottom;
            bottomMargin: 10;
            left: gamesListView.right;
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
            text: currentCollection.shortName+'--'+currentGame.developer+'\n'+currentGame.description;
            width: flickable.width
			font.capitalization: Font.AllUppercase
            wrapMode: Text.WrapAnywhere
            horizontalAlignment: Text.AlignJustify
			//style: Text.Outline;styleColor:"#555555"
            font {
                pixelSize: Math.min(parent.parent.height * .12 * theme.fontScale,parent.width*.08)//parent.parent.height * .12 * theme.fontScale;
                family: subtitleFont.name
            }
        }
    }

    Text {
        text: sortingText;
        color: theme.current.detailsColor;
		visible:false
        opacity: 1;
        width: parent.width* 2/ 3;
        height: parent.height * .95;
        x: parent.width* 1/ 3;
        verticalAlignment: Text.AlignBottom;
        horizontalAlignment: Text.AlignHCenter;
// font.family: subtitleFont.name
        font {
            family: subtitleFont.name;
            pixelSize: parent.height * .04;
            //bold: true;
        }
    }
}
