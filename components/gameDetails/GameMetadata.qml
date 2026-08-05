import QtQuick 2.15
import QtGraphicalEffects 1.12

Item {
    property double pixelSize;

    property double actionButtonHeight: {
        return Math.min(
            actionButtons.height * 0.7,
            root.height * 0.1,
        );
    }

    property string genreText: {
        if (currentGame.genreList.length === 0) { return null; }

        const genre = currentGame.genreList[0] ?? '';
        const split = genre.split(',');

        if (split[0].length === 0) { return null; }

        return split[0];
    }

    property string releaseDateText: {
        if (!currentGame.releaseYear) { return ''; }

        return 'Released ' + currentGame.releaseYear;
    }

    property string developedByText: {
        if (currentGame.developer) {
            return  currentGame.developer;
        }

        if (currentGame.publisher) {
            return currentGame.publisher;
        }

        return '';
    }

    property var metadataText: {
        return [genreText, releaseDateText, developedByText]
            .filter(v => { return v !== null })
            .filter(v => { return v !== '' });
    }

    property string favoriteGlyph: {
        if (currentGame.favorite) return glyphs.favorite;
        return glyphs.unfavorite;
    }
	
	Image {
		id: detailLogo
        source: if(currentShortName == "favorites"){return '../../../Resource/Logo1/收藏游戏.png';}
		else if(currentShortName == "recents"){return '../../../Resource/Logo1/最近游戏.png';}
		else if(currentShortName == "allgames"){return '../../../Resource/Logo1/全部游戏.png';}
		else {return '../../../Resource/Logo1/' + currentShortName + '.png';}
		fillMode: Image.PreserveAspectFit;
        horizontalAlignment: Image.AlignLeft;
		// width: parent.width*0.2;
        height: parent.height*0.25;
		opacity: 0.8
		visible: currentView == 'gameDetails' ? true : false;
        anchors {
            // verticalCenter: parent.verticalCenter;
			// verticalCenterOffset: parent.height*0.2
			top: parent.top;
			topMargin: -vpx(10)
            left: parent.left;
            // leftMargin : vpx(5);
        }
		Text {
            text: title.length > 0
            ? title
            : currentCollection.name;
			// style: Text.Outline; styleColor: "black"
            color: shadeColor2;
            // anchors.fill: parent
            // horizontalAlignment: Text.AlignHCenter
            // verticalAlignment: Text.AlignVCenter
            elide: Text.ElideRight
            visible: parent.status != Image.Ready
			 anchors {
            left: parent.left;
            leftMargin: 32;
            verticalCenter: parent.verticalCenter;
			}
            // font.bold: true
            // font.capitalization: Font.AllUppercase
            font.pixelSize: parent.height * .43
            font.family: subtitleFont.name
        }
    }

    // Text {
        // id: title;
        // width: parent.width;
        // wrapMode: Text.WordWrap;
        // maximumLineCount: 2;
        // text: currentCollection.name + '-' +currentGame.title;
        // lineHeight: 1.1;
        // color: theme.current.detailsColor;

        // font {
            // pixelSize: parent.height*.12;
            // letterSpacing: -0.35;
			// family: subtitleFont.name;
        // }

        // anchors {
            // left: detailLogo.right;
            // top: parent.top;
        // }
    // }

    Column {
        id: metadata;

        spacing: 8;
        width: parent.width;

        anchors {
            top: detailLogo.bottom;
            topMargin: vpx(2);
			left: parent.left;
			leftMargin: vpx(10)
        }

        Repeater {
            model: metadataText;

            Text {
                text: modelData;
                color: theme.current.detailsColor;
                opacity: 1;
                width: parent.width;
				wrapMode: Text.WordWrap;
                //elide: Text.ElideRight
                //maximumLineCount: 1;

                font {
                    pixelSize: pixelSize;
                    letterSpacing: -0.35;
                    //bold: true;
					family: subtitleFont.name;
                }
            }
        }
    }

    Row {
        id: actionButtons;

        spacing: parent.width * .075;
        width: parent.width;

        anchors {
            top: metadata.bottom;
            topMargin: pixelSize;
            bottom: parent.bottom;
        }

        ActionButton {
            id: playButton;

            glyph: glyphs.play;
            width: parent.width / 3;
            height: actionButtonHeight*.8;
            // anchors.verticalCenter: parent.verticalCenter;
		anchors {
            // top: metadata.bottom;
            // topMargin: pixelSize;
            bottom: parent.bottom;
        }

            MouseArea {
                anchors.fill: parent;

                onClicked: {
                    currentGame.launch();// buttonClicked('play');
                }
            }
        }

        ActionButton {
            id: favoriteButton;

            glyph: favoriteGlyph;
            width: parent.width / 3;
            height: actionButtonHeight*.8;
            // anchors.verticalCenter: parent.verticalCenter;
		anchors {
            // top: metadata.bottom;
            // topMargin: pixelSize;
            bottom: parent.bottom;
        }


            MouseArea {
                anchors.fill: parent;

                onClicked: {
                    onFiltersPressed();// buttonClicked('favorite');
                }
            }
        }
    }
}
