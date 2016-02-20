function zhStatus()
{
	var msg=new makearray(10);
	msg[0]="青蛙大学内万分痛苦痛苦中..:(";
	msg[1]="在蓝天BBS上灌水呐！";
	msg[2]="在因特网上冲浪:)";
	msg[3]="青蛙自习室中学习呢！";
	msg[4]="青蛙图书馆里汲取精华... ...";
	msg[5]="和宿舍的男蛙们热烈讨论女蛙中... ...";
	msg[6]="睡觉呢～～zzz...ZZZ...zzz...ZZZ...";
	msg[7]="吃饭啦！我一顿饭要吃六两呦！";
	msg[8]="沉思中：怎么我到了现在还没有GF呢？";
	msg[9]="维护主页..加新东东乐！";
	msg[10]="去水母青蛙BBS找我你肯定能找得到！";
	document.write(msg[Math.floor(Math.random()*10+0.5)]);
	return;
}