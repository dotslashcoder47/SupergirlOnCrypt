param([string]$mode, [string]$path = "python")

function banner() {
    Clear-Host;
    Write-Host -NoNewline "
       **************************
    .*##*:*####***:::**###*:######*.
   *##: .###*            *######:,##*
 *##:  :####:             *####*.  :##:
  *##,:########**********:,       :##:
   .#########################*,  *#*
     *#########################*##:
       *##,        ..,,::**#####:
        ,##*,*****,        *##*
          *#########*########:
            *##*:*******###*
             .##*.    ,##*
               :##*  *##,
                 *####:
                   :,
When I was a child, my planet, Krypton, was dying. I was sent to Earth to protect my cousin. 
But my pod got knocked off-course, and by the time I got here, my cousin had already grown up and become...
"
Write-Host -NoNewline -ForegroundColor Red "Superman"
Write-Host -NoNewline ". 
And so, I hid my powers, until recently when an accident forced me to reveal myself to the world. 
    
To most people, I am an assistant at " 
Write-Host -NoNewline -ForegroundColor Green "CatCo Worldwide Media"
Write-Host -NoNewline ". 
But in secret, I work with my adoptive sister for the " 
Write-Host -NoNewline -ForegroundColor Yellow "D.E.O"
Write-Host -NoNewline ". to protect my city from alien life 
and anyone else that means to cause it " 
Write-Host -NoNewline -ForegroundColor Red "harm"
Write-Host ".`n"
Write-Host -NoNewline "`tI am "
Write-Host -NoNewline -ForegroundColor Red "SUPERGIRL"
Write-Host -ForegroundColor Yellow "ONCRYPT"
Write-Host -NoNewline "`t   Version "
Write-Host -ForegroundColor Cyan "0.0.1`n"
}

function success {
    Write-Host  "[*] $args" -ForegroundColor Green
}
function error {
    Write-Host  "[!] $args" -ForegroundColor Red
}
function warning {
    Write-Host  "[!] $args" -ForegroundColor Yellow
}
function info {
    Write-Host  "[-] $args" -ForegroundColor Cyan
}

function setupMode {
    success "Entering Setup"
    info "Installing virtualenv..."
    Start-Process -FilePath "pip" -ArgumentList "install virtualenv"  -NoNewWindow -wait;
    success "Done"
    if (Test-Path .\venv -PathType Any) {
        info "venv already exists"
        $caption = "Choose Action";
        $message = "Should we delete the venv and recreate it?";
        $no = new-Object System.Management.Automation.Host.ChoiceDescription "&No","No";
        $yes = new-Object System.Management.Automation.Host.ChoiceDescription "&Yes","Yes";
        $choices = [System.Management.Automation.Host.ChoiceDescription[]]($no,$yes);
        $answer = $host.ui.PromptForChoice($caption,$message,$choices,0)
        
        switch ($answer){
            0 {
                info "Ok, skipping"; 
                break
            }
            1 {
                info "Recreating venv..."
                Remove-Item -Recurse -Force .\venv\
                Start-Process -FilePath "virtualenv" -ArgumentList "-p $path venv"  -NoNewWindow -wait 2>&1;
                success "Done"
                break
            }
        }
    } else {
        info "Creating venv..."
        Start-Process -FilePath "virtualenv" -ArgumentList "-p $path venv"  -NoNewWindow -wait 2>&1;
        success "Done"
    }
   
}

function buildMode {

}

banner;
if (!$mode.CompareTo("setup")) {
    setupMode;
} elseif(!$mode.CompareTo("build")) {
    buildMode;
} else {
    error "Unknown Mode: $mode";
}
