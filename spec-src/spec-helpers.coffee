### Licensed under the Apache License, Version 2.0. See footer for details ###

#-------------------------------------------------------------------------------
class SpecHelpers

    #---------------------------------------------------------------------------
    constructor: ->
        @lines  = []

    #---------------------------------------------------------------------------
    beforeEach: (suite) ->
        @lines  = []
        
        console.table = require "../lib/console-table"
        
        console.table.logger = (line) => @consoleLog(line)

        suite.addMatchers {toEqualLines}

    #---------------------------------------------------------------------------
    afterEach: (suite) ->
        console.table.logger = null
        @lines = null

    #---------------------------------------------------------------------------
    getLines: -> @lines

    #---------------------------------------------------------------------------
    consoleLog: (line) -> 
        @lines.push(line)

#-------------------------------------------------------------------------------
trimBlanks = (string) ->
    string.replace /^\s+|\s+$/g, ""
    
#-------------------------------------------------------------------------------
toEqualLines = (expected) ->

    if typeof expected is "string"
        expected = trimBlanks(expected)
        expected = expected.split "\n"

    return false if @actual.length != expected.length
    
    for i in [0...@actual.length]
        aItem = @actual[i]
        eItem =  expected[i]
        
        return false if aItem != eItem
        
    return true

#-------------------------------------------------------------------------------
if typeof require == "undefined"
    window.SpecHelpers = SpecHelpers
else
    module.exports     = SpecHelpers

###
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
###
