function backButton()
{	overMsg="�ص���һҳ��";
	outMsg="';
document.write("<a href='' onClick='History.go(-1);return true' onMouseOver='window.status=overMsg;return true' onMouseOut='window.status=outMsg'>����</a><br>");
	return true;
}