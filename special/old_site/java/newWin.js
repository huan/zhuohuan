function newWin(url,winName,wide)
{	window.status="请梢候 ... 载入文档中 ... ...^_^";
	if(wide){
		newWindow=open(url,winName,"status,resizable,toolbar"); 
	}else{
		newWindow=open(url,winName,"toolbar,location,status,menubar,scrollbars,resizable");
	}
	newWindow.focus();
	setTimeout("newWindow.focus()",10);
	return;
}