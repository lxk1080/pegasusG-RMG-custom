import QtQuick 2.15

import '../footer' as Footer
import '../header' as Header
import '../sorting' as Sorting

Item {
 property int collectionCount: allCollections.length;
 

    anchors.fill: parent;
    function updateIndex(newIndex) {
        collectionScroll.collectionListView.currentIndex = newIndex;
    }

    Keys.onLeftPressed: {
        event.accepted = true;
	 if ((currentCollectionIndex - 1) < 0)	{
	 collectionScroll.collectionListView.positionViewAtEnd();sounds.nav()}
		// const updated = updateCollectionIndex(collectionCount );sounds.nav(); 	}
	else {        const updated = updateCollectionIndex(currentCollectionIndex - 1);sounds.nav(); 	}
    }

    Keys.onRightPressed: {
        event.accepted = true;
	 if (currentCollectionIndex < (collectionCount - 1))	{
        const updated = updateCollectionIndex(currentCollectionIndex + 1);sounds.nav(); 		}
	else {		 collectionScroll.collectionListView.positionViewAtBeginning();sounds.nav()}
	// const updated = updateCollectionIndex(0);sounds.nav(); 	}
    }
	
	Keys.onUpPressed: {
        event.accepted = true;
	 if ((currentCollectionIndex - 1) < 0)	{
	 collectionScroll.collectionListView.positionViewAtEnd();sounds.nav()}
		// const updated = updateCollectionIndex(collectionCount );sounds.nav(); 	}
	else {        const updated = updateCollectionIndex(currentCollectionIndex - 1);sounds.nav(); 	}
	//	const updated = updateCollectionIndex(0);
		// sounds.nav();
    }

    Keys.onDownPressed: {
        event.accepted = true;
	 if (currentCollectionIndex < (collectionCount - 1))	{
        const updated = updateCollectionIndex(currentCollectionIndex + 1);sounds.nav(); 		}
	else {		 collectionScroll.collectionListView.positionViewAtBeginning();sounds.nav()}
    //    const updated = updateCollectionIndex(allCollections.length);
        // if (updated) { sounds.nav(); }
    }

    function onAcceptPressed() {
        currentGame = null;
        updateSortedCollection();
        currentView = 'gameList';
        sounds.forward();
    }

    function onSettingsPressed() {
        previousView = currentView;
        currentView = 'settings';
        sounds.forward();
    }

//按键筛选
      //function onSortPressed() {
      //previousView = currentView;
     // currentView = 'sorting';
      //sounds.forward();
      //}


    Keys.onPressed: {
	
		//if (api.keys.isFilters(event)) {            
			//event.accepted = true;            
			//onSortPressed();        
		//}
			
        if (api.keys.isAccept(event)&& !event.isAutoRepeat) {
            event.accepted = true;
            onAcceptPressed();
        }

        if (api.keys.isDetails(event)) {
            event.accepted = true;
            onSettingsPressed();
        }

// L1
        if (api.keys.isPrevPage(event)) {
            event.accepted = true;
			if(currentCollectionIndex == 0) {
			collectionScroll.collectionListView.positionViewAtEnd();sounds.nav();return;
			}
			else if (currentCollectionIndex - 5 < 0) {
			collectionScroll.collectionListView.positionViewAtBeginning();sounds.nav();return;
			}
            const updated = updateCollectionIndex(currentCollectionIndex - 5);
            if (updated) { sounds.nav(); }
        }

//R1		
		if (api.keys.isNextPage(event)) {
            event.accepted = true;
			if (currentCollectionIndex == allCollections.length - 1) {
			collectionScroll.collectionListView.positionViewAtBeginning();sounds.nav();return;
			}
			else if (currentCollectionIndex + 5 > allCollections.length - 1) {
			collectionScroll.collectionListView.positionViewAtEnd();sounds.nav();return;
			}
            const updated = updateCollectionIndex(currentCollectionIndex + 5);
            if (updated) { sounds.nav(); }
        }
    }

    Keys.onReleased: {

//L2
		if (api.keys.isPageUp(event)) {
            event.accepted = true;
			collectionScroll.collectionListView.positionViewAtBeginning();
			sounds.nav();
			// const updated= updateCollectionIndex(0);			
            // const updated = updateCollectionIndex(currentCollectionIndex - 10);
            // if (updated) { sounds.nav(); }
        }
		
//R2
		if (api.keys.isPageDown(event)) {
            event.accepted = true;
			collectionScroll.collectionListView.positionViewAtEnd();
			sounds.nav();
			// const updated = updateCollectionIndex(allCollections.length);
            // const updated = updateCollectionIndex(currentCollectionIndex + 10);
            // if (updated) { sounds.nav(); }
        }
    }
	
    CollectionScroll {
        id: collectionScroll;

        anchors {
            top: parent.top;
            bottom: collectionListFooter.top;
            left: parent.left;
            right: parent.right;
        }
    }

    Footer.Component {
        id: collectionListFooter;
        index: currentCollectionIndex + 1;
        total: allCollections.length;        
		indexAll: currentCollectionIndex + 1;
        totalAll: allCollections.length;


        buttons: [
            { title: '选择', key: theme.buttonGuide.accept, square: false, sigValue: 'accept' },
            { title: '返回', key: theme.buttonGuide.cancel, square: false, sigValue: null },
            { title: '设置', key: theme.buttonGuide.details, square: false, sigValue: 'settings' },
            //{ title: '筛选', key: theme.buttonGuide.filters, square: false, sigValue: 'sorting' },
        ];

        onFooterButtonClicked: {
            if (sigValue === 'accept') onAcceptPressed();
            if (sigValue === 'settings') onSettingsPressed();
            // if (sigValue === 'sorting') onSortPressed();
        }
    }
	
		PageIndicator {
		
        currentIndex: collectionScroll.collectionListView.currentIndex ;
        pageCount: collectionCount;
        width: parent.width * .8;
        height: parent.width * .01;
		
		
		
        anchors {
            horizontalCenter: parent.horizontalCenter;
			// verticalCenter: parent.verticalCenter
			bottom: collectionListFooter.top
			bottomMargin: vpx(20)
           
                }
				
	    }

    Header.Component {
        showDivider: false;
		showSorting: false;
        shade: 'light';
    }
}
