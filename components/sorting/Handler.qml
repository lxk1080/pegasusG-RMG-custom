import QtQuick 2.15

Item {
    property alias model: model;

    ListModel {
        id: model;

        ListElement {
            key: 'nameFilter';
            type: 'nameFilter';
        }

        // ListElement {
            // key: 'sortBy'; 
            // title: '按名排序'; 
            // type: 'sort';
            // defaultOrder: 'asc'; 
       // }

        // ListElement {
            // key: 'favorite';
            // title: '按收藏排序';
            // type: 'sort';
            // defaultOrder: 'asc';
        // }

    }

    function updateSort(key, defaultSort) {
        return () => {
            if (sortKey !== key) {
                sortKey = key;
                sortDir = defaultSort;
                return;
            }

            if (sortDir === Qt.AscendingOrder) {
                sortDir = Qt.DescendingOrder;
                return;
            }

            sortDir = Qt.AscendingOrder;
        }
    }

    function executeCallback(key) {
        const callbacks = {
            nameFilter: () => { sortingComponent.showModal(); },
            favorite: updateSort('favorite', Qt.DescendingOrder),
            sortBy: updateSort('sortBy', Qt.AscendingOrder),
        };

        callbacks[key]();
    }
}
