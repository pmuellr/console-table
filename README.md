<!-- Licensed under the Apache License, Version 2.0. See footer for details -->

console-table
=============

-- NOT READY FOR PRIME TIME --
==============================

An implementation of `console.table()` in plain ole text.

For more info, see:

* [FireBug Console API](http://getfirebug.com/wiki/index.php/Console_API#console.table.28data.5B.2C_columns.5D.29)
* [Jan Odvarko's blog post](http://www.softwareishard.com/blog/firebug/tabular-logs-in-firebug/)
* [the WebKit bug](https://bugs.webkit.org/show_bug.cgi?id=38664)
* [Patrick Mueller's paper](http://muellerware.org/papers/console-table.html)

node API
--------

Use console-table as a node package:

    consoleTable = require("console-table")
    consoleTable(someObject)
    
or if you don't mind monkey-patching `console`:

    console.table = require("console-table")
    console.table(someObject)

browser API
-----------

include the following script in your HTML:

    <script src="path-to/console-table.js"></script>
    
That will add a `table` function to `console`, then use it as:

    console.table(someObject)

The browser version of `console-table.js` is in the `lib-browser`
directory.

building and testing
--------------------

See the `Makefile` and the `.wr` files.

<!--
#-------------------------------------------------------------------------------
# Copyright 2012 Patrick Mueller
# 
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
# 
#    http://www.apache.org/licenses/LICENSE-2.0
# 
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#-------------------------------------------------------------------------------
-->
