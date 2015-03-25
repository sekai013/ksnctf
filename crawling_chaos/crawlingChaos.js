'use strict';
ans = Array(70,152,195,284,475,612,791,896,810,850,737,1332,1469,1120,1470,832,1785,2196,1520,1480,1449);
console.log(ans.map(function(c) {
	return String.fromCharCode(c / (ans.indexOf(c) + 1));
}).join(''));
