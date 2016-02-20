//form name=Birthday type=text name=Timer size=30
function birthdayTimer() //return true if is my birthday.:)
{	today=new Date();
	birthday=new Date(79,3,20,19,30,0);
	seconds=today.getSeconds()-birthday.getSeconds();
	minutes=today.getMinutes()-birthday.getMinutes();
	hours=today.getHours()-birthday.getHours();
	date=today.getDate()-birthday.getDate();
	month=today.getMonth()-birthday.getMonth();

	while(seconds<0){
		seconds+=60;
		minutes--;
	}
	while(minutes<0){
		minutes+=60;
		hours--;
	}
	while(hours<0){
		hours+=24;
		date--;
	}
	while(date<0){
		date+=30;
		month--;
	}
	while(month<0){
		month+=12;
	}

	seconds=59-seconds;
	minutes=59-minutes;
	hours=23-hours;
	date=29-date;
	month=11-month; //为什么都要减一？？ 

	msg=month+"个月"+date+"天"+hours+"小时"+minutes+"分钟"+seconds+"秒　　　　　　　　　　　　　";
	document.Birthday.Timer.value=msg;
	setTimeout("birthdayTimer()",1000);

	return (month==0&&date==0)||(month==11&&date==29&&hours>19)?true:false;
}
