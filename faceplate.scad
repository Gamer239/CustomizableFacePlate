/* [Global] */

//length
length=30;

//width
width=60;

//depth
depth=5;

//usb a
usb_a="";

//usb_b
usb_b="";

//usb_b_mini
usb_b_mini="";

//usb_b_micro
usb_b_micro="";

//usb_ab_micro
usb_ab_micro="";

//sd
sd="";

//sd_mini
sd_mini="";

//sd_micro
sd_micro="";

//ethernet
ethernet="";

//coax_5_5mm
coax_5_5mm="";

//coax_6mm
coax_6mm="";

//coax_3_8mm
coax_3_8mm="";

//coax_3_4mm
coax_3_4mm="";

//vga
vga="";

//hdmi_micro
hdmi_micro="";

//dvi
dvi="";

//xlr
xlr="";

//circle
circle="";

/* [Hidden] */

difference()
{
cube([length,width,depth]);
each_element(usb_a, "usb_a");
each_element(usb_b, "usb_b");
each_element(usb_b_mini, "usb_b_mini");
each_element(usb_b_micro, "usb_b_micro");
each_element(usb_ab_micro, "usb_ab_micro");
each_element(sd, "sd");
each_element(sd_mini, "sd_mini");
each_element(sd_micro, "sd_micro");
each_element(ethernet, "ethernet");
each_element(coax_5_5mm, "coax_5_5mm");
each_element(coax_6mm, "coax_6mm");
each_element(coax_3_8mm, "coax_3_8mm");
each_element(coax_3_4mm, "coax_3_4mm");
each_element(vga, "vga");
each_element(hdmi_micro, "hdmi_micro");
each_element(dvi, "dvi");
each_element(xlr, "xlr");
each_element(circle, "circle");
}

module each_element( input_arr, type )
{
	input = [" ", input_arr, " "];
	result = search(" ", strcat(input), 8);
	//echo(result);
	for ( i = [0:len(result[0])-2] )
	{
		if (len(search(",",substr(input_arr,result[0][i],result[0][i+1]-result[0][i]-1),8)[0]) == 1)
		{
			assign( input2 = [",",substr(input_arr,result[0][i],result[0][i+1]-result[0][i]-1),"," ] )
			scan_string_two( strcat(input2), type );
		}
		if (len(search(",",substr(input_arr,result[0][i],result[0][i+1]-result[0][i]-1),8)[0]) == 2)
		{
			assign( input2 = [",",substr(input_arr,result[0][i],result[0][i+1]-result[0][i]-1),"," ] )
			scan_string_three( strcat(input2), type );
		}
	}
}

module scan_string_two( input_string, type )
{
	result = search(",", input_string,8);
	for ( i = [ 0:2:len(result[0])-2 ] )
	{	
		assign( first = strToInt(substr(substr(input_string,result[0][i],result[0][i+1]-result[0][i]),1,len(substr(input_string,result[0][i],result[0][i+1]-result[0][i]))-1)),
		second = strToInt(substr(substr(input_string,result[0][i+1],result[0][i+2]-result[0][i+1]),1,len(substr(input_string,result[0][i+1],result[0][i+2]-result[0][i+1]))-1)),
		third = 1 )
		call_type( type, first, second, third );
	}
}

