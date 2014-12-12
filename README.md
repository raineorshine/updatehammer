# DEPRECATED
# Please use [npm-check-updates](https://github.com/tjunnone/npm-check-updates)

I am now a collaborator on npm-check-updates, which has been updated to include all of updatehammer's functionality.

---

Forcefully update all dependencies to latest versions and save to package.json

## Install

	$ npm install -g updatehammer

## Usage

	$ updatehammer

### Example

Start with some out-of-date packages:

	{
	  "dependencies": {
	    "ansi-styles": "^0.1.2",
	    "moment": "^1.7.2"
	  }
	}


	Package      Current  Wanted  Latest  Location
	ansi-styles    0.1.2   0.1.2   1.0.0  ansi-styles
	moment         1.7.2   1.7.2   2.5.1  moment

Run the updatehammer:

	$ updatehammer

	npm install ansi-styles@latest --save
	ansi-styles@1.0.0 node_modules/ansi-styles

	npm install moment@latest --save
	moment@2.5.1 node_modules/moment

	Successfully installed ansi-styles, moment

Now all our dependencies are at the latest:

	{
	  "dependencies": {
	    "ansi-styles": "^1.0.0",
	    "moment": "^2.5.1"
	  }
	}

### Advanced Usage

Only update packages whose name matches the given regular expression

	$ updatehammer -n ^gulp-

Only update packages whose version matches the given regular expression

	$ updatehammer -r ^[~^]

