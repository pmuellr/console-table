### Licensed under the Apache License, Version 2.0. See footer for details ###

_ = require "underscore"

#-------------------------------------------------------------------------------
consoleTable = (object) ->
    grid = generateGrid object
    
    matrix  = grid.getTextCells()
    columns = grid.getColumns()
    
    logger = consoleTable.logger || (line) -> console.log line

    if !matrix.length || !matrix[0].length
        logger "||"
        return
    
    # print columns
    
    columnNames = []
    for column in columns
        name = column.name
        if column.alignLeft
            name = alignLeft(name, column.width)
        else
            name = alignRight(name, column.width)
        
        columnNames.push name
        
    columnNames = columnNames.join " | "
    columnNames = "| #{columnNames} |"
    logger columnNames
    
    # print separator
    
    line = alignLeft "", columnNames.length
    line = line.replace(/\s/g, "-")
    logger line
    
    # print cells
        
    for row in matrix
        line = row.join " | "
        line = "| #{line} |"

        logger line

#-------------------------------------------------------------------------------
generateGrid = (object) ->
    grid = new Grid
    
    rowObject = {}
    
    if _.isArray object
        for element in object
            if isScalar element
                rowObject["{value}"] = element
                
            else if _.isArray element
                cellIndex = 0
                for cell in element
                    rowObject[cellIndex++] = cell
                    
            else
                rowObject = element
                
    else if _.isObject object || _.isFunction object
        for key, value of object
            rowObject = {key, value}
                
    else
        rowObject = 
            value: toString(object)
    
    grid.addRow rowObject
    
    grid
    
#-------------------------------------------------------------------------------
class Grid 

    #---------------------------------------------------------------------------
    constructor: ->
        @rows     = 0
        @columns  = []

    #---------------------------------------------------------------------------
    addRow: (object) ->
        for key, val of object
            continue if _.isFunction val
            
            column = @_getColumn(key)
            
            column.addCell @rows, val
            
        @rows++

    #---------------------------------------------------------------------------
    getTextCells: ->
        result = []
    
        for i in [0...@rows]
            row = []
            
            for column in @columns
                row.push column.getCell(i)
            
            result.push row
            
        result

    #---------------------------------------------------------------------------
    getColumns: ->
        @columns
    
    #---------------------------------------------------------------------------
    _getColumn: (label) ->
        for column in @columns
            return column if column.name == label
            
        column = new Column label
        
        if label == "<value>"
            @columns.unshift column
        else
            @columns.push column
            
        column
    
#-------------------------------------------------------------------------------
class Column

    #---------------------------------------------------------------------------
    constructor: (@name) ->
        @cells     = []
        @alignLeft = null
        @width     = @name.length
    
    #---------------------------------------------------------------------------
    addCell: (rowIndex, object) ->
    
        if not _.isNumber(object)
            @alignLeft = true
        else if @alignLeft == null
            @alignLeft = false
        
        text = "#{object}"

        @cells[rowIndex] = text
        
        if text.length > @width
            @width = text.length

    #---------------------------------------------------------------------------
    getCell: (rowIndex) ->
        cell = @cells[rowIndex]
        
        cell = "" if cell == undefined
        
        if @alignLeft
            return alignLeft(cell, @width) 
        else
            return alignRight(cell, @width)
        
#-------------------------------------------------------------------------------
alignLeft = (string, width) ->
    while string.length < width
        string = "#{string} "
        
    string
    
#-------------------------------------------------------------------------------
alignRight = (string, width) ->
    while string.length < width
        string = " #{string}"

    string    
    
#-------------------------------------------------------------------------------
isScalar = (object) ->
    return false if _.isObject   object
    return false if _.isFunction object
    return true

#-------------------------------------------------------------------------------
toString = (object) ->
    return "{function}" if _.isFunction object
    return ""           if object == undefined
    return "null"       if object == null
    return object.toString()

#-------------------------------------------------------------------------------
installInBrowser = (func) ->
    return if typeof window         == "undefined"
    return if typeof window.console == "undefined"
    
    return if window.console.table
    
    window.console.table = func
    
#-------------------------------------------------------------------------------
installInCJS = (func) ->
    return if typeof module         == "undefined"
    return if typeof module.exports == "undefined"
    
    module.exports = func

#-------------------------------------------------------------------------------
installInBrowser(consoleTable)
installInCJS(consoleTable)

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
