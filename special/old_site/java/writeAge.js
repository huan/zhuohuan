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
			alert("���������������������ҵ�����Ү������������ϣ�����ܹ�����һ�����ö�Ү��^_^");
		}else if(day<0 && day>-10){
			alert("����ι������"+(-day)+"���ҹ������ϡ�����^_^");
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
	year++; //���� :)
//	month++; //û�У��¡�

	ageMsg=""+year+"����"+month+"����"+day+"��"+hour+"Сʱ";//+minute+"��"+second+"��";
	document.write(ageMsg);
	return true;
}