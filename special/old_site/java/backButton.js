function backButton()
{	overMsg="回到上一页。";
	outMsg="';
document.write("<a href='' onClick='History.go(-1);return true' onMouseOver='window.status=overMsg;return true' onMouseOut='window.status=outMsg'>返回</a><br>");
	return true;
}