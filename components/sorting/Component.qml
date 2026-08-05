import QtQuick 2.15

import '../footer' as Footer
import '../header' as Header

Item {
    anchors.fill: parent;

    function onAcceptPressed(muteSound = false) {
		nameFilter = sortingScroll.textInput.text;
		sounds.forward();
		currentGame = null;
		updateSortedCollection();
		currentView = 'gameList';
		return;
        const currentKey = sorting.model.get(sortingScroll.sortingListView.currentIndex).key;
        sorting.executeCallback(currentKey);
        if (!muteSound) sounds.nav();
    }

    function onCancelPressed() {
		sounds.back();
		currentGame = null;
		updateSortedCollection();
		currentView = 'gameList';
		return;
        updateGameIndex(0, true);
		currentView = previousView;
        sounds.back();
    }

    function onClearPressed() {
	    sortingScroll.textInput.clear();
        onAcceptPressed();	
        }
		
	function onFocusPressed() {
		sortingScroll.textInput.focus = true;
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
            onClearPressed();
        }
		
        if (api.keys.isFilters(event) && !event.isAutoRepeat) {
            event.accepted = true;
			onFocusPressed();
        }
    }

    Item {
        id: allDetailsBlur;

        anchors.fill: parent;

        Rectangle {
            color: theme.current.bgColor;
            anchors.fill: parent;
        }

        SortingScroll {
            id: sortingScroll;
            anchors {
                top: sortingHeader.bottom;
                bottom: sortingFooter.top;
                left: parent.left;
                right: parent.right;
            }
        }

        Footer.Component {
            id: sortingFooter;

            total: 0;

            buttons: [
                { title: '确认', key: theme.buttonGuide.accept, square: false, sigValue: 'accept' },
                { title: '返回', key: theme.buttonGuide.cancel, square: false, sigValue: 'cancel' },
	            { title: '清除', key: theme.buttonGuide.details, square: false, sigValue: 'clear' },
	            { title: '激活输入框', key: theme.buttonGuide.filters, square: false, sigValue: 'focus' },
            ];

            onFooterButtonClicked: {
                if (sigValue === 'accept') onAcceptPressed();
                if (sigValue === 'cancel') onCancelPressed();
	            if (sigValue === 'clear') onClearPressed();
	            if (sigValue === 'focus') onFocusPressed();
            }
        }

        Header.Component {
            id: sortingHeader;

            showDivider: true;
            shade: 'light';
            showSettings: true;
            color: theme.current.bgColor;
            showTitle: true;
            title: '游戏名筛选';
        }
    }

    NameFilterModal {
        id: nameFilterModal;

        height: parent.height;
        width: parent.width;
        blurSource: allDetailsBlur;
		
        anchors {
            top: parent.top;
            topMargin: root.height;
            left: parent.left;
            right: parent.right;
        }

        Behavior on anchors.topMargin {
			PropertyAnimation { easing.type: Easing.OutCubic; duration: 200; }
        }
    }
}
