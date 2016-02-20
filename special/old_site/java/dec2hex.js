<!--
function	makeArray(n){
	this.length = n;
	for(var i = 1; i <= n; i++)
		this[i]	= 0;
	return this;
}

hex = new makeArray(16);
for(var i =	0;	i < 10; i++)
	hex[i] = i;

hex[10]="a"; hex[11]="b"; hex[12]="c";
hex[13]="d"; hex[14]="e"; hex[15]="f";

function dec2hex(i){
	if (i <	0)
		 return "00";
	else if (255	< i)
		 return "ff";
	else
		 return "" + hex[Math.floor(i/16)] + hex[i%16];
}
