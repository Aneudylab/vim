cls
$config_lines=[IO.File]::ReadAllLines("$PSScriptRoot\settings.cfg")

Foreach($line in $config_lines)
{
    $result = ""
    #get line parts
    $line_parts = $line.Split("{=}")
    $file=$line_parts[0]
    $configuration_vales=$line_parts[1].Split("{|}")
    #get configurations values
    $sources=$configuration_vales[0].Split("{,}")
    $add_runtime_path=[System.Convert]::ToBoolean($configuration_vales[1])
    #----
    if ($add_runtime_path)
    {
        $result = "let &runtimepath .=', $PSScriptRoot'`n"
    }
    $result = $result+"nnoremap <leader>ss :source $env:userprofile\.$file<cr>"
    Foreach($source in $sources)
    {
        $result= $result + "`nsource $PSScriptRoot\$source"
    }

    $result + "`n" | Set-Content "$env:userprofile\.$file"

    $stream = [IO.File]::OpenWrite("$env:userprofile\.$file")
    $stream.SetLength($stream.Length - 2)
    $stream.Close()
    $stream.Dispose()

    echo ">>> $env:userprofile\.$file >>>>>>"
    echo "-----------------------------"
    cat "$env:userprofile\.$file"
    echo "-----------------------------"
    echo "<<<<"
}


