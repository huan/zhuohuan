function checkModified()
{	changeDate=new Date(document.lastModified);
	document.write("���ĵ����������ڣ�",changeDate.getYear(),"��",changeDate.getMonth()+1,"��",changeDate.getDate(),"��",changeDate.getHours(),"��",changeDate.getMinutes(),"��");
	return;
}