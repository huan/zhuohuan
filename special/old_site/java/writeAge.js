function writeAge()
{	today=new Date();
	birthday=new Date(79,3,20,19,30,0);
	var year,month,day,hour,minute,second;

	year=today.getYear()-birthday.getYear();
	month=today.getMonth()-birthday.getMonth();
	day=today.getDate()-birthday.getDate();
	hour=today.getHours()-birthday.getHours();
	minute=today.getMinutes()-birthday.getMinutes();
	second=today.getSeconds()-birthday.getSeconds();

	if(month==0){
		if(day==0){
			alert("　　哇塞！！！今天是我的生日耶！！！！！！希望你能够给我一封伊妹儿耶！^_^");
		}else if(day<0 && day>-10){
			alert("　　喂！还有"+(-day)+"天我过生日呦～～～^_^");
		}
	}


	while(second<0){
		second+=60;
		minute--;
	}
	while(minute<0){
		minute+=60;
		hour--;
	}
	while(hour<0){
		hour+=24;
		day--;
	}
	while(day<0){
		day+=30;
		month--;
	}
	while(month<0){
		month+=12;
		year--;
	}
	year++; //虚岁 :)
//	month++; //没有０月。

	ageMsg=""+year+"岁零"+month+"个月"+day+"天"+hour+"小时";//+minute+"分"+second+"秒";
	document.write(ageMsg);
	return true;
}