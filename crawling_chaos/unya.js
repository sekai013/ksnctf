$(function(){
	$("form").submit(function(){
		var t=$('input[type="text"]').val();
		var p=Array(70,152,195,284,475,612,791,896,810,850,737,1332,1469,1120,1470,832,1785,2196,1520,1480,1449);
		var f=false;

		if(p.length==t.length){
			f=true;
			for(var i=0;i<p.length;i++)
			if(t.charCodeAt(i)*(i+1)!=p[i])
				f=false;
			if(f)
				alert("(」・ω・)」うー!(/・ω・)/にゃー!");
		}
		if(!f)
			alert("No");
		return false;
	});
});
