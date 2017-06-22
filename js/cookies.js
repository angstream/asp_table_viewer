// name is cookie name
// value is cookie value
// days is life time of it
function setCookie(name,value,days) {
	var date = new Date();
	date.setTime(date.getTime() + ( 1000 * 60 * 60 * 24 * parseInt(days)));

	parts = getCookie(name);
	if (!parts || parts == 'undefined') {
	    $.cookie(name, value, {path: '/', expires: date });
	    return;
	}
	
	
	parts = parts.split(",");
	
	
	if (parts.length > 0) {
	    // search same item and delete
	    // if already have , delete it
	    for (var i=0; i<parts.length; i++) {
	        if (value == parts[i]) {
	            parts.splice(i, 1);
	        }
	    }
	    parts.push(value);

	    // if over 50, just do 50
	    newparts = [];
	    if (parts.length > 50) {
	        for (var i=parts.length - 50; i<parts.length; i++) {
	            newparts.push(parts[i]);
	        }
	    }
	    else {
	        newparts = parts;
	    }
	   setCookie(name, newparts.join(","), {path: '/', expires: date });
	}
	else {
	    setCookie(name, $(this).attr("id"), {path: '/', expires: date });
}};


function setCookie(cname, cvalue, exdays) {
    var d = new Date();
    d.setTime(d.getTime() + (exdays * 24 * 60 * 60 * 1000));
    var expires = "expires="+d.toUTCString();
    document.cookie = cname + "=" + cvalue + ";" + expires + ";path=/";
}

function setCookie2(cname, cvalue, exdays) {
    var d = new Date();
    d.setTime(d.getTime() + (exdays * 24 * 60 * 60 * 1000));
	var expires = "expires="+d.toUTCString();
	 
	var parts = getCookie(cname);
	if (!parts || parts == 'undefined') {
	    document.cookie = cname + "=" + cvalue + ";" + expires + ";path=/";
	    return;
	}
	//console.log("parts1:" + parts);	
	parts = parts.split(",");	
	//console.log("parts2:" + parts);	
	if (parts.length > 0) {	    
	    for (var i=0; i<parts.length; i++) {
	        if (cvalue == parts[i]) {
	            parts.splice(i, 1);
	        }
	    }
	   parts.push(cvalue);	 
	}	
	if (parts.length>20){
		parts.splice(0,1);
	}
	
    document.cookie = cname + "=" + parts.join(",") + ";" + expires + ";path=/";
}


function setCookie3(cname, cvalue, exdays, maxLimit) {
	maxLimit = maxLimit || 20;
    var d = new Date();
    d.setTime(d.getTime() + (exdays * 24 * 60 * 60 * 1000));
	var expires = "expires="+d.toUTCString();
	 
	var parts = getCookie(cname);
	if (!parts || parts == 'undefined') {
	    document.cookie = cname + "=" + cvalue + ";" + expires + ";path=/";
	    return;
	}
	//console.log("parts1:" + parts);	
	parts = parts.split(",");	
	//console.log("parts2:" + parts);	
	if (parts.length > 0) {	    
	    for (var i=0; i<parts.length; i++) {
	        if (cvalue == parts[i]) {
	            parts.splice(i, 1);
	        }
	    }
	   parts.push(cvalue);	 
	}	
	//first one out
	if (parts.length> maxLimit){
		parts.splice(0,1);
	}
	
    document.cookie = cname + "=" + parts.join(",") + ";" + expires + ";path=/";
}

function getCookie(cname) {
    var name = cname + "=";
    var ca = document.cookie.split(';');
    for(var i = 0; i < ca.length; i++) {
        var c = ca[i];
        while (c.charAt(0) == ' ') {
            c = c.substring(1);
        }
        if (c.indexOf(name) == 0) {
            return c.substring(name.length, c.length);
        }
    }
    return "";
}

function checkCookie() {
    var user = getCookie("username");
    if (user != "") {
        alert("Welcome again " + user);
    } else {
        user = prompt("Please enter your name:", "");
        if (user != "" && user != null) {
            setCookie("username", user, 365);
        }
    }
}
