param([string]$BaseUrl = 'http://localhost/attendance')
$ErrorActionPreference = 'Stop'
$BaseUrl = $BaseUrl.TrimEnd('/')
$results = [System.Collections.Generic.List[string]]::new()
function Check([string]$Name, [string]$Html, [string]$Expected) {
    if (-not $Html.Contains($Expected)) { throw "FAIL: $Name; expected $Expected" }
    $results.Add("PASS: $Name")
}
$submissionHtml = (Invoke-WebRequest "$BaseUrl/").Content
Check 'Submission form' $submissionHtml 'name="studentId"'
Check 'Seat input' $submissionHtml 'name="seatId"'
Check 'Attendee link' $submissionHtml 'href="Attend"'
$r = (Invoke-WebRequest "$BaseUrl/Attend?studentId=LABTEST002&seatId=B2").Content
Check 'GET sign-in' $r 'LABTEST002:B2 is recorded:'
$r = (Invoke-WebRequest "$BaseUrl/Attend" -Method Post -Body @{studentId='LABTEST001';seatId='A1'}).Content
Check 'POST sign-in' $r 'LABTEST001:A1 is recorded:'
$r = (Invoke-WebRequest "$BaseUrl/Attend").Content
Check 'List first record' $r 'LABTEST001 : A1'
Check 'List second record' $r 'LABTEST002 : B2'
Check 'List return link' $r 'Attendance Submission'
$r = (Invoke-WebRequest "$BaseUrl/Attend?studentId=&seatId=X").Content
Check 'Empty student id' $r 'Student Id can not be blank'
$r = (Invoke-WebRequest "$BaseUrl/Attend?studentId=%20%20&seatId=X").Content
Check 'Whitespace student id' $r 'Student Id can not be blank'
$r = (Invoke-WebRequest "$BaseUrl/Attend?studentId=LABTEST001&seatId=C3").Content
Check 'Duplicate id confirmation' $r 'LABTEST001:C3 is recorded:'
$r = (Invoke-WebRequest "$BaseUrl/Attend").Content
Check 'Duplicate id replaces seat' $r 'LABTEST001 : C3'
if ($r.Contains('LABTEST001 : A1')) { throw 'FAIL: stale duplicate record' }
$r = (Invoke-WebRequest "$BaseUrl/Attend?studentId=%20LABTEST003%20&seatId=%20D4%20").Content
$r = (Invoke-WebRequest "$BaseUrl/Attend").Content
Check 'Input trimming' $r 'LABTEST003 : D4'
$r = (Invoke-WebRequest "$BaseUrl/Attend?studentId=LABTEST004").Content
$r = (Invoke-WebRequest "$BaseUrl/Attend").Content
Check 'Missing seat accepted' $r 'LABTEST004 : <br>'
if ($r.Contains(' : X<br>')) { throw 'FAIL: blank id was stored' }
$results
