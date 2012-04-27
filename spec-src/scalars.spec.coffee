### Licensed under the Apache License, Version 2.0. See footer for details ###

specHelpers = new(require "./spec-helpers")

#-------------------------------------------------------------------------------
describe "console.table(scalar)", ->

    #---------------------------------------------------------------------------
    beforeEach -> specHelpers.beforeEach @
    afterEach  -> specHelpers.afterEach  @
    
    #---------------------------------------------------------------------------
    it "should handle console.table(null)", ->
        console.table null
        
        expect(specHelpers.lines).toEqualLines """
            | value |
            ---------
            | null  |
        """
        
    #---------------------------------------------------------------------------
    it "should handle console.table(undefined)", ->
        console.table undefined

        expect(specHelpers.lines).toEqualLines """
            | value |
            ---------
            |       |
        """
        
    #---------------------------------------------------------------------------
    it "should handle console.table('x')", ->
        console.table 'x'

        expect(specHelpers.lines).toEqualLines """
            | value |
            ---------
            | x     |
            """
        
    #---------------------------------------------------------------------------
    it "should handle console.table(1)", ->
        console.table 1

        expect(specHelpers.lines).toEqualLines """
            | value |
            ---------
            |     1 |
        """
        
    #---------------------------------------------------------------------------
    it "should handle console.table(false)", ->
        console.table false
        
        expect(specHelpers.lines).toEqualLines """
            | value |
            ---------
            | false |
        """
        
    #---------------------------------------------------------------------------
    it "should handle console.table(function)", ->
        console.table ->
        
        expect(specHelpers.lines).toEqualLines """
            ||
        """
        
    #---------------------------------------------------------------------------
    it "should handle console.table(NaN)", ->
        console.table 1/'x'
        
        expect(specHelpers.lines).toEqualLines """
            | value |
            ---------
            | NaN   |
        """

    #---------------------------------------------------------------------------
    xit "should ...", ->
        console.table ->
        
        expect(specHelpers.lines).toEqualLines """
            ||
        """
        
        console.log line for line in specHelpers.lines

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