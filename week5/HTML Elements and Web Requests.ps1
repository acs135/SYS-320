$scraped_page = Invoke-WebRequest http://localhost/ToBeScraped.html

echo "9. get the link count"
$scraped_page.Links.Count

echo "10. get the links as html elements"
$scraped_page.Links

echo "11. get the links and display only the url and its text"
$scraped_page.Links | Select-Object outerText, href

echo "12. get outer text of every element with the tag h2"
$h2s=$scraped_page.ParsedHtml.body.getElementsByTagName("h2") | Select-Object outerText

$h2s

echo "13. print innerText of every div element that has the class as 'div-1'"
$divs1=$scraped_page.ParsedHtml.body.getElementsByTagName("div") | Where-Object {
$_.className -match "div-1" } | select innerText

$divs1