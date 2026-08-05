import QtQuick 2.15

Item {
    property string nameFilterText: {
        if (nameFilter === '') return '请输入筛选关键词';
        return '关键词:' + nameFilter;
    }

    MouseArea {
        anchors.fill: parent;
        onClicked: {
            let muteSound = false;

            if (sortingListView.currentIndex !== index) {
                sortingListView.currentIndex = index;
                sounds.nav();
                muteSound = true;
            }

            onAcceptPressed(muteSound);
        }
    }

    Text {
        id: nameFilterIcon;

        text: glyphs.search;
        verticalAlignment: Text.AlignVCenter;
        color: sortingListView.currentIndex === index
            ? theme.current.focusTextColor
            : theme.current.blurTextColor;
        height: parent.height;
        width: parent.height * .43;

        font {
            family: glyphs.name;
            pixelSize: parent.height * .43;
        }

        anchors {
            left: parent.left;
            leftMargin: 20;
        }
    }

    Text {
        text: nameFilterText;
        verticalAlignment: Text.AlignVCenter;
        color: sortingListView.currentIndex === index
            ? theme.current.focusTextColor
            : theme.current.blurTextColor;
        height: parent.height;

        font {
            pixelSize: parent.height * .43;
            letterSpacing: -0.3;
            //bold: true;
family: subtitleFont.name;
        }

        anchors {
            left: nameFilterIcon.right;
            leftMargin: 20;
            right: parent.right;
            rightMargin: 20;
        }
    }
}
