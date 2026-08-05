import QtQuick 2.15
import QtGraphicalEffects 1.12

import '../footer' as Footer
import '../header' as Header

Item {
    anchors.fill: parent;
    property bool fullDescriptionShowing: false;
    property bool favoritesChanged: false;
//	property int currentGameIndex

    function onCancelPressed() {
        if (favoritesChanged === true) {
            updateGameIndex(currentGameIndex, true);
            favoritesChanged = false;
        }

        currentView = 'gameList';
        sounds.back();
    }

    function onAcceptPressed() {
        sounds.launch();
        currentGame.launch();
    }

    function onFiltersPressed() {
        currentGame.favorite = !currentGame.favorite;
        favoritesChanged = true;
        sounds.nav();
    }


//    function onDetailsPressed() {
//       if (!currentGame.description) return;
//        fullDescriptionShowing = true;
//        fullDescription.anchors.topMargin = 0;
//        sounds.forward();
//    }


    function onDetailsPressed() {
	
        fullDescriptionShowing = !fullDescriptionShowing;
		
        if (fullDescriptionShowing) {
            fullDescription.anchors.topMargin = 0;
            fullDescription.resetallDetails.flick();
            sounds.back();
        } else {
            fullDescription.anchors.topMargin = root.height;
            sounds.forward();
        }
    }

//unused
    function hideFullDescription() {
        fullDescriptionShowing = false;
        fullDescription.anchors.topMargin = root.height;
        fullDescription.resetallDetails.flick();
        sounds.back();
    }

//unused
    function detailsButtonClicked(button) {
        switch (button) {
            case 'play':
                onAcceptPressed();
                break;

            case 'favorite':
                onFiltersPressed();
                break;

            case 'more':
                onDetailsPressed();
                break;

            case 'less':
                hideFullDescription();
                break;
        }
    }



    Keys.onUpPressed: {
        if (fullDescriptionShowing) {
            fullDescription.scrollUp();
            return;
        }

        event.accepted = true;
        const updated = updateGameIndex(currentGameIndex - 1);
        if (updated) {
            sounds.nav();
            allDetails.video.switchVideo();
			allDetails.flick.contentY = -allDetails.flick.topMargin;
        }
    }

    Keys.onDownPressed: {
        if (fullDescriptionShowing) {
            fullDescription.scrollDown();
            return;
        }

        event.accepted = true;
        const updated = updateGameIndex(currentGameIndex + 1);
        if (updated) {
            sounds.nav();
            allDetails.video.switchVideo();
			allDetails.flick.contentY = -allDetails.flick.topMargin;
        }
    }
	
	
	Keys.onLeftPressed: {
		if(allDetails.flick.contentHeight > allDetails.flick.height){
			allDetails.flick.contentY = allDetails.flick.contentY-vpx(45);
			if(allDetails.flick.contentY < -allDetails.flick.topMargin) {
				allDetails.flick.contentY = -allDetails.flick.topMargin
			}
		}
    }
	
	Keys.onRightPressed:{
		if(allDetails.flick.contentHeight > allDetails.flick.height){
			allDetails.flick.contentY = allDetails.flick.contentY+vpx(45);
			if(allDetails.flick.contentY > allDetails.flick.contentHeight-allDetails.flick.height+allDetails.flick.bottomMargin){
				allDetails.flick.contentY = allDetails.flick.contentHeight-allDetails.flick.height+allDetails.flick.bottomMargin
			}
		}
    }

    Keys.onPressed: {
        if (fullDescriptionShowing) {
            event.accepted = true;
            hideFullDescription();
            return;
        }

        if (api.keys.isCancel(event)) {
            event.accepted = true;
            onCancelPressed();
        }

        if (api.keys.isAccept(event)&& !event.isAutoRepeat) {
            event.accepted = true;
            onAcceptPressed();
        }

        if (api.keys.isDetails(event)) {
            event.accepted = true;
            onCancelPressed();
        }

        if (api.keys.isFilters(event)) {
            event.accepted = true;
            onFiltersPressed();
        }
		
		        // L1
        if (api.keys.isPrevPage(event)) {
			event.accepted = true;
			if (currentGameIndex - 10 < 0) {
			const updated = updateGameIndex(0);
			return;
			}
            const updated = updateGameIndex(currentGameIndex - 10);
            if (updated) { sounds.nav(); }
		    allDetails.video.switchVideo();
		    allDetails.flick.contentY = -allDetails.flick.topMargin;
            //event.accepted = true;
            //if (currentGameIndex === 0) return;

            //let newIndex = currentGameIndex - 1;
            //const oldGame = currentCollection.games.get(newIndex);
            //const oldLetter = oldGame.title[0].toLowerCase();

            //while (newIndex > 0) {
                //const newGame = currentCollection.games.get(newIndex - 1);
               // const newLetter = newGame.title[0].toLowerCase();

                //if (newLetter !== oldLetter) {
                //    break;
                //}

               // newIndex--;
            //}

            //const updated = updateGameIndex(newIndex);
           // if (updated) { sounds.nav(); }
        }
		
		        // R1
        if (api.keys.isNextPage(event)) {
            event.accepted = true;
            const updated = updateGameIndex(currentGameIndex + 10);
            if (updated) { sounds.nav(); }
			allDetails.video.switchVideo();
			allDetails.flick.contentY = -allDetails.flick.topMargin;
			//event.accepted = true;
            //if (currentGameIndex === currentCollection.games.count - 1) return;

            //const oldLetter = currentGame.title[0].toLowerCase();
            //let newIndex = currentGameIndex;

            //while (newIndex < currentCollection.games.count - 1) {
               // newIndex++;
               // const newGame = currentCollection.games.get(newIndex);
                //const newLetter = newGame.title[0].toLowerCase();

               // if (newLetter !== oldLetter) {
                   // break;
                //}
            //}

           // const updated = updateGameIndex(newIndex);
            //if (updated) { sounds.nav(); }
        }

        // L2
        if (api.keys.isPageUp(event)) {
            event.accepted = true;
			if (currentGameIndex - 30 < 0) {
			const updated = updateGameIndex(0);
			return;
			}
            const updated = updateGameIndex(currentGameIndex - 30);
            if (updated) { sounds.nav(); }
		    allDetails.video.switchVideo();
			allDetails.flick.contentY = -allDetails.flick.topMargin;
            //event.accepted = true;
            //const updated = updateCollectionIndex(currentCollectionIndex - 1);
            //if (updated) { sounds.nav(); }
        }

        // R2
        if (api.keys.isPageDown(event)) {
		    event.accepted = true;

            const updated = updateGameIndex(currentGameIndex + 30);
            if (updated) { sounds.nav(); }
		    allDetails.video.switchVideo();
			allDetails.flick.contentY = -allDetails.flick.topMargin;
            //event.accepted = true;
            //const updated = updateCollectionIndex(currentCollectionIndex + 1);
            //if (updated) { sounds.nav(); }
        }
		
    }

    Item {
        id: allDetailsBlur;

        anchors.fill: parent;

        Rectangle {
            color: theme.current.bgColor;
            anchors.fill: parent;
        }

        AllDetails {
            id: allDetails;

            anchors {
                top: parent.top;
                bottom: detailsFooter.top;
                left: parent.left;
                right: parent.right;
            }

//currentGameIndex: root.currentGameIndex;

        }


        Footer.Component {
            id: detailsFooter;
            total: 0;

            buttons: [
                { title: '开始', key: theme.buttonGuide.accept, square: false, sigValue: 'accept' },
                { title: '返回', key: theme.buttonGuide.cancel, square: false, sigValue: 'cancel' },
				{ title: '收藏', key: theme.buttonGuide.details, square: false, sigValue: 'filters' },
                { title: '返回', key: theme.buttonGuide.filters, square: false, sigValue: 'details' },
            ];

            onFooterButtonClicked: {
                if (sigValue === 'accept') onAcceptPressed();
                if (sigValue === 'cancel') onCancelPressed();
                if (sigValue === 'filters') onFiltersPressed();
                if (sigValue === 'details') onCancelPressed();
            }
        }
    }

    //GameDescription {
        //id: fullDescription;

       // height: parent.height;
      //  width: parent.width;
      //  blurSource: allDetailsBlur;

      //  anchors {
       //     top: parent.top;
        //    topMargin: root.height;
        //    left: parent.left;
        //    right: parent.right;
       // }

       // Behavior on anchors.topMargin {
       //     PropertyAnimation { easing.type: Easing.OutCubic; duration: 200; }
      //  }
    //}
}
