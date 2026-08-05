import QtQuick 2.15

Item {
    // property string shade: 'light';
    property string shadeColor: {
        return shade === 'light'
			? theme.current.settingsColorDark
			: theme.current.settingsColorLight;
    }
	    
	// property string shadeColor2: {
        // return shade === 'light'
			// ? theme.current.settingsColorLight
			// : theme.current.settingsColorDark;
			 
    // }

    property string buttonColor: {
        return shade === 'dark'
            ? theme.current.sortButtonColorLight
            : theme.current.sortButtonColorDark;
    }


    property string label: {
        if (sortKey === 'sortBy') return '';
        if (sortKey === 'lastPlayed') return 'recent';
        return sortKey;
    }

    property string filter: {
        if (nameFilter === '') return '';
        //if (nameFilter.length > 4) return '' + nameFilter.substring(0,3) + '…';
        return '' + nameFilter;
    }

    property string icon: {
        if (sortDir === Qt.AscendingOrder) return glyphs.ascend;
        return glyphs.descend;
    }
	
	property string shade: api.memory.has('darkMode') ? api.memory.get('darkMode') : 'true'//'light';
    width: buttonRect.width + sortRow.width + parent.height * .3;
	property string shadeColor2: {
        return shade === 'false'//'light'
			? theme.current.defaultHeaderNameColor//theme.current.settingsColorLight
			: theme.current.defaultHeaderNameColor//theme.current.settingsColorDark;			 
    }
    Rectangle {
        id: sortRect;
//搜索框背景色
       color: 'transparent';
//搜索框边框色        
	   //border.color: theme.current.footerCountColor;
	   //opacity: 0.6;
	   //border.width：2;
        //border {
            //color: shadeColor;
            //width: 2;
        //}

        radius: parent.height * .25;

        anchors {
            verticalCenter: parent.verticalCenter;
            fill: parent;
        }

        Rectangle {
            id: buttonRect;
//筛选键填色
            color: 'transparent';
            radius: parent.radius - 1;
            height: parent.height;
            width: labelText.width;

            anchors {
				verticalCenter: parent.verticalCenter;
                //horizontalCenter: parent.horizontalCenter;
                right: clock.left;
                //rightMargin: parent.height * .2;
               // top: parent.top;
               // topMargin: 1;
            }
        }

        Row {
            id: sortRow;

            spacing: parent.height * .25;
            height: parent.height;
            width: labelText.width;
            anchors {
                verticalCenter: parent.verticalCenter;
                right: parent.right;
                rightMargin: parent.height * .05;
            }

            Text {
                id: buttonText;
				visible: nameFilter.length > 0 ? true : false; 
	            text: '筛选关键词: ';
                color: shadeColor2;
	            // style: Text.Outline;styleColor:'#666666'

                anchors {
                verticalCenter: parent.verticalCenter;
  //              //horizontalCenter: parent.horizontalCenter;
                right: labelText.left;
                  //rightMargin: -50;
                }

                font {
                    pixelSize: parent.height * .58;
                    letterSpacing: -0.3;
                    bold: true;
		            family: subtitleFont.name;
                }
            }

            Text {
                id: labelText;
                text: filter;
//搜索框文字
                color: '#dc0000';
				//style: Text.Outline;styleColor:'#5e5e5e'
				font.family: subtitleFont.name
                verticalAlignment: Text.AlignVCenter;
                anchors.verticalCenter: parent.verticalCenter;
				//horizontalCenter: parent.horizontalCenter;
                font {
                    pixelSize: parent.height * .58;
                    //letterSpacing: -0.3;
                    bold: true;
                }
            }

//收藏夹图标
            Text {
                id: favoritesIcon;

                visible: onlyFavorites;
                text: glyphs.favorite;
                verticalAlignment: Text.AlignVCenter;
                anchors.verticalCenter: parent.verticalCenter;
                color: shadeColor;

                font {
                    family: glyphs.name;
                    pixelSize: parent.height * .5;
                }
            }
        }

        MouseArea {
            anchors.fill: parent;
            onClicked: {
                if (currentView === 'sorting') {
                    currentView = previousView;
                    sounds.back();
                } else {
                    previousView = currentView;
                    currentView = 'sorting';
						sortingComponent.showModal(); 
                    sounds.forward();
                }
            }
        }
    }
}