module scan_string_three( input_string, type )
{
	result = search(",", input_string,8);
	//echo( len(result[0]));
	for ( i = [ 0:3:len(result[0])-3 ] )
	{	
		//echo(result[0][i+1]-result[0][i]);
		//echo(strToInt(substr(substr(input_string,result[0][i],result[0][i+1]-result[0][i]),1,len(substr(input_string,result[0][i],result[0][i+1]-result[0][i]))-1)));
		//echo(strToInt(substr(substr(input_string,result[0][i+1],result[0][i+2]-result[0][i+1]),1,len(substr(input_string,result[0][i+1],result[0][i+2]-result[0][i+1]))-1)));
		//echo(strToInt(substr(substr(input_string,result[0][i+2],result[0][i+3]-result[0][i+2]),1,len(substr(input_string,result[0][i+2],result[0][i+3]-result[0][i+2]))-1)));
		assign( first = strToInt(substr(substr(input_string,result[0][i],result[0][i+1]-result[0][i]),1,len(substr(input_string,result[0][i],result[0][i+1]-result[0][i]))-1)),
		second = strToInt(substr(substr(input_string,result[0][i+1],result[0][i+2]-result[0][i+1]),1,len(substr(input_string,result[0][i+1],result[0][i+2]-result[0][i+1]))-1)),
		third = strToInt(substr(substr(input_string,result[0][i+2],result[0][i+3]-result[0][i+2]),1,len(substr(input_string,result[0][i+2],result[0][i+3]-result[0][i+2]))-1)) )
		call_type( type, first, second, third );
	}
}


module call_type ( type, first, second, third )
{
	if ( type == "usb_a" )
	{
		USB_A(first, second);
	}
	if ( type == "usb_b" )
	{
		USB_B(first, second);
	}
	if ( type == "usb_b_mini" )
	{
		Mini_USB_B(first, second);
	}
	if ( type == "usb_b_micro" )
	{
		Micro_USB_B(first,second);
	}
	if ( type == "usb_ab_micro" )
	{
		Micro_USB_AB(first, second);
	}
	if (type == "sd")
	{
		SD_Card(first,second);
	}
	if (type == "sd_mini")
	{
		Mini_SD_Card(first, second);
	}
	if ( type == "sd_micro" )
	{
		Micro_SD_Card(first, second);
	}
	if ( type == "ethernet" )
	{
		Ethernet( first, second );
	}
	if ( type == "coax_5_5mm" )
	{
		Type_A_Coax_Pwr_5_5mm(first, second);
	}
	if ( type == "coax_6mm" )
	{
		Type_B_Coax_Pwr_6mm(first, second);
	}
	if ( type == "coax_3_8mm" )
	{
		Type_C_Coax_Pwr_3_8mm(first,second);
	}
	if ( type == "coax_3_4mm" )
	{
		Type_E_Coax_Pwr_3_4mm(first, second);
	} 	
	if ( type == "vga" )
	{
		VGA(first,second);
	}
	if ( type == "hdmi_micro" )
	{
		microHDMI(first,second);
	}
	if ( type == "dvi" )
	{
		dvi(first, second);
	}
	if ( type == "xlr" )
	{
		XLR(first, second);
	}
	if ( type == "circle" )
	{
		GenericCircle(first, second, third);
	}

}

// modules

module USB_A (X,Y) {
translate([X,Y,0])cube([13.5,6.12,25]);
}

module USB_B (X,Y) {
translate([X,Y,0])cube([9.45,25,8.78]);
}

module Mini_USB_B (X,Y) {
translate([X,Y,0])cube([7.9,25,4.1]);
}

module Micro_USB_B (X,Y) {
translate([X,Y,0])cube([7.92,25,2.88]);
}

module Micro_USB_AB (X,Y) {
translate([X,Y,0])cube([7.92,25,2.88]);
}

module SD_Card (X,Y) {
translate([X,Y,0])cube([25,25,3.1]);
}

module Mini_SD_Card (X,Y) {
translate([X,Y,0])cube([21,25,2.4]);
}

module Micro_SD_Card (X,Y) {
translate([X,Y,0])cube([12,25,2]);
}

module Ethernet (X,Y) {
translate([X,Y,0])cube([12.56,25,8.82]);
}

module Type_A_Coax_Pwr_5_5mm(X,Y) {
rotate([-90])translate([X+(6.5/2),Y-(6.5/2),0])cylinder(h=20,d=6.5);
}

module Type_B_Coax_Pwr_6mm(X,Y) {
rotate([-90])translate([X+(7/2),Y-(7/2),0])cylinder(h=20,d=7);
}

module Type_C_Coax_Pwr_3_8mm(X,Y) {
rotate([-90])translate([X+(4.8/2),Y-(4.8/2),0])cylinder(h=20,d=4.8);
}

