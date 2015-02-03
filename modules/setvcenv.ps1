# powershell script for create running env for visual c++
# Author: Changjiang Yang
#

Param (
	[string]$userpath,
	[string]$comparch,
	[string]$conftypes,
	[string]$workdir,
	[string]$envars
)

#region Set of functions
function XmlWritePropertyGroup($conf, $arch) {
$xmlWriter.WriteStartElement('PropertyGroup')
$XmlWriter.WriteAttributeString('Condition', "'`$(Configuration)|`$(Platform)'=='$conf|$arch'")
$xmlWriter.WriteElementString('LocalDebuggerEnvironment', $PathStr)
$xmlWriter.WriteElementString('DebuggerFlavor', 'WindowsLocalDebugger')
if($workdir) {
	$xmlWriter.WriteElementString('LocalDebuggerWorkingDirectory', $workdir)
}
$xmlWriter.WriteEndElement()
}
#endregion

##### Main() #######
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

foreach ($conf in $conftypes -split ';' ) {
	XmlWritePropertyGroup $conf $comparch
}

# close the "Project" node:
$xmlWriter.WriteEndElement()

# finalize the document:
$xmlWriter.WriteEndDocument()
$xmlWriter.Flush()
$xmlWriter.Close()
