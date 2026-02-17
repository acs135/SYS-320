function gatherClasses(){
    $page = Invoke-WebRequest -TimeoutSec 2 http://localhost/Courses2026SP.html

    $trs=$page.ParsedHtml.body.getElementsByTagName("tr")

    $FullTable = @()
    for($i=1; $i -lt $trs.length; $i++) {
        $tds = $trs.item($i).getElementsByTagName("td")

        $Times = $tds[5].innerText.split("-")
        
        $FullTable += [PSCustomObject]@{"Class Code" = $tds.item(0).innerText
                                        "Title" = $tds.item(1).innerText
                                        "Days" = $tds.item(4).innerText
                                        "Time Start" = $Times[0]
                                        "Time End" = $Times[1]
                                        "Instructor" = $tds.item(6).innerText
                                        "Location" = $tds.item(9).innerText
                                        }
    }
    $FullTable
}

function daysTranslator($FullTable){
        foreach ($row in $FullTable){
            $days = @()

            switch -Regex ($row.Days) {
                "TH" {$days += "Thursday"}
                "M" {$days += "Monday"}
                "W" {$days += "Wednesday"}
                "F" {$days += "Friday"}
                "T(?!H)" {$days += "Tuesday"}
            }

            $row.Days = $days -join ", "
        }
        $FullTable
    }