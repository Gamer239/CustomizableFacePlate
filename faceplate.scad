

//sample string
sample2="10,54 23,43";
sample3="10,54,23 43,27,61";

each_element(sample2, "usb");
each_element(sample3, "usb");

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
	if ( type == "usb" )
	{
		cube( [ first, second, third ] );
	}
}


//openscad string library
//http://www.thingiverse.com/thing:202724
function strToInt(str, base=10, i=0, nb=0) = (str[0] == "-") ? -1*_strToInt(str, base, 1) : _strToInt(str, base);
function _strToInt(str, base, i=0, nb=0) = (i == len(str)) ? nb : nb+_strToInt(str, base, i+1, search(str[i],"0123456789ABCDEF")[0]*pow(base,len(str)-i-1));

function substr(data, i, length=0) = (length == 0) ? _substr(data, i, len(data)) : _substr(data, i, length+i);
function _substr(str, i, j, out="") = (i==j) ? out : str(str[i], _substr(str, i+1, j, out));

function strcat(v, car="") = _strcat(v, len(v)-1, car, 0);
function _strcat(v, i, car, s) = (i==s ? v[i] : str(_strcat(v, i-1, car, s), str(car,v[i]) ));