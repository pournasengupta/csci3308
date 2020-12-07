<?php

$to = 'pose9026@colorado.edu';
$message = 'This is the message.';
$subject = 'Insert Subject Here';
$headers = 'From: noreply@example.com' . "\r\n" . 
	'Reply-Top: pose9026@colorado.edu';

@mail($to, $subject, $message, $headers); 

?>
