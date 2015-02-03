# powershell script for create running env for visual c++
# Author: Changjiang Yang
#
#region Set of functions
function xmlwriteelements($mode) {

}

#endregion

Param (
	[string]$userpath,
	[string]$workdir,
	[string]$envars
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
$XmlWriter.WriteAttributeString('ToolsVersion', '12.0')
$XmlWriter.WriteAttributeString('xmlns', 'http://schemas.microsoft.com/developer/msbuild/2003')

$PathStr = 'PATH=' + ($args -join ';') + ';%PATH%'

if($envars) {
	$PathStr = $PathStr + "`n" + ($envars -join ';')
}

$xmlWriter.WriteStartElement('PropertyGroup')
$XmlWriter.WriteAttributeString('Condition', "'`$(Configuration)|`$(Platform)'=='Debug|x64'")
$xmlWriter.WriteElementString('LocalDebuggerEnvironment', $PathStr)
$xmlWriter.WriteElementString('DebuggerFlavor', 'WindowsLocalDebugger')
if($workdir) {
	$xmlWriter.WriteElementString('LocalDebuggerWorkingDirectory', $workdir)
}
$xmlWriter.WriteEndElement()

$xmlWriter.WriteStartElement('PropertyGroup')
$XmlWriter.WriteAttributeString('Condition', "'`$(Configuration)|`$(Platform)'=='Release|x64'")
$xmlWriter.WriteElementString('LocalDebuggerEnvironment', $PathStr)
$xmlWriter.WriteElementString('DebuggerFlavor', 'WindowsLocalDebugger')
if($workdir) {
	$xmlWriter.WriteElementString('LocalDebuggerWorkingDirectory', $workdir)
}
$xmlWriter.WriteEndElement()

# close the "Project" node:
$xmlWriter.WriteEndElement()

# finalize the document:
$xmlWriter.WriteEndDocument()
$xmlWriter.Flush()
$xmlWriter.Close()
