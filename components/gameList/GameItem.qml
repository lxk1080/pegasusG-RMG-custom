import QtQuick 2.15
import '../settings' as Settings

Item {
    property bool showFavorite: {
        return favorite
            && currentCollection.shortName !== 'favorites'
            && onlyFavorites === false;
    }

    MouseArea {
        anchors.fill: parent;

        onClicked: {
            if (gamesListView.currentIndex === index) {
                onAcceptPressed();
            } else {
                const updated = updateGameIndex(index);
                if (updated) { sounds.nav(); }
            }
        }

        onPressAndHold: {
            if (gamesListView.currentIndex === index) {
                onFiltersPressed();
            } else {
                const updated = updateGameIndex(index);
                if (updated) { sounds.nav(); }
            }
        }
    }

    Text {
        id: gameTitle;
        text: title;
        verticalAlignment: Text.AlignVCenter;
        elide: Text.ElideRight;
        color: gamesListView.currentIndex === index
            ? theme.current.focusTextColor
            : theme.current.blurTextColor;
        height: parent.height;

        font {
            family: subtitleFont.name;
            pixelSize: parent.height * .49;
            letterSpacing: -0.3;
        }
		leftPadding: vpx(20)
		rightPadding: gameListLG.visible ? vpx(110) : vpx(10);
        anchors {
            left: parent.left;
            leftMargin: 12;
            right: parent.right;
        }
    }
	
			Image {
			id: gameListLG
			visible: settings.get('gameListLogo')
			source: assets.logo
			sourceSize { width: 256; height: 256 }
            fillMode: Image.PreserveAspectFit
			// height: parent.height*.4
			width: parent.width*.215
            // horizontalAlignment: Image.AlignLeft
			
			anchors {
				verticalCenter: parent.verticalCenter;
				// bottom: parent.bottom;
				// bottomMargin: 7
				right: parent.right;
				// leftMargin: 15;
				}
		  }

    Text {
        visible: showFavorite;
        text: glyphs.favorite;
        verticalAlignment: Text.AlignVCenter;
        color: "#FF6B6B";
        height: parent.height;

        font {
            family: glyphs.name;
            pixelSize: parent.height * .3;
        }

        anchors {
            verticalCenter: parent.verticalCenter;
			left:parent.left;
			leftMargin: 8;
            // right: parent.right;
            // rightMargin: 15;
        }
    }
	

}
