function checkModified()
{	changeDate=new Date(document.lastModified);
	document.write("本文档最后更新日期：",changeDate.getYear(),"年",changeDate.getMonth()+1,"月",changeDate.getDate(),"日",changeDate.getHours(),"点",changeDate.getMinutes(),"分");
	return;
}