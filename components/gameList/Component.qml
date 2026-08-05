import QtQuick 2.15
import QtMultimedia 5.15
import QtGraphicalEffects 1.12
import SortFilterProxyModel 0.2

import '../footer' as Footer
import '../header' as Header
import '../sorting' as Sorting

Item {
    anchors.fill: parent;
	property int collectionCount: allCollections.length;
	
    function updateIndex(newIndex) {
        gameScroll.gamesListView.currentIndex = newIndex;
		gameScroll.flick.contentY = -gameScroll.flick.topMargin
    }

    Keys.onUpPressed: {
        event.accepted = true;
        const updated = updateGameIndex(currentGameIndex - 1);
        if (updated) { sounds.nav(); }
    }

    Keys.onDownPressed: {
        event.accepted = true;
        const updated = updateGameIndex(currentGameIndex + 1);
        if (updated) { sounds.nav(); }
    }
	
	
	Keys.onLeftPressed: {
		if(gameScroll.flick.contentHeight > gameScroll.flick.height){
			gameScroll.flick.contentY = gameScroll.flick.contentY-vpx(30);
			if(gameScroll.flick.contentY < -gameScroll.flick.topMargin) {
				gameScroll.flick.contentY = -gameScroll.flick.topMargin
			}
		}
    }
	
	Keys.onRightPressed:{
		if(gameScroll.flick.contentHeight > gameScroll.flick.height){
			gameScroll.flick.contentY = gameScroll.flick.contentY+vpx(30);
			if(gameScroll.flick.contentY > gameScroll.flick.contentHeight-gameScroll.flick.height+gameScroll.flick.bottomMargin){
				gameScroll.flick.contentY = gameScroll.flick.contentHeight-gameScroll.flick.height+gameScroll.flick.bottomMargin
			}
		}
    }
	

    // Keys.onLeftPressed: {
        // event.accepted = true;
		
		// if ((currentCollectionIndex - 1) < 0)	{
		// const updated = updateCollectionIndex(collectionCount );updateSortedCollection();sounds.nav(); gameScroll.video.switchVideo();}
		// else {const updated = updateCollectionIndex(currentCollectionIndex - 1);updateSortedCollection();sounds.nav(); gameScroll.video.switchVideo();	}
        // if (updated) { updateSortedCollection();sounds.nav(); gameScroll.video.switchVideo();}
		
        // const updated = updateCollectionIndex(currentCollectionIndex - 1);
        // if (updated) {
            // updateSortedCollection();
            // sounds.nav();
            // gameScroll.video.switchVideo();
        // }
    // }

    // Keys.onRightPressed: {
        // event.accepted = true;
		// if (currentCollectionIndex < (collectionCount - 1))	{
        // const updated = updateCollectionIndex(currentCollectionIndex + 1);updateSortedCollection();
		// sounds.nav();
		// gameScroll.video.switchVideo();		}
		// else {		const updated = updateCollectionIndex(0);updateSortedCollection();
		// sounds.nav();
		// gameScroll.video.switchVideo();}
        // if (updated) { 
		// updateSortedCollection();
		// sounds.nav();
		// gameScroll.video.switchVideo();}
		
        // const updated = updateCollectionIndex(currentCollectionIndex + 1);
        // if (updated) {
            // updateSortedCollection();
            // sounds.nav();
            // gameScroll.video.switchVideo();
        // }
    // }

    function onAcceptPressed() {
        if (currentGameList.count === 0) return;
        sounds.launch();
        currentGame.launch();
    }

    function onCancelPressed() {
        currentView = 'collectionList';
        updateGameIndex(0, true);
        sounds.back();
    }

    function onDetailsPressed() {
		previousView = currentView;
		currentView = 'sorting';
		
		
		// sorting.sortingScroll.godTex.textBox.nameFilterTextInput.focus = true
		// sortingComponent.showModal(); 
		sounds.forward();
			
        
    }

    function onFiltersPressed() {
		currentGame.favorite = !currentGame.favorite;
		updateGameIndex(currentGameIndex, true);
		gameScroll.video.switchVideo();
		// if(currentGameIndex == 0) {updateGameIndex(currentGameIndex+1);
		// updateGameIndex(currentGameIndex-1)}
		// else {updateGameIndex(currentGameIndex-1);
		// updateGameIndex(currentGameIndex+1)}
        // favoritesChanged = true;
        sounds.nav();
		// currentView = 'gameDetails';
        // sounds.forward();
	
        //const gameCount = currentGameList.count;
        //const randomIndex = Math.floor(Math.random() * gameCount);
        //updateGameIndex(randomIndex);
        //sounds.nav();
    }

    Keys.onPressed: {
        if (api.keys.isCancel(event)) {
            event.accepted = true;
            onCancelPressed();
        }

        if (api.keys.isAccept(event)&& !event.isAutoRepeat) {
            event.accepted = true;
            onAcceptPressed();
        }

        if (api.keys.isDetails(event) && !event.isAutoRepeat) {
            event.accepted = true;
            onDetailsPressed();
        }

        if (api.keys.isFilters(event) && !event.isAutoRepeat) {
            event.accepted = true;
            onFiltersPressed();
        }
		
		

        // L1
        if (api.keys.isPrevPage(event)) {
			event.accepted = true;
			if ((currentCollectionIndex - 1) < 0)	{
			const updated = updateCollectionIndex(collectionCount );updateSortedCollection();sounds.nav(); gameScroll.video.switchVideo();}
			else {const updated = updateCollectionIndex(currentCollectionIndex - 1);updateSortedCollection();sounds.nav(); gameScroll.video.switchVideo();	}
			if (updated) { updateSortedCollection();sounds.nav(); gameScroll.video.switchVideo();}
			// if (currentGameIndex - 10 < 0) {
			// const updated = updateGameIndex(0);
			// return;
			// }
            // const updated = updateGameIndex(currentGameIndex - 10);
            // if (updated) { sounds.nav(); }
		
		
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
			if (currentCollectionIndex < (collectionCount - 1))	{
			const updated = updateCollectionIndex(currentCollectionIndex + 1);updateSortedCollection();
			sounds.nav();
			gameScroll.video.switchVideo();		}
			else {		const updated = updateCollectionIndex(0);updateSortedCollection();
			sounds.nav();
			gameScroll.video.switchVideo();}
			if (updated) { 
			updateSortedCollection();
			sounds.nav();
			gameScroll.video.switchVideo();}
			
			
            // const updated = updateGameIndex(currentGameIndex + 10);
            // if (updated) { sounds.nav(); }
			
			
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
			var games_to_skip = Math.round(gameScroll.gamesListView.height / gameScroll.gamesListView.currentItem.height );
            const updated = updateGameIndex(currentGameIndex - games_to_skip);
            if (updated) { sounds.nav(); }
			// if (currentGameIndex - 30 < 0) {
			// const updated = updateGameIndex(0);
			// return;
			// }
            // const updated = updateGameIndex(currentGameIndex - 30);
            // if (updated) { sounds.nav(); }
		
            //event.accepted = true;
            //const updated = updateCollectionIndex(currentCollectionIndex - 1);
            //if (updated) { sounds.nav(); }
        }

        // R2
        if (api.keys.isPageDown(event)) {
		    event.accepted = true;
			var games_to_skip = Math.round(gameScroll.gamesListView.height / gameScroll.gamesListView.currentItem.height );
            const updated = updateGameIndex(currentGameIndex + games_to_skip);
            if (updated) { sounds.nav(); }
		
            //event.accepted = true;
            //const updated = updateCollectionIndex(currentCollectionIndex + 1);
            //if (updated) { sounds.nav(); }
        }
		
		 // if (api.keys.isPageUp(event) || api.keys.isPageDown(event)) {
            // event.accepted = true;
            // var games_to_skip = Math.round(gameScroll.gamesListView.height / gameScroll.gamesListView.currentItem.height );
            // if (api.keys.isPageUp(event))            
				// {currentGameIndex = Math.max(currentGameIndex - games_to_skip, 0);}
            // else
				// {currentGameIndex = Math.min(currentGameIndex + games_to_skip, currentCollection.games.count - 1);}
			// const updated = updateGameIndex(currentGameIndex)
            // return;
        // }
    }


    Rectangle {
        color: theme.current.bgColor;
        anchors.fill: parent;
    }

    GameScroll {
        id: gameScroll;

        letter: '';

        anchors {
            top: gameListHeader.bottom;
            bottom: gameListFooter.top;
            left: parent.left;
            right: parent.right;
        }
    }

    Footer.Component {
        id: gameListFooter;

        index: currentGameIndex + 1;
        total: currentGameList.count;
		indexAll: currentCollectionIndex + 1;
        totalAll: allCollections.length;

        buttons: [
            { title: '开始', key: theme.buttonGuide.accept, square: false, sigValue: 'accept' },
            { title: '返回', key: theme.buttonGuide.cancel, square: false, sigValue: 'cancel' },
			{ title: '筛选', key: theme.buttonGuide.details, square: false, sigValue: 'details' },
			{ title: '收藏', key: theme.buttonGuide.filters, square: false, sigValue: 'filters' },

        ];

        onFooterButtonClicked: {
            if (sigValue === 'accept') onAcceptPressed();
            if (sigValue === 'cancel') onCancelPressed();
            if (sigValue === 'details') onDetailsPressed();
            if (sigValue === 'filters') onFiltersPressed();
        }
    }

    Header.Component {
        id: gameListHeader;
        showDivider: true;
        shade: 'light';
        color: theme.current.bgColor;
        showTitle: true;
    }
}
