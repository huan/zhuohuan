function popDiary()
{	var msg="";
	var dateMsg="";
	var windMsg="";
	var weatherMsg="";
	var changeMsg="";
	var nvgtMsg="";
	var wellMsg="��֪�ҵ���λ�����ǲ���ʹ�õ�800X600�ķֱ��ʣ�16K���ϵ���ɫ�����ѽ�����ǵĻ������ܻ���Щ�ط����ÿ��������һ���ʲô���أ�����˭����640X480�ˡ�^_^";

	var i,j,k;
	var weather=new makearray(10);
	var direction=new makearray(4);
	var today=new Date();
	var hBirthday=new Date(98,4,1);
	var changeDate=new Date(document.lastModified);

	weather[0]="һ��";weather[1]="����";weather[2]="����";weather[3]="����ת��";weather[4]="��ת����";weather[5]="С��";weather[6]="����";weather[7]="���ƣ�����";weather[8]="С��ת��";weather[9]="����һ����";weather[10]="��������";weather[11]="ѹ��";
	direction[0]="����";direction[1]="��";direction[2]="��";direction[3]="��";direction[4]="��";direction[5]="����";direction[6]="����";direction[7]="����";

	weatherMsg="������"+weather[Math.floor(Math.random()*10+0.5)];

	i=Math.floor(Math.random()*6+0.5);
	windMsg=direction[i]+"��";
	while((j=Math.floor(Math.random()*6+0.5))==i);
	windMsg+="ת"+direction[j]+"��"+(k=Math.floor(Math.random()*3+0.5))+"��"+(k+Math.floor(Math.random()*3+0.5))+"��";
	
	dateMsg=today.getYear()+"��"+(today.getMonth()+1)+"��"+today.getDate()+"��"+"��������"+today.getDay();
	
	nvgtMsg="�������������õ�"+navigator.appVersion+"���"+navigator.appName+"������������ҵ���ҳ��";
	if(navigator.appName!="Netscape")
		nvgtMsg+="����Ŀǰ��ֻ���ҵ���ҳ����Netscape4.04�汾�ϵĲ��顣:( ���ԣ����������ܻ�����һЩ����ɣ�:-P ��ϣ��������������֪ͨ�ң���֪�����᲻��������æ�أ� :)";


	changeMsg="������ά���ҵ���ҳ��ʲôʱ�����ţ������"+changeDate.getYear()+"��"+(changeDate.getMonth()+1)+"��"+changeDate.getDate()+"��"+changeDate.getHours()+"��"+changeDate.getMinutes()+"��... ....��������һ���أ��������ǲ����~��^_^";
	if(today.getMonth()>changeDate.getMonth()||(today.getMonth()==changeDate.getMonth())&&(today.getDate()-changeDate.getDate())>5)
		changeMsg+="������Ϊ���ָ�����ԭ�����Ѿ�"+(today.getMonth()-changeDate.getMonth())+"������"+(today.getDate()-changeDate.getDate())+"��û��ά���ҿɰ��ļ���:(... ...���ǶԲ�����λ����ѽ����ʲôʱ������ô����... ...���ǣ�.... ������һ��Ҫ�úøɻ:)������ϣ����λ���Ѳ�Ҫ����ѽ��^_^";

	msg="<html><head><meta http-equiv='Content-Type' content='text/html; charset=gb2312'><title>׿����־ -�ۣ����㿴�ˣ���͵���ҵ��ռǣ��������...��Ҫ����������~</title></head><body bgcolor=Black background='images/background.gif' text=Yellow>"

	msg+="<center><font face='����' color=Lime><h4>"+dateMsg+"����"+windMsg+"����"+weatherMsg+"</h4></center><hr></font><p><font face='����_GB2312'>";

	msg+="����"+nvgtMsg+"�Ǻǣ��Һܸ�����~^_^��������Ҳ������˼���Դ�����1998��5�·ݿ�ʼ�����ҵĸ�����ҳ������Ҳ"+((today.getYear()-hBirthday.getYear())*12+today.getMonth()-hBirthday.getMonth())+"�����ˡ��������ڽ��������ҳ�Ĺ����У�����ᵽ�˼��������Ǻ���Ҫ��˭����ѧ���(ֻҪ�ϻ�ʱ��~_^)�����ǣ�˼���������һʱ������ѧ����ģ����Һ����ȱ����һ��(��������ͱ�MUD��������ͬ��ֻ��?... :)��<br>����"+changeMsg+"<br>";

	msg+="����"+wellMsg+"<br>";

	msg+="<br><br><br><br><center><form name=input><font face='����'><input type=button name=button value='�ޣ���ʲô�����������ߡ�����û��˼~_~' onClick='window.close()'></form></center></font></body></html>";
	Diary=open("","Diary","width=580,height=400,scrollbars");
	Diary.document.clear();
	Diary.document.write(msg);
	Diary.focus();
	return;
}

	