module Type_D_Coax_Pwr_6_3mm(X,Y) {
rotate([-90])translate([X+(7.3/2),Y-(7.3/2),0])cylinder(h=20,d=7.3);
}

module Type_E_Coax_Pwr_3_4mm(X,Y) {
rotate([-90])translate([X+(4.4/2),Y-(4.4/2),0])cylinder(h=20,d=4.4);
}

module VGA (x,y)
{
	translate([x,y,0])
	{
		linear_extrude(25, center = true)
		union()
		{
			translate([4.6,0,0])
			difference()
			{
				square([19,10]);
				square([1,2.2]);
				translate([18,0]) square([1,2.2]);
				polygon(points = [[1,0],[2.75,0],[1,2.2]], paths = [[0,1,2]]);
				polygon(points = [[0,2.2],[0,7.4],[1,2.2]], paths = [[0,1,2]]);
				polygon(points = [[0,7.4],[0,10],[2,10]], paths = [[0,1,2]]);
				polygon(points = [[16.25,0],[18,2.2],[18,0]], paths = [[0,1,2]]);
				polygon(points = [[18,2.2],[19,7.4],[19,2.2]], paths = [[0,1,2]]);
				polygon(points = [[19,7.4],[17,10],[19,10]], paths = [[0,1,2]]);
			}//difference;//translate
			translate([1.6,5,0])circle(d = 3.2);
			translate([26.6,5,0])circle(d = 3.2);
		}
	}
}//end of vga

module microHDMI(x,y)
{
	translate([x,y,0]){
		linear_extrude(25,center = true)
		{
			difference() 
			{
				square([6.5,2.9]);
				polygon(points=[[0,0],[1.03,0],[0,1.07],[5.47,0],[6.5,0],[6.5,1.07]], paths=[[0,1,2],[3,4,5]]);
			}
		}
	}
}//end of microHDMI

module dvi(x,y)
{
	translate([x,y,0])
	{
		linear_extrude(25,center = true)
		{
			translate([4.95,0])
			{
				difference() 
				{
					square([25.8,9.3]);
					polygon(points=[[0,0],[.75,0],[0,4.5],[25.05,0],[25.8,0],[25.8,4.8]], paths=[[0,1,2],[3,4,5]]);
				}
			}
			translate([1.6,4.65]) {circle(d=3.2);
			}
			translate([34.1,4.65]) {circle(d=3.2);
			}
		}
	}
}//end of dvi

module XLR (x,y)
{
	translate([x,y,0])
	translate([12,12,0])linear_extrude(50,center = true) {union()
		{
			circle(d = 24);
			translate([-4.5,0,0])square([9,13]);
			translate([-9,11.5,0])circle(d = 3.2);
			translate([9,-11.5,0])circle(d = 3.2);
		}
	}
}//end of xlr

module GenericCircle (x,y, circleDia = 0)
{

	translate([x,y,0]){
		translate([circleDia/2,circleDia/2])
		{
			linear_extrude(25, center = true)
			circle(d = circleDia);

		}
	}
}// end of AudioJack


//openscad string library
//http://www.thingiverse.com/thing:202724
function strToInt(str, base=10, i=0, nb=0) = (str[0] == "-") ? -1*_strToInt(str, base, 1) : _strToInt(str, base);
function _strToInt(str, base, i=0, nb=0) = (i == len(str)) ? nb : nb+_strToInt(str, base, i+1, search(str[i],"0123456789ABCDEF")[0]*pow(base,len(str)-i-1));

function substr(data, i, length=0) = (length == 0) ? _substr(data, i, len(data)) : _substr(data, i, length+i);
function _substr(str, i, j, out="") = (i==j) ? out : str(str[i], _substr(str, i+1, j, out));

function strcat(v, car="") = _strcat(v, len(v)-1, car, 0);
function _strcat(v, i, car, s) = (i==s ? v[i] : str(_strcat(v, i-1, car, s), str(car,v[i]) ));