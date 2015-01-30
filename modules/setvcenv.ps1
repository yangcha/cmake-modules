# powershell script for create running env for visual c++
# Author: Changjiang Yang
# Copyright (c) 2015, Changjiang Yang
# All rights reserved.
# 
# Redistribution and use in source and binary forms, with or without
# modification, are permitted provided that the following conditions are met:
# 
# * Redistributions of source code must retain the above copyright notice, this
#   list of conditions and the following disclaimer.
# 
# * Redistributions in binary form must reproduce the above copyright notice,
#   this list of conditions and the following disclaimer in the documentation
#   and/or other materials provided with the distribution.
# 
# THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS"
# AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
# IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
# DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE LIABLE
# FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL
# DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR
# SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER
# CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY,
# OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE
# OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.

$encoding = [System.Text.Encoding]::UTF8
# this is where the document will be saved:
$Path = $args[0]
# get an XMLTextWriter to create the XML
$XmlWriter = New-Object System.XMl.XmlTextWriter($Path,$encoding)
 
# choose a pretty formatting:
$xmlWriter.Formatting = 'Indented'
$xmlWriter.Indentation = 2
$XmlWriter.IndentChar = ' '
 
# write the header
$xmlWriter.WriteStartDocument()
 
# create root element "Project" and add some attributes to it
$xmlWriter.WriteStartElement('Project')
$XmlWriter.WriteAttributeString('ToolsVersion', '12.0')
$XmlWriter.WriteAttributeString('xmlns', 'http://schemas.microsoft.com/developer/msbuild/2003')

$PathStr = 'PATH=' + ($args[1..$args.length] -join ';') + ';%PATH%'
 
$xmlWriter.WriteStartElement('PropertyGroup')
$XmlWriter.WriteAttributeString('Condition', "'`$(Configuration)|`$(Platform)'=='Debug|x64'")
$xmlWriter.WriteElementString('LocalDebuggerEnvironment', $PathStr)
$xmlWriter.WriteElementString('DebuggerFlavor', 'WindowsLocalDebugger')
$xmlWriter.WriteEndElement()

$xmlWriter.WriteStartElement('PropertyGroup')
$XmlWriter.WriteAttributeString('Condition', "'`$(Configuration)|`$(Platform)'=='Release|x64'")
$xmlWriter.WriteElementString('LocalDebuggerEnvironment', $PathStr)
$xmlWriter.WriteElementString('DebuggerFlavor', 'WindowsLocalDebugger')
$xmlWriter.WriteEndElement()
 
# close the "Project" node:
$xmlWriter.WriteEndElement()
 
# finalize the document:
$xmlWriter.WriteEndDocument()
$xmlWriter.Flush()
$xmlWriter.Close()
