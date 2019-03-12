<?php

$CIRCLE_URL = 'https://circleci.com/api/v1.1';

// Sanitize the user's input; don't want them to be able to do anything too dirty...
if (!preg_match("/^[A-Za-z0-9-_]+/", $_GET['namespace']) || !preg_match("/^[A-Za-z0-9-_]+/", $_GET['project']) || !preg_match("/^[A-Za-z0-9-_\.]+/", $_GET['file'])) {
	die('Invalid input');
}

// Send a header to CircleCI telling them to give us json, instead of whatever they want.
$options = array('http' => array('method' => 'GET', 'header' => "Accept: content/json\r\nUser-Agent: cpprograms_circle_toy\r\n"));
$context = stream_context_create($options);

// Make a request to the CircleCI API (v1.1) for this information. It seems no authentication is required, so none is configured.
$url = $CIRCLE_URL.'/project/github/'.$_GET['namespace'].'/'.$_GET['project'].'/latest/artifacts';
$data = file_get_contents($url, false, $context);
$val = json_decode($data, true);

// Go through each artifact returned, and compare it with the file the user requested. If the end of the file path matches the 
// input to $_GET['file'], redirect to the full url for this file. Else, die.
foreach ($val as $obj) {
	if (substr_compare($obj['path'], $_GET['file'], strlen($obj['[path']) - strlen($_GET['file']), strlen($_GET['file'])) === 0) {
		header('Location: ' . $obj['url']);
		die();
	}
}
die('Not found');
?>
