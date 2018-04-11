# powershell script for create running env for visual c++
# Author: Changjiang Yang, 2015
## Distributed under the BSD License: 
## http://choosealicense.com/licenses/bsd-2-clause/


Param (
	[string]$userpath,
	[string]$comparch,
	[string]$conftypes,
	[string]$workdir,
	[string]$cmdargs,
	[string]$envars,
	[string]$toolsversion
)

$encoding = [System.Text.Encoding]::UTF8
$XmlWriter = New-Object System.XMl.XmlTextWriter($userpath,$encoding)
# choose a pretty formatting:
$xmlWriter.Formatting = 'Indented'
$xmlWriter.Indentation = 2
$XmlWriter.IndentChar = ' '

# write the header
$xmlWriter.WriteStartDocument()

# create root element "Project" and add some attributes to it
$xmlWriter.WriteStartElement('Project')
$XmlWriter.WriteAttributeString('ToolsVersion', $toolsversion)
$XmlWriter.WriteAttributeString('xmlns', 'http://schemas.microsoft.com/developer/msbuild/2003')

$PathStr = 'PATH=' + ($args -join ';') + ';%PATH%'
if($envars) {
	$PathStr = $PathStr + "`n" + ($envars -join ';')
}

$conftypes -split ';' | foreach {
	$xmlWriter.WriteStartElement('PropertyGroup')
	$XmlWriter.WriteAttributeString('Condition', "'`$(Configuration)|`$(Platform)'=='$_|$comparch'")
	$xmlWriter.WriteElementString('LocalDebuggerEnvironment', $PathStr)
	$xmlWriter.WriteElementString('DebuggerFlavor', 'WindowsLocalDebugger')
	if($workdir) {
		$xmlWriter.WriteElementString('LocalDebuggerWorkingDirectory', $workdir)
		}
	if($cmdargs) {
		$xmlWriter.WriteElementString('LocalDebuggerCommandArguments', $cmdargs)
		}
	$xmlWriter.WriteEndElement()
	}

# close the "Project" node:
$xmlWriter.WriteEndElement()

# finalize the document:
$xmlWriter.WriteEndDocument()
$xmlWriter.Flush()
$xmlWriter.Close()
