import QtQuick 2.15
import QtMultimedia 5.15
import QtQuick.Layouts 1.11
import QtGraphicalEffects 1.0

Rectangle {
	id: rootR
    property bool showDivider: true;
    property string shade: api.memory.has('darkMode') ? api.memory.get('darkMode') : 'true'//'light';
	property string shadeColor: {
        return shade === 'light'
			? theme.current.settingsColorDark
			: theme.current.settingsColorLight;
	}
	property string shadeColor2: {
        return shade === 'false'//'light'
			? theme.current.defaultHeaderNameColor//theme.current.settingsColorLight
			: theme.current.defaultHeaderNameColor//theme.current.settingsColorDark;			 
    }
	
    property bool showTitle: false;
    property string title: '';
    property bool showSettings: true;
    property bool showSorting: true;
 
    color: 'transparent';
    height: root.height * .115 * theme.fontScale;

    anchors {
        left: parent.left;
        right: parent.right;
        top: parent.top;
    }

    // divider
    Rectangle {
        height: 1;
        color: theme.current.dividerColor;
        visible: showDivider;

        anchors {
            bottom: parent.bottom;
            left: parent.left;
            leftMargin: 22;
            right: parent.right;
            rightMargin: 22;
        }
    }
	
	Image {
        source: if(currentShortName == "favorites"){return '../../../Resource/Logo1/收藏游戏.png';}
		else if(currentShortName == "recents"){return '../../../Resource/Logo1/最近游戏.png';}
		else if(currentShortName == "allgames"){return '../../../Resource/Logo1/全部游戏.png';}
		else {return '../../../Resource/Logo1/' + currentShortName + '.png';}
		mipmap: true
		fillMode: Image.PreserveAspectFit;
        horizontalAlignment: Image.AlignLeft;
		width: parent.width*0.3;
        height: parent.height*1.25;
		visible: !showTitle
        anchors {
            verticalCenter: parent.verticalCenter;
			verticalCenterOffset: parent.height*0.2
            left: parent.left;
            leftMargin : vpx(5);
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
	
	Image {
        source: if(currentShortName == "favorites"){return '../../../Resource/Logo1/收藏游戏.png';}
		else if(currentShortName == "recents"){return '../../../Resource/Logo1/最近游戏.png';}
		else if(currentShortName == "allgames"){return '../../../Resource/Logo1/全部游戏.png';}
		else {return '../../../Resource/Logo1/' + currentShortName + '.png';}
		mipmap: true
		fillMode: Image.PreserveAspectFit;
        horizontalAlignment: Image.AlignLeft;
		width: parent.width*0.3;
        height: parent.height;
		visible: showTitle;
		opacity: .85
        anchors {
            verticalCenter: parent.verticalCenter;
			// verticalCenterOffset: parent.height*0.2
            left: parent.left;
            leftMargin : vpx(5);
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
        // visible: false;
        // text: title.length > 0
            // ? title
            // : currentCollection.name;
        // color: shadeColor2;
		// title.length > 0
            // ? theme.current.defaultHeaderNameColor
            // : collectionData.getColor(currentCollection.shortName);			
        //opacity: theme.current.bgOpacity;
        //width: 300;
        // elide: Text.ElideRight;

        // anchors {
            // left: parent.left;
            // leftMargin: 32;
            // verticalCenter: parent.verticalCenter;
        // }

        // font {
            // pixelSize: parent.height * .43;
            // letterSpacing: -0.3;
            // bold: true;
			// family: subtitleFont.name;
			
        // }
    // }

	Row {
        id: headerWidgets;

        property string shade: parent.shade;
        spacing: parent.height * .3;
        height: parent.height;

        anchors {
            right: parent.right;
            rightMargin: parent.height * .30;
        }


        Sort {
            id: sort;
            shade: parent.shade;
            height: parent.height * .45;
            visible: showSorting;
            anchors.verticalCenter: parent.verticalCenter;
        }

        Clock {
           id: clock;
           shade: parent.shade;
           height: parent.height;
		   opacity: 1;
        }
   
        Battery {
            id: battery;
//			visible: showBattery;         
			opacity: 1;
            shade: parent.shade;
            height: parent.height * .32;
            width: parent.height * .58;
            anchors.verticalCenter: parent.verticalCenter;
			anchors.verticalCenterOffset: vpx(2)
			
			Image{
                        id: chargingIcon

                        property bool chargingStatus: api.device.batteryCharging

                        width: height/2
                        height: settingsIcon.paintedHeight*.8
                        fillMode: Image.PreserveAspectFit
                        source: "../../assets/charging.svg"
                        sourceSize.width: 32
                        sourceSize.height: 64
                        smooth: true
						anchors.horizontalCenter: parent.horizontalCenter;
						anchors.verticalCenter: parent.verticalCenter;
                        horizontalAlignment: Image.AlignLeft
                        visible: chargingStatus && api.device.batteryPercent*100 < 99
                        // layer.enabled: true
                        // layer.effect: ColorOverlay {
                            // color: "green"
                            // antialiasing: true
                            // cached: true
                        // }

                        function set() {
                            chargingStatus = api.device.batteryCharging;
                        }

                        Timer {
                            id: chargingIconTimer
                            interval: 10000 // Run the timer every minute
							repeat: true
                            onTriggered: chargingIcon.set()
                        }
						
						Image{
                        id: chargingIcon2

                        property bool chargingStatus: api.device.batteryCharging

                        width: height/2
                        height: settingsIcon.paintedHeight*.75
                        fillMode: Image.PreserveAspectFit
                        source: "../../assets/charging.svg"
                        sourceSize.width: 32
                        sourceSize.height: 64
                        smooth: true
						anchors.horizontalCenter: parent.horizontalCenter;
						anchors.verticalCenter: parent.verticalCenter;
                        horizontalAlignment: Image.AlignLeft
                        visible: chargingStatus && api.device.batteryPercent*100 < 99
                        layer.enabled: true
                        layer.effect: ColorOverlay {
                            color: "white"
                            antialiasing: true
                            cached: true
                        }

                        function set() {
                            chargingStatus = api.device.batteryCharging;
                        }

                        Timer {
                            id: chargingIconTimer2
                            interval: 10000 // Run the timer every minute
							repeat: true
                            onTriggered: chargingIcon.set()
                        }

                   }

                }
			
        }

		Text {
			id: batteryPercentage
			text:
				if(Math.floor(api.device.batteryPercent*100) > 0 ){
					Math.floor(api.device.batteryPercent*100) + "%"
				}else{
					"无电池"
				}
			//Math.floor(api.device.batteryPercent*100) + "%";
			opacity: 1;
            color: currentView == 'collectionList' ? "#fff" : shadeColor2;
            anchors.verticalCenter: parent.verticalCenter;
            font {
                family: subtitleFont.name;//family: glyphs.name;
                pixelSize: parent.height * .30;
				bold: true;
            }
			style: currentView == 'collectionList' ? Text.Outline : Text.Normal
			// style: Text.Outline;styleColor:'#666666'
		}

        Text {
            id: settingsIcon;
            visible: showSettings
            text: glyphs.settings;
			opacity: 1;
            color: currentView == 'collectionList' ? "#fff" : shadeColor2;
            anchors.verticalCenter: parent.verticalCenter;
            font {
                family: glyphs.name;
                pixelSize: parent.height * .33;
				bold: true;
            }
			style: currentView == 'collectionList' ? Text.Outline : Text.Normal
			// style: Text.Outline;styleColor:'#666666'

			MouseArea {
                anchors.fill: parent;
                onClicked: {
                    if (currentView === 'settings') {
                        currentView = previousView;
                        sounds.back();
                    } else {
                        previousView = currentView;
                        currentView = 'settings';
                        sounds.forward();
                    }
                }
            }
        }
    }

	Column{
        spacing: vpx(2);
		width: Math.max(rootR.width*.12, parent.height*2)
		anchors.verticalCenter: parent.verticalCenter;
		anchors.right: headerWidgets.left;
		anchors.rightMargin: 50;


		Row{
				spacing: vpx(10)
			Text {
				text:"上次游玩:"
				color: currentView == 'collectionList' ? "#fff" : shadeColor2;
				font {
					pixelSize: Math.min(rootR.width * .035,rootR.height* .25)
					family: subtitleFont.name
				}

				visible: (currentView != 'gameList' ) ? false : true;
				opacity: .5
		    }

			Text {
				id: timecount
				 text:{
					   if (!currentGame)
						   return "-";
					   if (isNaN(currentGame.lastPlayed))
						   return "从未玩过";

					   var now = new Date();

					   var diffHours = (now.getTime() - currentGame.lastPlayed.getTime()) / 1000 / 60 / 60;
					   if (diffHours < 24 && now.getDate() === currentGame.lastPlayed.getDate())
						   return "今天玩过";

					   var diffDays = Math.round(diffHours / 24);
					   if (diffDays <= 1)
						   return "昨天玩过";

					   return diffDays + "天以前"
				  }
				horizontalAlignment: Text.AlignRight
				color: currentView == 'collectionList' ? "#fff" : shadeColor2;
				font {
					pixelSize: Math.min(rootR.width * .035,rootR.height* .25)
					family: subtitleFont.name
				}

				visible: (currentView != 'gameList' ) ? false : true;
				opacity: .5
			  }
			}

			Row{
				spacing: vpx(10)

			Text {
				text:"游戏时长:"
				color: currentView == 'collectionList' ? "#fff" : shadeColor2;
				font {
					pixelSize: Math.min(rootR.width * .035,rootR.height* .25)
					family: subtitleFont.name
				}

				visible: (currentView != 'gameList' ) ? false : true;
				opacity: .5
		    }

			Text {
				id: timecount2
				text: {if (!currentGame)
							   return "-";

						   var minutes = Math.ceil(currentGame.playTime / 60)
						   if (minutes <= 90)
							   return Math.round(minutes) + "分钟";

						   return parseFloat((minutes / 60).toFixed(1)) + "小时"
				}
				color: currentView == 'collectionList' ? "#fff" : shadeColor2;
				horizontalAlignment: Text.AlignRight
				font {
					pixelSize: Math.min(rootR.width * .035,rootR.height* .25)
					family: subtitleFont.name
				}

				visible: (currentView != 'gameList' ) ? false : true;
				opacity: .5
			}
			}

		}
}
