### Licensed under the Apache License, Version 2.0. See footer for details ###

console.table = require "../lib/console-table"
SpecHelpers   = require "./spec-helpers"
    
specHelpers = new SpecHelpers

#-------------------------------------------------------------------------------
describe "console.table(object)", ->

    #---------------------------------------------------------------------------
    beforeEach -> specHelpers.beforeEach @
    afterEach  -> specHelpers.afterEach  @
    
    #---------------------------------------------------------------------------
    it "should handle empty objects", ->
        console.table {}
        
        lines = specHelpers.getLines()
        
        expect(lines).toEqualArray """
            ||
        """
        
    #---------------------------------------------------------------------------
    it "should handle simple objects", ->
        console.table
            a: 1
            b: 2
            c: 101
        
        lines = specHelpers.getLines()
        
        expect(lines).toEqualArray """
        """
        
        console.log line for line in lines
        
    #---------------------------------------------------------------------------
    xit "should ...", ->
        console.table null
        
        lines = specHelpers.getLines()
        
        expect(lines).toEqualArray """
        """
        
        console.log line for line in lines
        
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