Clear-Host
$config_lines = [IO.File]::ReadAllLines("$PSScriptRoot\settings.cfg")

function generate_vimrc (
    [boolean]$add_runtime_path,
    [string]$scripts_folder,
    [string]$config_folder,
    [String[]]$sources,
    [string]$file,
    [string]$line_prefix = '',
    [string]$path_separator = "\"
) {
    $result = ""
    if ($add_runtime_path) {
        $result = $line_prefix + "let &runtimepath .=', $scripts_folder$path_separator'`n"
    }
    $result = $result + $line_prefix + "nnoremap <leader>ss :source $config_folder$path_separator.$file<cr>"
    Foreach ($source in $sources) {
        $result = $result + "`n" + $line_prefix + "source $scripts_folder$path_separator$source"
    }
    $result + "`n"
}

function generate_shell_conditional_vimrc(
    [boolean]$add_runtime_path,
    [string]$scripts_folder,
    [string]$config_folder,
    [String[]]$sources,
    [string]$file
) {
    $prefix = '    '
    $shell_scripts_folder = $scripts_folder -replace "\\|^", "/" -replace ":", ""
    $shell_config_folder = $config_folder -replace "\\|^", "/" -replace ":", ""
    
    $shell = generate_vimrc $add_runtime_path `
        $shell_scripts_folder `
        $shell_config_folder `
        $sources `
        $file `
        $prefix  `
        "/"
    $cmd = generate_vimrc $add_runtime_path `
        $scripts_folder `
        $config_folder `
        $sources `
        $file `
        $prefix

    $result = $result + 'if !empty($SHELL)' + "`n"
    $result = $result + $shell
    $result = $result + "else`n"
    $result = $result + $cmd
    $result = $result + "endif`n"
    $result
}

Foreach ($line in $config_lines) {
    $result = ""
    #get line parts
    $line_parts = $line.Split("{=}")
    $file = $line_parts[0]
    $configuration_vales = $line_parts[1].Split("{|}")
    #get configurations values
    $sources = $configuration_vales[0].Split("{,}")
    $add_runtime_path = [System.Convert]::ToBoolean($configuration_vales[1])
    $add_shell_script_condition = [System.Convert]::ToBoolean($configuration_vales[2])
    #----
    if ($add_shell_script_condition) {
        $result = generate_shell_conditional_vimrc $add_runtime_path $PSScriptRoot $env:userprofile $sources $file 
    }
    else {
        $result = generate_vimrc $add_runtime_path $PSScriptRoot $env:userprofile $sources $file 
    }

    $result | Set-Content "$env:userprofile\.$file"

    $stream = [IO.File]::OpenWrite("$env:userprofile\.$file")
    $stream.SetLength($stream.Length - 2)
    $stream.Close()
    $stream.Dispose()

    Write-Output ">>> $env:userprofile\.$file >>>>>>"
    Write-Output "-----------------------------"
    Get-Content "$env:userprofile\.$file"
    Write-Output "-----------------------------"
    Write-Output "<<<<"
}


