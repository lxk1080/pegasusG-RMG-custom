import QtQuick 2.15
import QtMultimedia 5.9
import QtGraphicalEffects 1.12

Item {
    property string settingKey: '';
    property string validView: '';
    signal videoToggled(bool videoPlaying);


    function switchVideo() {
        videoPlayer.stop();
        videoPlayer.source = '';
		videoPlayer.state = "";
        music.volumeCheck();
		
        videoPlayerTimer.restart();
        videoToggled(false);
    }

    function videoOff() {
        switchVideo();
        videoPlayerTimer.stop();
    }

    function quickVideoCallback(enabled) {
        if (enabled) videoPlayerTimer.interval = 0;
        else videoPlayerTimer.interval = 0;
    }

    function quietVideoCallback(enabled) {
        if (enabled) videoPlayer.volume = 0;
        else videoPlayer.volume = .7;
    }

    // function dropShadowCallback(enabled) {
        // if (enabled) {
            // dropShadow.visible = true;
            // videoPlayer.visible = false;
        // } else {
            // videoPlayer.visible = true;
            // dropShadow.visible = false;
        // }
    // }

    Component.onCompleted: {
        addCurrentViewCallback(function (currentView) {
            if (currentView === validView) {
                switchVideo();
            } else {
                videoOff();
            }
        });

        music.registerVideo(videoPlayer);

        quickVideoCallback(settings.get('quickVideo'));
        settings.addCallback('quickVideo', quickVideoCallback);

        quietVideoCallback(settings.get('quietVideo'));
        settings.addCallback('quietVideo', quietVideoCallback);

        dropShadowCallback(settings.get('dropShadow'));
        settings.addCallback('dropShadow', dropShadowCallback);
    }

    Connections {
        target: Qt.application;
        function onStateChanged() {
            if (videoPlayer.source === '') return;

            if (Qt.application.state === Qt.ApplicationActive) {
                switchVideo();
            } else {
                videoOff();
            }
        }
    }

    Timer {
        id: videoPlayerTimer;

        interval: 0;
        repeat: false;
        onTriggered: {
            if (currentGame === null) return;
            if (currentGame.assets.video === '') return;
            if (settings.get(settingKey) === false) return;
            if (currentView !== validView) return;

            videoToggled(true);
			videoPlayer.state = "playing"
            videoPlayer.source = currentGame.assets.video;
            videoPlayer.play();
            music.volumeCheck();
        }
    }
	
	Rectangle {
        id: videoBox
        color: "#000"
        border { color: "#444"; width: 1 }
		visible: currentGameList.count == 0 ? false : true;
        anchors.top:parent.top
		anchors.topMargin: vpx(10)
        //anchors.bottom: parent.bottom
		//anchors.bottomMargin: vpx(8)

        width: parent.width;
        height: parent.height * .7;
        radius: vpx(4)
		}

    Video {
        id: videoPlayer;

        visible: currentGameList.count == 0 ? false : true;
        volume: 0.7
        source: currentGame.assets.video;
        autoPlay: true;
        loops: MediaPlayer.Infinite;
        // width: parent.width;
        // height: parent.height;
		// anchors.top: parent.top
		anchors { fill: videoBox; margins: 2 }
		// anchors.topMargin: vpx(10)
		// anchors.horizontalCenter: parent.horizontalCenter
        // anchors.centerIn: parent;
        // fillMode: VideoOutput.PreserveAspectFit;
            // states: State {
                // name: 'playing'
                // PropertyChanges { target: videoPlayer; opacity: 1 }
            // }
            // transitions: Transition {
                // from: ""; to: "playing"
                // NumberAnimation { properties: "opacity"; duration: 1000 }
            // }
		
     }
	

    DropShadow {
        id: dropShadow;

        source: videoPlayer;
        anchors.fill: videoPlayer;
        color: theme.current.dropShadowColor;
        verticalOffset: 5;
        radius: 20;
        samples: 41;
        cached: true;
        visible: true;
    }
}
