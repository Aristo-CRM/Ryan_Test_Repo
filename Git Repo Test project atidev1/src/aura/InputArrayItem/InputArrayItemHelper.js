({
	trackChanges : function(helper, from, to) {
		var changes = {};
		//debugger;
		for (var key in to) {
			if (Array.isArray(to[key])) 
				; // skip comparing array's as these are not used (yet) for user input
			else if (typeof to[key] === "object") {
				var subChanages = helper.trackChanges(helper, from && from[key], to[key]);
				if (subChanages) changes[key] = subChanages;
			} else if (from && from[key] !== undefined) {
				var a = to[key], b = from[key];

				if (a == undefined || a == '') a = null;
				if (b == undefined || b == '') b = null;
				if (a != b) changes[key] = !a ? '' : a;
            } else {
                return true;
            }
		}

		for (var key in changes) {
			// if values in changes-object, add the Id as well if available
			//if (from['Id'] && !changes['Id']) changes['Id'] = from['Id'];
			return changes;
		}

		return null;
	}
})