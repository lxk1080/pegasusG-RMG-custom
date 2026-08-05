import QtQuick 2.15

Item {
    property int collectionCount: allCollections.length;
    property alias collectionListView: collectionListView;
    property bool muteStartup: true;

    Component.onCompleted: {
        collectionListView.currentIndex = currentCollectionIndex;
        collectionListView.positionViewAtIndex(currentCollectionIndex, ListView.Center);

        backgroundColor.color = collectionData.getColor(currentShortName);
//        muteStartup = false;
    }

    // Rectangle {
	    // id: colscro;
        // width: parent.width * .81;
        // height: parent.width * .016;
        // color: '#000';
		// radius: 10
		// opacity: 0.15
		// z:1
		
		// anchors{
            // horizontalCenter: parent.horizontalCenter;
            // bottom: parent.bottom;
            // bottomMargin: 5;
                // }
				
	    
		
    // }
	    // Rectangle {
		
        // width: parent.width * .8;
        // height: parent.width * .016;
        // color: 'transparent';
		// radius: 10
		// z:2
		
		// PageIndicator {
		
        // currentIndex: collectionListView.currentIndex;
        // pageCount: collectionCount;
        // width: parent.parent.width * .8;
        // height: parent.width * .01;
		
		
		
        // anchors {
            // horizontalCenter: parent.horizontalCenter;
			// verticalCenter: parent.verticalCenter
           
                // }
				
	    // }
		
		// anchors{
            // horizontalCenter: parent.horizontalCenter;
			// bottom: parent.bottom;
            // bottomMargin: 5;
                // }
				
	    
		
    // }

    // background color, fades when collection changes
    Rectangle {
        id: backgroundColor;

        width: parent.width;
        height: parent.height;
        color: collectionData.getColor(currentShortName);
        opacity: theme.current.bgOpacity;

        Behavior on color {
            ColorAnimation { duration: 325; easing.type: Easing.InOutQuad; }
        }
    }

    // dots
	
    //PageIndicator {
        //currentIndex: collectionListView.currentIndex;
        //pageCount: collectionCount;
        //width: parent.width * .85;
        //height: parent.height * .01;
		
        //anchors {
            //horizontalCenter: parent.horizontalCenter;
           // bottom: parent.bottom;
           // bottomMargin: 25;
			
        //}
    //}

    ListView {
        id: collectionListView;

        model: allCollections;
        delegate: lvCollectionDelegate;
        orientation: ListView.Horizontal;
        highlightRangeMode: ListView.StrictlyEnforceRange;
        preferredHighlightBegin: 0.5//0;
        preferredHighlightEnd: 0.5//parent.width;
        snapMode: ListView.SnapToItem;
        highlightMoveDuration: 325;
        highlightMoveVelocity: -1;
        spacing: 0;
        anchors.fill: parent;

        onCurrentIndexChanged: {
            if (currentIndex !== currentCollectionIndex) {
                const updated = updateCollectionIndex(currentIndex, true);
                if (updated && !muteStartup) sounds.nav();
            }

            backgroundColor.color = collectionData.getColor(currentShortName);
        }
    }


    Component {
        id: lvCollectionDelegate;

        CollectionItem {
            width: collectionListView.width;
            height: collectionListView.height;
        }
    }
}
