import QtQuick 2.15

Item {
    property var keys: [
       	'darkMode', 
		'bgMusic', 
		'navSounds',
		'backSound',		
		'quietVideo',
		'twelveHour',
		'smallFont', 
		'gameListLogo', 
/*		'favoritesOnTop',
		'quickVideo',
		'buttonGuide', 
		'dropShadow', 
		'resetNameFilter', 
		'attractTitle', 
		'delayedImage',
		'gameListVideo',
		'gameDetailsVideo',*/
    ];

    function title(key) { return titles[key]; }
    function toggle(key) { set(key, !values[key]); }

    function get(key) {
        if (values[key] === null) {
            set(key, api.memory.get(key) ?? defaults[key]);
        }

        return values[key];
    }

    function saveAll() {
        for (const key of keys) {
            api.memory.set(key, get(key));
        }
    }

    function set(key, value) {
        if (values[key] === undefined) return;

        values[key] = value;
        callback(key);
    }

    function addCallback(key, callback) {
        if (callbacks[key] === undefined) return;

        callbacks[key].push(callback);
    }

    function callback(key) {
        if (callbacks[key] === undefined) return;

        for (let i = 0; i < callbacks[key].length; i++) {
            callbacks[key][i](values[key]);
        }
    }

    property var defaults: {
        'bgMusic': true,
        'navSounds': true,
        'darkMode': true,
		'backSound': false,
        'buttonGuide': false,
        'twelveHour': false,
        'smallFont': false,
        'gameListVideo': true,
		'gameListLogo': true,
        'gameDetailsVideo': true,
        'quietVideo': true,
        'quickVideo': true,
        'dropShadow': false,
        'resetNameFilter': true,
        'attractTitle': true,
        'favoritesOnTop': true,
        'delayedImage': false,
    }

    property var values: {
        'bgMusic': null,
        'navSounds': null,
        'darkMode': null,
		'backSound': null,
        'buttonGuide': null,
        'twelveHour': null,
        'smallFont': null,
        'gameListVideo': null,
		'gameListLogo': null,
        'gameDetailsVideo': null,
        'quietVideo': null,
        'quickVideo': null,
        'dropShadow': null,
        'resetNameFilter': null,
        'attractTitle': null,
        'favoritesOnTop': null,
        'delayedImage': null,
    }

    property var callbacks: {
        'bgMusic': [],
        'navSounds': [],
        'darkMode': [],
		'backSound': [],
        'buttonGuide': [],
        'twelveHour': [],
        'smallFont': [],
        'gameListVideo': [],
		'gameListLogo': [],
        'gameDetailsVideo': [],
        'quietVideo': [],
        'quickVideo': [],
        'dropShadow': [],
        'resetNameFilter': [],
        'attractTitle': [],
        'favoritesOnTop': [],
        'delayedImage': [],
    }

    property var titles: {
        'bgMusic': '背景音乐开关',
        'navSounds': '效果音开关',
        'darkMode': '黑色主题',
		'backSound': '后台音乐',
        'buttonGuide': 'XBox 按键方案',
        'twelveHour': '十二小时制显示',
        'smallFont': '使用小字体',
        'gameListVideo': '游戏列表显示视频',
		'gameListLogo': '游戏列表显示Logo（重启or翻页）',
        'gameDetailsVideo': '游戏详情显示视频',
        'quietVideo': '视频静音',
        'quickVideo': '加快显示视频',
        'dropShadow': '视频/图像 阴影效果',
        'resetNameFilter': '筛选后清除内容',
        'attractTitle': '观赏模式显示标题',
        'favoritesOnTop': '收藏置顶',
        'delayedImage': '延迟图像',
    }
}
